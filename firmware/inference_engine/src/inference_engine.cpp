#include "config.hpp"
#include "error_handler.hpp"
#include "logger.hpp"
#include "performance_monitor.hpp"
#include "pl_interface.hpp"
#include "queue.hpp"
#include "tokenizer.hpp"
#include "types.hpp"

#include <atomic>
#include <chrono>
#include <cmath>
#include <cstring>
#include <fstream>
#include <iostream>
#include <memory>
#include <mutex>
#include <sstream>
#include <thread>
#include <unistd.h>
#include <vector>

Logger *g_logger = nullptr;
std::atomic<EngineStatus> g_engine_status(EngineStatus::IDLE);
std::mutex g_console_mutex;
Queue<Task, 100> g_task_queue;
Queue<Command, 10> g_command_queue;

enum class ComputeOp : uint8_t {
    CMP_NONE=0,CMP_Q=1,CMP_K=2,CMP_V=3,CMP_ATT_SCORES=4,
    CMP_ATT_VALUE=5,CMP_OUT_PROJ=6,CMP_FFN_W1=7,CMP_FFN_W2=8,CMP_LOGITS=9,
};

static const char *op_name(ComputeOp op) {
    switch(op){
    case ComputeOp::CMP_NONE:return"NONE";case ComputeOp::CMP_Q:return"Q";
    case ComputeOp::CMP_K:return"K";case ComputeOp::CMP_V:return"V";
    case ComputeOp::CMP_ATT_SCORES:return"ATT_SC";case ComputeOp::CMP_ATT_VALUE:return"ATT_V";
    case ComputeOp::CMP_OUT_PROJ:return"O_PROJ";case ComputeOp::CMP_FFN_W1:return"W1";
    case ComputeOp::CMP_FFN_W2:return"W2";case ComputeOp::CMP_LOGITS:return"LOGIT";
    default:return"?";
    }
}

static inline uint32_t pack_instr32(ComputeOp op,uint32_t layer,uint32_t head){
    return (static_cast<uint32_t>(op)&0xFu)|(layer&0xFFu)<<4|(head&0xFFu)<<12;
}

// Debug helpers
static std::string v4f(const double*v,int n,int m=4){
    std::ostringstream s;s<<"[";int sh=n<m?n:m;
    for(int i=0;i<sh;i++){if(i)s<<",";char b[24];snprintf(b,sizeof(b),"%.4f",v[i]);s<<b;}
    if(sh<n)s<<"...";s<<"]";return s.str();
}
static std::string v4i8(const int8_t*v,int n,int m=4){
    std::ostringstream s;s<<"[";int sh=n<m?n:m;
    for(int i=0;i<sh;i++){if(i)s<<",";s<<(int)v[i];}
    if(sh<n)s<<"...";s<<"]";return s.str();
}
static std::string v4i32(const int32_t*v,int n,int m=4){
    std::ostringstream s;s<<"[";int sh=n<m?n:m;
    for(int i=0;i<sh;i++){if(i)s<<",";s<<v[i];}
    if(sh<n)s<<"...";s<<"]";return s.str();
}
static double amax(const double*v,int n){double m=0;for(int i=0;i<n;i++){double a=fabs(v[i]);if(a>m)m=a;}return m;}
static std::string hex32(uint32_t v){char b[16];snprintf(b,sizeof(b),"0x%08X",v);return b;}
static std::string ms_str(std::chrono::steady_clock::time_point t0,std::chrono::steady_clock::time_point t1){
    return std::to_string((int)std::chrono::duration<double,std::milli>(t1-t0).count())+"ms";
}

// =============================================================================
// WeightLoader
// =============================================================================
class WeightLoader {
    PLInterface *pl; ErrorHandler *err; std::string weights_file;
    static constexpr size_t kWeightLoadChunkBytes = 32*1024*1024;
public:
    WeightLoader(PLInterface *p, ErrorHandler *e) : pl(p), err(e) {}
    void setWeightsFile(const std::string &f) { weights_file = f; }

    bool loadAllWeights(const ModelConfig &model_cfg, size_t max_bytes = 0) {
        LOG_INFO("Loading weights from " + weights_file);
        std::ifstream f(weights_file, std::ios::binary);
        if (!f) { err->setError(ErrorCode::FILE_NOT_FOUND, weights_file); return false; }
        f.seekg(0, std::ios::end);
        const size_t file_size = static_cast<size_t>(f.tellg()); f.seekg(0);
        size_t load_size = (max_bytes>0 && max_bytes<file_size) ? max_bytes : file_size;
        LOG_INFO("Loading " + std::to_string(load_size/1024) + " KB of " + std::to_string(file_size/1024/1024) + " MB");
        std::vector<uint8_t> chunk(kWeightLoadChunkBytes);
        size_t ddr_offset = 0;
        while (f && ddr_offset < load_size) {
            size_t to_read = std::min(load_size - ddr_offset, chunk.size());
            f.read(reinterpret_cast<char*>(chunk.data()), to_read);
            size_t bytes_read = f.gcount();
            if (bytes_read == 0) break;
            if (!pl->writeDDR(DmaBufType::BUF0, static_cast<uint32_t>(ddr_offset), chunk.data(), bytes_read)) {
                err->setError(ErrorCode::HARDWARE_FAULT, "DDR write failed at " + std::to_string(ddr_offset));
                return false;
            }
            ddr_offset += bytes_read;
        }
        LOG_INFO("Loaded " + std::to_string(ddr_offset) + " bytes into BUF0");
        return true;
    }

    bool configureAddresses(const ModelConfig &model_cfg, const MemoryLayout &mem) {
        if (!model_cfg.validate()) { err->setError(ErrorCode::CONFIG_ERROR, "Invalid config"); return false; }
        if (!mem.isAligned()) { err->setError(ErrorCode::CONFIG_ERROR, "Addresses not 64B aligned"); return false; }
        pl->beginConfig();
        pl->writeReg64(RegBus::ADDR, AddrReg::WEIGHTS_BASE_LO, pl->getDDRBaseAddr(DmaBufType::BUF0));
        pl->writeReg64(RegBus::ADDR, AddrReg::KV_CACHE_BASE_LO, pl->getDDRBaseAddr(DmaBufType::BUF1));
        pl->writeReg(PLReg::WQ_OFFSET,mem.wq_offset); pl->writeReg(PLReg::WK_OFFSET,mem.wk_offset);
        pl->writeReg(PLReg::WV_OFFSET,mem.wv_offset); pl->writeReg(PLReg::WO_OFFSET,mem.wo_offset);
        pl->writeReg(PLReg::W1_OFFSET,mem.w1_offset); pl->writeReg(PLReg::W2_OFFSET,mem.w2_offset);
        pl->writeReg(PLReg::K_CACHE_OFFSET,mem.k_cache_offset); pl->writeReg(PLReg::V_CACHE_OFFSET,mem.v_cache_offset);
        pl->writeReg(PLReg::WQ_BIAS_OFFSET,mem.wq_bias_offset); pl->writeReg(PLReg::WK_BIAS_OFFSET,mem.wk_bias_offset);
        pl->writeReg(PLReg::WV_BIAS_OFFSET,mem.wv_bias_offset); pl->writeReg(PLReg::WO_BIAS_OFFSET,mem.wo_bias_offset);
        pl->writeReg(PLReg::W1_BIAS_OFFSET,mem.w1_bias_offset); pl->writeReg(PLReg::W2_BIAS_OFFSET,mem.w2_bias_offset);
        pl->writeReg(PLReg::LN0_GAMMA_OFFSET,mem.ln0_gamma_offset); pl->writeReg(PLReg::LN1_GAMMA_OFFSET,mem.ln1_gamma_offset);
        pl->writeReg(PLReg::FINAL_NORM_GAMMA_OFFSET,mem.final_norm_gamma_offset);
        pl->writeReg(PLReg::LN0_BETA_OFFSET,mem.ln0_beta_offset);
        pl->writeReg(PLReg::LN1_BETA_OFFSET,mem.ln1_beta_offset);
        pl->writeReg(PLReg::FINAL_NORM_BETA_OFFSET,mem.final_norm_beta_offset);
        pl->writeReg(PLReg::LN0_EPS_OFFSET,mem.ln0_eps_offset); pl->writeReg(PLReg::LN1_EPS_OFFSET,mem.ln1_eps_offset);
        pl->writeReg(PLReg::FINAL_NORM_EPS_OFFSET,mem.final_norm_eps_offset);
        pl->writeReg(PLReg::WLOGIT_OFFSET,mem.wlogit_offset);
        pl->writeReg(PLReg::TOKEN_POSITION,0);
        pl->writeReg(PLReg::INSTR,0);
        pl->endConfig();
        if (err->hasError()) { LOG_ERROR("Config error:\n" + pl->dumpCtrlMem()); }
        return !err->hasError();
    }
};

// =============================================================================
// InferenceExecutor
// =============================================================================
class InferenceExecutor {
    PLInterface *pl; Tokenizer *tok; PerformanceMonitor *perf; ErrorHandler *err;
    ModelConfig model_cfg; uint32_t input_offset, output_offset, timeout_ms; bool debug_mode;
    std::vector<int8_t> embedding_table, pos_embedding_table;
    std::vector<float> embed_float, pos_float; bool use_float_embed = false;
    std::vector<std::vector<double>> wq_scale,wk_scale,wv_scale,wo_scale,w1_scale,w2_scale;
    std::vector<double> logit_scale;
    std::vector<std::vector<double>> bq_f,bk_f,bv_f,bo_f,b1_f,b2_f;
    std::vector<std::vector<int32_t>> bq_raw,bk_raw,bv_raw,bo_raw,b1_raw,b2_raw;
    std::vector<std::vector<double>> ln1_w_f,ln1_b_f,ln2_w_f,ln2_b_f;
    std::vector<double> fln_w_f,fln_b_f;
    std::vector<std::vector<double>> kv_k,kv_v;
    std::vector<int8_t> wlogit_i8;
    MemoryLayout mem_layout; bool matmul_mode_ready = false;
    uint64_t mm_calls = 0;

    static void ps_layernorm(const double*x,const double*g,const double*b,double*o,int n){
        double m=0;for(int i=0;i<n;i++)m+=x[i];m/=n;
        double v=0;for(int i=0;i<n;i++){double d=x[i]-m;v+=d*d;}v/=n;
        double inv=1.0/sqrt(v+1e-5);for(int i=0;i<n;i++)o[i]=g[i]*(x[i]-m)*inv+b[i];
    }
    static void ps_gelu(double*x,int n){
        const double c=sqrt(2.0/M_PI);
        for(int i=0;i<n;i++)x[i]=0.5*x[i]*(1.0+tanh(c*(x[i]+0.044715*x[i]*x[i]*x[i])));
    }
    static void ps_quantize_act(const double*x,int8_t*o,double&s,int n){
        double am=0;for(int i=0;i<n;i++){double a=fabs(x[i]);if(a>am)am=a;}
        if(am<1e-10)am=1e-10;s=am/127.0;
        for(int i=0;i<n;i++){int v=(int)round(x[i]/s);o[i]=(int8_t)(v<-127?-127:(v>127?127:v));}
    }
    static void ps_dequant(const int32_t*acc,double as,const double*ws,const double*bf,const int32_t*bq,double*o,int n){
        for(int i=0;i<n;i++){int64_t mr=(int64_t)acc[i]-(int64_t)bq[i];o[i]=(double)mr*as*ws[i]+bf[i];}
    }
public:
    InferenceExecutor(PLInterface*p,Tokenizer*t,PerformanceMonitor*pf,ErrorHandler*e,
        const ModelConfig&m,uint32_t in_off,uint32_t out_off,uint32_t tmo,bool dbg=false)
        :pl(p),tok(t),perf(pf),err(e),model_cfg(m),input_offset(in_off),output_offset(out_off),timeout_ms(tmo),debug_mode(dbg){}

    void setMemoryLayout(const MemoryLayout &mem){mem_layout=mem;}

    bool loadEmbeddingTable(const std::string &path) {
        size_t expected=(size_t)model_cfg.vocab_size*model_cfg.hidden_size;
        std::ifstream f(path,std::ios::binary);
        if(!f){err->setError(ErrorCode::FILE_NOT_FOUND,"Cannot open: "+path);return false;}
        f.seekg(0,std::ios::end);size_t fs=f.tellg();f.seekg(0);
        if(fs<expected){err->setError(ErrorCode::FILE_NOT_FOUND,"Too small");return false;}
        embedding_table.resize(expected);f.read(reinterpret_cast<char*>(embedding_table.data()),expected);
        LOG_INFO("Loaded embed table: "+std::to_string(model_cfg.vocab_size)+"x"+std::to_string(model_cfg.hidden_size));
        return true;
    }
    bool loadPositionEmbeddings(const std::string &path) {
        size_t expected=(size_t)model_cfg.context_length*model_cfg.hidden_size;
        std::ifstream f(path,std::ios::binary);
        if(!f){err->setError(ErrorCode::FILE_NOT_FOUND,"Cannot open: "+path);return false;}
        f.seekg(0,std::ios::end);size_t fs=f.tellg();f.seekg(0);
        if(fs<expected){err->setError(ErrorCode::FILE_NOT_FOUND,"Too small");return false;}
        pos_embedding_table.resize(expected);f.read(reinterpret_cast<char*>(pos_embedding_table.data()),expected);
        LOG_INFO("Loaded pos embed: "+std::to_string(model_cfg.context_length)+"x"+std::to_string(model_cfg.hidden_size));
        return true;
    }
    bool executeToken(uint32_t token_id,uint32_t token_position,uint32_t &out_token){
        perf->startGeneration();
        std::vector<int8_t>send_buf(model_cfg.stream_in_size);
        if(!lookupEmbedding(token_id,token_position,send_buf.data()))return false;
        if(!pl->streamInitRecv(output_offset,model_cfg.stream_out_size)){logPLStatus("recv fail");return false;}
        if(!pl->streamInitSend(input_offset,send_buf.data(),model_cfg.stream_in_size)){logPLStatus("send fail");return false;}
        uint32_t ctrl=CTRL_RESETN_BIT|CTRL_START_BIT;if(debug_mode)ctrl|=CTRL_DEBUG_MODE_BIT;
        pl->writeReg(PLReg::TOKEN_POSITION,token_position);pl->writeReg(PLReg::CONTROL,ctrl);usleep(10);
        pl->writeReg(PLReg::CONTROL,pl->readReg(PLReg::CONTROL)&~CTRL_START_BIT);
        if(!pl->streamWaitSend(timeout_ms)){logPLStatus("send timeout");pl->clearIRQ();return false;}
        if(!pl->waitDone(timeout_ms)){logPLStatus("done timeout");pl->clearIRQ();return false;}
        std::vector<uint8_t>recv_buf(model_cfg.stream_out_size,0);
        if(!pl->streamWaitRecv(output_offset,recv_buf.data(),model_cfg.stream_out_size,timeout_ms)){logPLStatus("recv timeout");pl->clearIRQ();return false;}
        out_token=recv_buf[0]|((uint32_t)recv_buf[1]<<8)|((uint32_t)recv_buf[2]<<16)|((uint32_t)recv_buf[3]<<24);
        pl->clearIRQ();perf->recordToken();perf->endGeneration();return true;
    }
    bool getEmbedding(uint32_t tid,uint32_t pos,int8_t*out){return lookupEmbedding(tid,pos,out);}

    bool loadFloatEmbeddings(const std::string &tp,const std::string &pp){
        LOG_DEBUG("loadFloatEmbeddings: tok="+tp+" pos="+pp);
        const uint32_t H=model_cfg.hidden_size;
        std::ifstream ft(tp,std::ios::binary),fp(pp,std::ios::binary);
        if(!ft||!fp){LOG_WARN("Float embed files not found");return false;}
        embed_float.resize((size_t)model_cfg.vocab_size*H);
        ft.read(reinterpret_cast<char*>(embed_float.data()),embed_float.size()*sizeof(float));
        pos_float.resize((size_t)model_cfg.context_length*H);
        fp.read(reinterpret_cast<char*>(pos_float.data()),pos_float.size()*sizeof(float));
        use_float_embed=true;
        LOG_INFO("Float embeds loaded: tok[0..2]={"+std::to_string(embed_float[0])+","+std::to_string(embed_float[1])+","+std::to_string(embed_float[2])+"}");
        return true;
    }

    bool loadMatmulModeParams(const std::string &model_dir){
        LOG_INFO("Loading matmul params from "+model_dir);
        const uint32_t H=model_cfg.hidden_size,FF=model_cfg.intermediate_size,V=model_cfg.vocab_size,NL=model_cfg.num_layers;
        const MemoryLayout &mem=mem_layout;
        std::string json_path=model_dir+"/quant_scales.json";
        std::ifstream jf(json_path);
        if(!jf){LOG_ERROR("Cannot open "+json_path);return false;}
        std::string json_str((std::istreambuf_iterator<char>(jf)),std::istreambuf_iterator<char>());
        LOG_DEBUG("  JSON: "+std::to_string(json_str.size())+" bytes");

        auto parse_array=[&](const std::string&key,std::vector<double>&out)->bool{
            std::string search="\""+key+"\"";size_t pos=json_str.find(search);
            if(pos==std::string::npos)return false;
            size_t start=json_str.find('[',pos),end=json_str.find(']',start);
            if(start==std::string::npos||end==std::string::npos)return false;
            std::string arr=json_str.substr(start+1,end-start-1);out.clear();size_t p=0;
            while(p<arr.size()){while(p<arr.size()&&(arr[p]==' '||arr[p]==','))p++;
                if(p>=arr.size())break;size_t e=p;while(e<arr.size()&&arr[e]!=','&&arr[e]!=' ')e++;
                out.push_back(atof(arr.substr(p,e-p).c_str()));p=e;}return true;};

        wq_scale.resize(NL);wk_scale.resize(NL);wv_scale.resize(NL);wo_scale.resize(NL);w1_scale.resize(NL);w2_scale.resize(NL);
        bq_f.resize(NL);bk_f.resize(NL);bv_f.resize(NL);bo_f.resize(NL);b1_f.resize(NL);b2_f.resize(NL);
        bq_raw.resize(NL);bk_raw.resize(NL);bv_raw.resize(NL);bo_raw.resize(NL);b1_raw.resize(NL);b2_raw.resize(NL);
        ln1_w_f.resize(NL);ln1_b_f.resize(NL);ln2_w_f.resize(NL);ln2_b_f.resize(NL);kv_k.resize(NL);kv_v.resize(NL);

        for(uint32_t ly=0;ly<NL;ly++){
            std::string pfx="layer"+std::to_string(ly)+".";
            bool ok=parse_array(pfx+"wq",wq_scale[ly])&&parse_array(pfx+"wk",wk_scale[ly])
                &&parse_array(pfx+"wv",wv_scale[ly])&&parse_array(pfx+"wo",wo_scale[ly])
                &&parse_array(pfx+"w1",w1_scale[ly])&&parse_array(pfx+"w2",w2_scale[ly]);
            if(!ok){LOG_ERROR("  Scale parse fail L"+std::to_string(ly));return false;}
            LOG_DEBUG("  L"+std::to_string(ly)+" scales: wq="+std::to_string(wq_scale[ly].size())
                +" wo="+std::to_string(wo_scale[ly].size())+" w1="+std::to_string(w1_scale[ly].size()));
            kv_k[ly].resize((size_t)model_cfg.context_length*H,0.0);
            kv_v[ly].resize((size_t)model_cfg.context_length*H,0.0);
        }
        if(!parse_array("lm_head",logit_scale)){LOG_ERROR("  lm_head parse fail");return false;}
        LOG_DEBUG("  logit_scale["+std::to_string(logit_scale.size())+"]");

        auto read_q16=[&](uint32_t off,uint32_t cnt,std::vector<double>&fo,std::vector<int32_t>&raw)->bool{
            raw.resize(cnt);fo.resize(cnt);
            if(!pl->readDDR(DmaBufType::BUF0,off,raw.data(),cnt*4))return false;
            for(uint32_t i=0;i<cnt;i++)fo[i]=(double)raw[i]/65536.0;return true;};
        auto read_q16_f=[&](uint32_t off,uint32_t cnt,std::vector<double>&fo)->bool{
            std::vector<int32_t>raw(cnt);fo.resize(cnt);
            if(!pl->readDDR(DmaBufType::BUF0,off,raw.data(),cnt*4))return false;
            for(uint32_t i=0;i<cnt;i++)fo[i]=(double)raw[i]/65536.0;return true;};

        LOG_DEBUG("  Reading biases/LN from DDR...");
        for(uint32_t ly=0;ly<NL;ly++){
            uint32_t b4=H*4,b41=FF*4,g4=H*4;
            read_q16(mem.wq_bias_offset+ly*b4,H,bq_f[ly],bq_raw[ly]);
            read_q16(mem.wk_bias_offset+ly*b4,H,bk_f[ly],bk_raw[ly]);
            read_q16(mem.wv_bias_offset+ly*b4,H,bv_f[ly],bv_raw[ly]);
            read_q16(mem.wo_bias_offset+ly*b4,H,bo_f[ly],bo_raw[ly]);
            read_q16(mem.w1_bias_offset+ly*b41,FF,b1_f[ly],b1_raw[ly]);
            read_q16(mem.w2_bias_offset+ly*b4,H,b2_f[ly],b2_raw[ly]);
            read_q16_f(mem.ln0_gamma_offset+ly*g4,H,ln1_w_f[ly]);
            read_q16_f(mem.ln0_beta_offset+ly*g4,H,ln1_b_f[ly]);
            read_q16_f(mem.ln1_gamma_offset+ly*g4,H,ln2_w_f[ly]);
            read_q16_f(mem.ln1_beta_offset+ly*g4,H,ln2_b_f[ly]);
            LOG_DEBUG("  L"+std::to_string(ly)+" bq_raw[0]="+std::to_string(bq_raw[ly][0])
                +" bq_f[0]="+std::to_string(bq_f[ly][0])
                +" ln1_w[0]="+std::to_string(ln1_w_f[ly][0])
                +" ln1_b[0]="+std::to_string(ln1_b_f[ly][0]));
        }
        read_q16_f(mem.final_norm_gamma_offset,H,fln_w_f);
        read_q16_f(mem.final_norm_beta_offset,H,fln_b_f);
        LOG_DEBUG("  fln_w[0]="+std::to_string(fln_w_f[0])+" fln_b[0]="+std::to_string(fln_b_f[0]));

        wlogit_i8.resize((size_t)V*H);
        if(!pl->readDDR(DmaBufType::BUF0,mem.wlogit_offset,wlogit_i8.data(),(size_t)V*H)){
            LOG_ERROR("Failed to read logit weights");return false;}
        LOG_DEBUG("  wlogit[0][0]="+ std::to_string((int)wlogit_i8[0]));

        matmul_mode_ready=true;
        LOG_INFO("Matmul params loaded: "+std::to_string(NL)+"L "+std::to_string(H)+"H "+std::to_string(FF)+"FF "+std::to_string(V)+"V");
        return true;
    }

    bool executeMatmul(ComputeOp op,uint32_t layer,uint32_t head,uint32_t token_position,
                       const int8_t*act_i8,uint32_t act_len,int32_t*acc_out,uint32_t out_len){
        mm_calls++;
        uint32_t tile_end=0,tile_out_elems=0;
        switch(op){
        case ComputeOp::CMP_Q:case ComputeOp::CMP_K:case ComputeOp::CMP_V:
            tile_end=NUM_QKV_HEAD_TILES;tile_out_elems=D_HEAD_TILE_QKV;break;
        case ComputeOp::CMP_ATT_SCORES:tile_end=NUM_ATT_CTX_BLOCKS;tile_out_elems=ATT_CTX_BLOCK;break;
        case ComputeOp::CMP_ATT_VALUE:tile_end=NUM_ATT_VALUE_HEAD_TILES*NUM_ATT_CTX_BLOCKS;tile_out_elems=D_HEAD_TILE_ATT_VALUE;break;
        case ComputeOp::CMP_OUT_PROJ:tile_end=NUM_WO_TILES;tile_out_elems=D_TILE_WO;break;
        case ComputeOp::CMP_FFN_W1:tile_end=NUM_W1_TILES;tile_out_elems=D_TILE_W1;break;
        case ComputeOp::CMP_FFN_W2:tile_end=NUM_W2_TILES;tile_out_elems=D_TILE_W2;break;
        case ComputeOp::CMP_LOGITS:tile_end=NUM_LOGIT_TILES;tile_out_elems=D_TILE_LOGIT;break;
        default:LOG_ERROR("[MM] invalid op "+std::to_string((int)op));return false;
        }
        if(out_len>tile_end*tile_out_elems){LOG_ERROR("[MM] out_len overflow");return false;}
        if(act_len>(uint32_t)STREAM_IN_BUF_BYTES){LOG_ERROR("[MM] act_len overflow");return false;}

        uint32_t instr=pack_instr32(op,layer,head);

        LOG_DEBUG("[MM#"+std::to_string(mm_calls)+"] op="+op_name(op)
            +" ly="+std::to_string(layer)+" hd="+std::to_string(head)
            +" pos="+std::to_string(token_position)
            +" act="+std::to_string(act_len)+"B out="+std::to_string(out_len)
            +" tiles="+std::to_string(tile_end)+"x"+std::to_string(tile_out_elems)
            +" instr="+hex32(instr)
            +" act_i8"+v4i8(act_i8,act_len));

        std::vector<uint8_t>send_buf(STREAM_IN_BUF_BYTES,0);
        memcpy(send_buf.data(),act_i8,act_len);

        pl->writeReg(PLReg::INSTR,instr);
        pl->writeReg(PLReg::TOKEN_POSITION,token_position);

        if(!pl->streamInitRecv(output_offset,(size_t)STREAM_OUT_BUF_BYTES)){
            LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] recv init fail");return false;}
        if(!pl->streamInitSend(input_offset,send_buf.data(),(size_t)STREAM_IN_BUF_BYTES)){
            LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] send init fail");return false;}

        uint32_t ctrl=CTRL_RESETN_BIT|CTRL_START_BIT;if(debug_mode)ctrl|=CTRL_DEBUG_MODE_BIT;
        LOG_DEBUG("[MM#"+std::to_string(mm_calls)+"] START ctrl="+hex32(ctrl));
        pl->writeReg(PLReg::CONTROL,ctrl);usleep(10);pl->writeReg(PLReg::CONTROL,ctrl&~CTRL_START_BIT);

        auto t_start=std::chrono::steady_clock::now();

        if(!pl->streamWaitSend(timeout_ms)){
            LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] send timeout | "+pl->streamStatusString());
            pl->clearIRQ();return false;}

        LOG_DEBUG("[MM#"+std::to_string(mm_calls)+"] sent, recv "+std::to_string(tile_end)+" tiles...");

        std::vector<uint8_t>recv_tile(STREAM_OUT_BUF_BYTES,0);
        for(uint32_t t=0;t<tile_end;t++){
            if(!pl->streamWaitRecv(output_offset+t*STREAM_OUT_BUF_BYTES,recv_tile.data(),(size_t)STREAM_OUT_BUF_BYTES,timeout_ms)){
                LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] recv timeout tile "+std::to_string(t)+"/"+std::to_string(tile_end)
                    +" | "+pl->streamStatusString()+" | "+pl->getRegStats(true));
                pl->clearIRQ();return false;}
            uint32_t base=t*tile_out_elems;
            if(base<out_len){uint32_t rem=out_len-base;uint32_t cp=rem<tile_out_elems?rem:tile_out_elems;
                memcpy(&acc_out[base],recv_tile.data(),cp*sizeof(int32_t));}
            if(t+1<tile_end){
                if(!pl->streamInitRecv(output_offset+(t+1)*STREAM_OUT_BUF_BYTES,(size_t)STREAM_OUT_BUF_BYTES)){
                    LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] recv init fail tile "+std::to_string(t+1));
                    pl->clearIRQ();return false;}}
        }

        LOG_DEBUG("[MM#"+std::to_string(mm_calls)+"] tiles done, waiting PL done...");

        if(!pl->waitDone(timeout_ms)){
            LOG_ERROR("[MM#"+std::to_string(mm_calls)+"] PL done timeout | "+pl->getRegStats(true));
            pl->clearIRQ();return false;}
        pl->clearIRQ();

        auto t_end=std::chrono::steady_clock::now();
        LOG_DEBUG("[MM#"+std::to_string(mm_calls)+"] OK "+ms_str(t_start,t_end)
            +" acc"+v4i32(acc_out,out_len));
        return true;
    }

    bool executeForwardHybrid(uint32_t token_id,uint32_t token_position,uint32_t &out_token){
        if(!matmul_mode_ready){LOG_ERROR("Matmul mode not init");return false;}
        perf->startGeneration(); mm_calls=0;
        const uint32_t H=model_cfg.hidden_size,FF=model_cfg.intermediate_size;
        const uint32_t V=model_cfg.vocab_size,NL_c=model_cfg.num_layers;
        const uint32_t NH=model_cfg.num_heads,DH=model_cfg.head_dim;

        LOG_DEBUG("=== ForwardHybrid: tid="+std::to_string(token_id)+" pos="+std::to_string(token_position)+" ===");

        std::vector<double>x(H),h(H),h2(H),q(H),k(H),v(H),o(H),fc1(FF),fc2(H),attn_out(H);
        std::vector<int8_t>ai8h(H),ai8ff(FF);
        std::vector<int32_t>acch(H),accff(FF),acchead(DH);
        double ascale;

        // Embedding
        if(use_float_embed){
            size_t to=(size_t)token_id*H,po=(size_t)token_position*H;
            for(uint32_t i=0;i<H;i++)x[i]=(double)embed_float[to+i]+(double)pos_float[po+i];
        }else{
            size_t to=(size_t)token_id*H,po=(size_t)token_position*H;
            for(uint32_t i=0;i<H;i++){int s=(int)embedding_table[to+i]+(int)pos_embedding_table[po+i];
                x[i]=(double)(s<-128?-128:(s>127?127:s));}
        }
        LOG_DEBUG("  embed: x"+v4f(x.data(),H)+" amax="+std::to_string(amax(x.data(),H)));

        for(uint32_t ly=0;ly<NL_c;ly++){
            auto tL0=std::chrono::steady_clock::now();
            LOG_DEBUG("  --- L"+std::to_string(ly)+" x_amax="+std::to_string(amax(x.data(),H))+" ---");

            ps_layernorm(x.data(),ln1_w_f[ly].data(),ln1_b_f[ly].data(),h.data(),H);
            ps_quantize_act(h.data(),ai8h.data(),ascale,H);
            LOG_DEBUG("  L"+std::to_string(ly)+" LN0: h_amax="+std::to_string(amax(h.data(),H))
                +" scale="+std::to_string(ascale)+" ai8"+v4i8(ai8h.data(),H));

            // QKV per head
            for(uint32_t hd=0;hd<NH;hd++){
                uint32_t off=hd*DH;
                if(!executeMatmul(ComputeOp::CMP_Q,ly,hd,token_position,ai8h.data(),H,acchead.data(),DH))return false;
                ps_dequant(acchead.data(),ascale,wq_scale[ly].data()+off,bq_f[ly].data()+off,bq_raw[ly].data()+off,q.data()+off,DH);
                if(!executeMatmul(ComputeOp::CMP_K,ly,hd,token_position,ai8h.data(),H,acchead.data(),DH))return false;
                ps_dequant(acchead.data(),ascale,wk_scale[ly].data()+off,bk_f[ly].data()+off,bk_raw[ly].data()+off,k.data()+off,DH);
                if(!executeMatmul(ComputeOp::CMP_V,ly,hd,token_position,ai8h.data(),H,acchead.data(),DH))return false;
                ps_dequant(acchead.data(),ascale,wv_scale[ly].data()+off,bv_f[ly].data()+off,bv_raw[ly].data()+off,v.data()+off,DH);
            }
            LOG_DEBUG("  L"+std::to_string(ly)+" QKV: q"+v4f(q.data(),H)+" k"+v4f(k.data(),H)+" v"+v4f(v.data(),H));

            // KV cache
            size_t kvoff=(size_t)token_position*H;
            memcpy(&kv_k[ly][kvoff],k.data(),H*sizeof(double));
            memcpy(&kv_v[ly][kvoff],v.data(),H*sizeof(double));

            // Attention
            std::fill(attn_out.begin(),attn_out.end(),0.0);
            for(uint32_t hd=0;hd<NH;hd++){
                double*qh=&q[hd*DH];std::vector<double>sc(token_position+1);double mx=-1e30;
                for(uint32_t t=0;t<=token_position;t++){
                    double s=0;double*kt=&kv_k[ly][t*H+hd*DH];
                    for(uint32_t d=0;d<DH;d++)s+=qh[d]*kt[d];sc[t]=s/8.0;if(sc[t]>mx)mx=sc[t];}
                double se=0;for(uint32_t t=0;t<=token_position;t++){sc[t]=exp(sc[t]-mx);se+=sc[t];}
                for(uint32_t t=0;t<=token_position;t++)sc[t]/=(se+1e-10);
                for(uint32_t d=0;d<DH;d++){double a=0;
                    for(uint32_t t=0;t<=token_position;t++)a+=sc[t]*kv_v[ly][t*H+hd*DH+d];
                    attn_out[hd*DH+d]=a;}
            }
            LOG_DEBUG("  L"+std::to_string(ly)+" attn"+v4f(attn_out.data(),H)+" amax="+std::to_string(amax(attn_out.data(),H)));

            ps_quantize_act(attn_out.data(),ai8h.data(),ascale,H);

            // O proj
            if(!executeMatmul(ComputeOp::CMP_OUT_PROJ,ly,0,token_position,ai8h.data(),H,acch.data(),H))return false;
            ps_dequant(acch.data(),ascale,wo_scale[ly].data(),bo_f[ly].data(),bo_raw[ly].data(),o.data(),H);
            LOG_DEBUG("  L"+std::to_string(ly)+" O"+v4f(o.data(),H));

            for(uint32_t i=0;i<H;i++)x[i]+=o[i];
            LOG_DEBUG("  L"+std::to_string(ly)+" res1 x_amax="+std::to_string(amax(x.data(),H)));

            // LN1
            ps_layernorm(x.data(),ln2_w_f[ly].data(),ln2_b_f[ly].data(),h2.data(),H);
            ps_quantize_act(h2.data(),ai8h.data(),ascale,H);
            LOG_DEBUG("  L"+std::to_string(ly)+" LN1: h2_amax="+std::to_string(amax(h2.data(),H))+" scale="+std::to_string(ascale));

            // W1
            if(!executeMatmul(ComputeOp::CMP_FFN_W1,ly,0,token_position,ai8h.data(),H,accff.data(),FF))return false;
            ps_dequant(accff.data(),ascale,w1_scale[ly].data(),b1_f[ly].data(),b1_raw[ly].data(),fc1.data(),FF);
            LOG_DEBUG("  L"+std::to_string(ly)+" W1"+v4f(fc1.data(),FF)+" amax="+std::to_string(amax(fc1.data(),FF)));

            ps_gelu(fc1.data(),FF);
            LOG_DEBUG("  L"+std::to_string(ly)+" GELU"+v4f(fc1.data(),FF)+" amax="+std::to_string(amax(fc1.data(),FF)));

            ps_quantize_act(fc1.data(),ai8ff.data(),ascale,FF);

            // W2
            if(!executeMatmul(ComputeOp::CMP_FFN_W2,ly,0,token_position,ai8ff.data(),FF,acch.data(),H))return false;
            ps_dequant(acch.data(),ascale,w2_scale[ly].data(),b2_f[ly].data(),b2_raw[ly].data(),fc2.data(),H);
            LOG_DEBUG("  L"+std::to_string(ly)+" W2"+v4f(fc2.data(),H));

            for(uint32_t i=0;i<H;i++)x[i]+=fc2[i];

            auto tL1=std::chrono::steady_clock::now();
            LOG_DEBUG("  L"+std::to_string(ly)+" done "+ms_str(tL0,tL1)+" mm_calls="+std::to_string(mm_calls)
                +" x_amax="+std::to_string(amax(x.data(),H)));
        }

        // Final LN
        ps_layernorm(x.data(),fln_w_f.data(),fln_b_f.data(),h.data(),H);
        ps_quantize_act(h.data(),ai8h.data(),ascale,H);
        LOG_DEBUG("  FinalLN: h_amax="+std::to_string(amax(h.data(),H))+" scale="+std::to_string(ascale));

        // Logits on ARM
        auto tLogit0=std::chrono::steady_clock::now();
        double best=-1e30;out_token=0;
        for(uint32_t i=0;i<V;i++){
            int32_t acc=0;const int8_t*row=&wlogit_i8[i*H];
            for(uint32_t j=0;j<H;j++)acc+=(int32_t)row[j]*(int32_t)ai8h[j];
            double logit=(double)acc*ascale*logit_scale[i];
            if(logit>best){best=logit;out_token=i;}
        }
        auto tLogit1=std::chrono::steady_clock::now();
        LOG_DEBUG("  Logit "+ms_str(tLogit0,tLogit1)+" token="+std::to_string(out_token)
            +" logit="+std::to_string(best)+" total_mm="+std::to_string(mm_calls));

        perf->recordToken();perf->endGeneration();return true;
    }

    void resetKVCache(){
        LOG_DEBUG("Reset KV cache ("+std::to_string(kv_k.size())+" layers)");
        for(size_t ly=0;ly<kv_k.size();ly++){std::fill(kv_k[ly].begin(),kv_k[ly].end(),0.0);
            std::fill(kv_v[ly].begin(),kv_v[ly].end(),0.0);}
    }

private:
    bool lookupEmbedding(uint32_t tid,uint32_t tpos,int8_t*out){
        if(embedding_table.empty()){LOG_WARN("No embed table");for(uint32_t i=0;i<model_cfg.hidden_size;i++)out[i]=(int8_t)(i&0xFF);return true;}
        if(tid>=model_cfg.vocab_size){LOG_ERROR("Token OOB "+std::to_string(tid));return false;}
        size_t to=(size_t)tid*model_cfg.hidden_size;memcpy(out,&embedding_table[to],model_cfg.hidden_size);
        if(!pos_embedding_table.empty()&&tpos<model_cfg.context_length){
            size_t po=(size_t)tpos*model_cfg.hidden_size;
            for(uint32_t i=0;i<model_cfg.hidden_size;i++){int s=(int)out[i]+(int)pos_embedding_table[po+i];
                out[i]=(int8_t)(s<-128?-128:(s>127?127:s));}}
        return true;
    }
    void logPLStatus(const char*ctx){LOG_ERROR("["+std::string(ctx)+"] "+err->getLastErrorMessage()+" | "+pl->getRegStats(true));}
};

// =============================================================================
// InferenceEngine
// =============================================================================
class InferenceEngine {
    SystemConfig config;std::unique_ptr<PLInterface>pl;std::unique_ptr<Tokenizer>tokenizer;
    std::unique_ptr<PerformanceMonitor>perf;std::unique_ptr<WeightLoader>loader;
    std::unique_ptr<InferenceExecutor>exec;ErrorHandler err;std::thread thread;bool running=false;
    struct State{EngineStatus status=EngineStatus::IDLE;int taskId=-1;bool cancel=false;
        uint32_t tokens=0,maxTokens=512;
        void reset(){status=EngineStatus::IDLE;taskId=-1;cancel=false;tokens=0;}} state;
public:
    ~InferenceEngine(){shutdown();}

    bool initialize(const std::string &cfg_file,bool debug_hw_override=false,bool mock_override=false){
        config.loadFromFile(cfg_file);
        if(debug_hw_override)config.hardware.debug_mode=true;
        if(mock_override)config.hardware.mock_mode=true;
        if(!config.validate()){LOG_ERROR("Invalid configuration");return false;}

        pl=std::unique_ptr<PLInterface>(new PLInterface(g_logger,&err,config.hardware.mock_mode));
        if(!pl->init(config.hardware.uio_device,config.hardware.stream_reg_base_addr)){
            LOG_FATAL("PL init failed "+err.getLastErrorMessage());return false;}
        if(!pl->initDMA(config.hardware.dmabuf0_name,config.hardware.dmabuf0_size,
                        config.hardware.dmabuf1_name,config.hardware.dmabuf1_size)){
            LOG_FATAL("DDR init failed"+err.getLastErrorMessage());return false;}

        tokenizer=std::unique_ptr<Tokenizer>(new Tokenizer());
        if(!tokenizer->loadVocabulary(config.model.tokenizer_vocab)){
            LOG_FATAL("Tokenizer fail "+err.getLastErrorMessage());return false;}
        perf=std::unique_ptr<PerformanceMonitor>(new PerformanceMonitor);
        loader=std::unique_ptr<WeightLoader>(new WeightLoader(pl.get(),&err));
        if(!loader->configureAddresses(config.model,config.memory)){
            LOG_FATAL("Config fail "+err.getLastErrorMessage());return false;}
        loader->setWeightsFile(config.model.weights_file);
        if(!loader->loadAllWeights(config.model,config.memory.weights_size)){
            LOG_FATAL("Weight load fail "+err.getLastErrorMessage());return false;}

        exec=std::unique_ptr<InferenceExecutor>(new InferenceExecutor(
            pl.get(),tokenizer.get(),perf.get(),&err,config.model,
            config.memory.input_offset,config.memory.output_offset,
            config.hardware.timeout_ms,config.hardware.debug_mode));

        if(!config.model.embeddings_file.empty())
            if(!exec->loadEmbeddingTable(config.model.embeddings_file))
                LOG_WARN("Embed load fail"+err.getLastErrorMessage());
        if(!config.model.pos_embeddings_file.empty())
            if(!exec->loadPositionEmbeddings(config.model.pos_embeddings_file))
                LOG_WARN("Pos embed fail"+err.getLastErrorMessage());

        exec->setMemoryLayout(config.memory);
        exec->loadFloatEmbeddings(config.model.embed_float_file,config.model.pos_float_file);
        if(!exec->loadMatmulModeParams(config.model.model_dir))
            LOG_WARN("Matmul mode params not loaded");

        LOG_INFO("Initialized"+std::string(config.hardware.debug_mode?" [HW DEBUG]":""));
        return true;
    }
    void start(){running=true;thread=std::thread(&InferenceEngine::loop,this);}
    void shutdown(){if(running){running=false;g_command_queue.push(Command(CommandType::SHUTDOWN));if(thread.joinable())thread.join();}}
    bool submitTask(const Task&t){return g_task_queue.push(t);}
    bool submitCommand(const Command&c){return g_command_queue.push(c);}
    std::string getPerfStats()const{return perf->getDetailedStats();}
    std::string getRegStats()const{return pl->getRegStats();}
    std::string dumpPLRegs()const{return pl->dumpCtrlMem();}
    std::string dumpConfig()const{return config.toString();}
private:
    void loop(){
        while(running){
            Command cmd;
            if(g_command_queue.pop(cmd)){
                if(cmd.type==CommandType::SHUTDOWN){running=false;break;}
                if(cmd.type==CommandType::STOP_CURRENT)state.cancel=true;
                if(cmd.type==CommandType::RESET){pl->reset();state.reset();}
                continue;}
            if(state.status==EngineStatus::IDLE){Task task;
                if(g_task_queue.pop(task)){if(config.hardware.debug_mode)processTaskDebug(task);else processTask(task);}
                else std::this_thread::sleep_for(std::chrono::milliseconds(10));}
        }
    }
    void processTaskDebug(const Task&task){
        state.status=EngineStatus::GENERATING;state.taskId=task.id;state.cancel=false;g_engine_status=EngineStatus::GENERATING;
        auto tokens=task.prompt.size()>4&&task.prompt.substr(task.prompt.size()-4)==".bin"?loadPreTokenized(task.prompt):tokenizer->encode(task.prompt);
        if(tokens.empty()){print("[empty]\n");state.status=EngineStatus::IDLE;g_engine_status=EngineStatus::IDLE;return;}
        uint32_t in_tok=tokens[0],out_tok=0;
        print("=== DEBUG ===\nInput: "+std::to_string(in_tok)+" \""+tokenizer->decodeToken(in_tok)+"\"\n");
        print("Regs BEFORE:\n"+pl->getRegStats()+"\n");
        bool ok=exec->executeToken(in_tok,0,out_tok);
        print("Regs AFTER:\n"+pl->getRegStats()+"\n");
        print(ok?"HW: "+std::to_string(out_tok)+"\n":"FAILED: "+err.getLastErrorMessage()+"\n");
        print("=== END ===\n");state.status=EngineStatus::IDLE;g_engine_status=EngineStatus::IDLE;
    }
    void processTask(const Task&task){
        state.status=EngineStatus::GENERATING;state.taskId=task.id;state.cancel=false;g_engine_status=EngineStatus::GENERATING;
        auto tokens=task.prompt.size()>4&&task.prompt.substr(task.prompt.size()-4)==".bin"?loadPreTokenized(task.prompt):tokenizer->encode(task.prompt);
        if(tokens.empty()){print("[empty]\n");state.status=EngineStatus::IDLE;g_engine_status=EngineStatus::IDLE;return;}

        LOG_INFO("Task: \""+task.prompt+"\" tokens="+std::to_string(tokens.size()));
        LOG_DEBUG("Token IDs: "+([&]{std::string s;for(size_t i=0;i<tokens.size();i++){if(i)s+=",";s+=std::to_string(tokens[i]);}return s;})());

        exec->resetKVCache();

        LOG_INFO("Prefill: "+std::to_string(tokens.size()-1)+" tokens");
        auto tPF0=std::chrono::steady_clock::now();
        for(size_t i=0;i+1<tokens.size()&&!state.cancel;i++){
            uint32_t discard=0;auto t0=std::chrono::steady_clock::now();
            if(!exec->executeForwardHybrid(tokens[i],static_cast<uint32_t>(i),discard)){LOG_ERROR("Prefill fail @"+std::to_string(i));break;}
            auto t1=std::chrono::steady_clock::now();
            LOG_INFO("  Prefill["+std::to_string(i)+"/"+std::to_string(tokens.size()-1)+"] tok="+std::to_string(tokens[i])
                +" -> "+std::to_string(discard)+" ("+ms_str(t0,t1)+")");
        }
        LOG_INFO("Prefill done: "+ms_str(tPF0,std::chrono::steady_clock::now()));
        if(state.cancel){state.status=EngineStatus::IDLE;g_engine_status=EngineStatus::IDLE;return;}

        LOG_INFO("Decode: max="+std::to_string(state.maxTokens));
        uint32_t next=tokens.back();
        for(uint32_t i=0;i<state.maxTokens&&!state.cancel;i++){
            uint32_t out_tok=0;uint32_t tpos=static_cast<uint32_t>(tokens.size()-1)+i;
            auto t0=std::chrono::steady_clock::now();
            if(!exec->executeForwardHybrid(next,tpos,out_tok))break;
            auto t1=std::chrono::steady_clock::now();
            std::string dec=tokenizer->decodeToken(out_tok);
            LOG_INFO("  Decode["+std::to_string(i)+"] in="+std::to_string(next)+" pos="+std::to_string(tpos)
                +" -> "+std::to_string(out_tok)+" \""+dec+"\" ("+ms_str(t0,t1)+")");
            if(!dec.empty())print(dec);
            if(out_tok==tokenizer->getEOSTokenId()){LOG_INFO("  EOS");break;}
            next=out_tok;
        }
        print("\n");LOG_INFO("Task complete");state.status=EngineStatus::IDLE;g_engine_status=EngineStatus::IDLE;
    }
    std::vector<uint32_t>loadPreTokenized(const std::string&path){
        std::vector<uint32_t>ids;std::ifstream f(path,std::ios::binary);
        if(!f){LOG_ERROR("Cannot open "+path);return ids;}
        uint32_t count=0;f.read(reinterpret_cast<char*>(&count),4);ids.resize(count);
        f.read(reinterpret_cast<char*>(ids.data()),count*4);
        LOG_INFO("Loaded "+std::to_string(count)+" tokens from "+path);return ids;
    }
    void print(const std::string&s){std::lock_guard<std::mutex>lk(g_console_mutex);std::cout<<s<<std::flush;}
};

int main(int argc,char*argv[]){
    std::cout<<"FPGA Transformer Inference Engine\n";
    LogLevel lvl=LogLevel::INFO;bool debug_hw=false,mock_hw=false;
    for(int i=1;i<argc;i++){std::string a(argv[i]);
        if(a=="--debug")lvl=LogLevel::DEBUG;if(a=="--debug-hw")debug_hw=true;if(a=="--mock")mock_hw=true;}
    g_logger=new Logger(lvl,"inference.log");
    std::string cfg="config.yaml";for(int i=1;i<argc-1;i++)if(std::string(argv[i])=="--config")cfg=argv[i+1];
    InferenceEngine engine;
    if(debug_hw)LOG_INFO("HW debug mode");if(mock_hw)LOG_INFO("Mock mode");
    if(!engine.initialize(cfg,debug_hw,mock_hw)){LOG_FATAL("Init failed");delete g_logger;return 1;}
    engine.start();
    std::cout<<"Commands: /quit /stop /reset /stats_perf /stats_reg /reg_dump /config_dump\n> ";
    int taskId=1;std::string input;
    while(std::getline(std::cin,input)){
        if(input.empty()){std::cout<<"> ";continue;}
        if(input=="/quit"){engine.submitCommand(Command(CommandType::SHUTDOWN));break;}
        if(input=="/stop")engine.submitCommand(Command(CommandType::STOP_CURRENT));
        else if(input=="/reset")engine.submitCommand(Command(CommandType::RESET));
        else if(input=="/stats_perf")std::cout<<engine.getPerfStats()<<"\n";
        else if(input=="/stats_reg")std::cout<<engine.getRegStats()<<"\n";
        else if(input=="/reg_dump")std::cout<<engine.dumpPLRegs()<<"\n";
        else if(input=="/config_dump")std::cout<<engine.dumpConfig()<<"\n";
        else engine.submitTask(Task(taskId++,TaskType::GENERATE,input));
        std::cout<<"> ";
    }
    engine.shutdown();delete g_logger;return 0;
}