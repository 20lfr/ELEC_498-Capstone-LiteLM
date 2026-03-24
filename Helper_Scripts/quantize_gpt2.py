"""
Description:
    Quantize the Hugging Face `openai-community/gpt2` weights and tokenizer into
    fixed-layout int8 binaries (plus scale metadata) for FPGA/embedded loading.

Usage:
    python3 quantize_gpt2.py --output-dir <dir>

Output files in <dir>:
    - gpt2_weights_int8.bin : packed model weights
    - embed_tokens.bin      : int8 token embedding table
    - pos_embed.bin         : int8 positional embeddings
    - quant_scales.json     : per-layer/per-tensor scale factors
    - tokenizer files saved by AutoTokenizer
"""

import argparse, hashlib, json, os, struct, time
import numpy as np

NL=12; NH=12; DM=768; DH=64; DF=3072; VS=50257; CTX=1024

def align64(v): return (v+63)&~63

def compute_layout():
    L={}; off=0
    def r(n,s):
        nonlocal off; L[n]=off; off=align64(off+s)
    r('wq',NL*DM*DM);r('wk',NL*DM*DM);r('wv',NL*DM*DM);r('wo',NL*DM*DM)
    r('w1',NL*DF*DM);r('w2',NL*DM*DF);r('wlogit',VS*DM)
    r('wq_bias',NL*DM*4);r('wk_bias',NL*DM*4);r('wv_bias',NL*DM*4)
    r('wo_bias',NL*DM*4);r('w1_bias',NL*DF*4);r('w2_bias',NL*DM*4)
    r('ln1_w',NL*DM*4);r('ln1_b',NL*DM*4);r('ln2_w',NL*DM*4);r('ln2_b',NL*DM*4)
    r('fln_w',DM*4);r('fln_b',DM*4)
    r('ln1_eps',NL*4);r('ln2_eps',NL*4);r('fln_eps',4)
    r('pos_embed',CTX*DM)
    L['w_size']=off; return L

def q_perchannel(w):
    w=w.astype(np.float32); am=np.maximum(np.max(np.abs(w),axis=1),1e-10)
    s=am/127.0; q=np.clip(np.round(w/s[:,None]),-127,127).astype(np.int8)
    return q, s.astype(np.float32)

def q_pertensor(t, clip=99.9):
    t=t.astype(np.float32); am=np.max(np.abs(t))
    if am<1e-10: return np.zeros_like(t,dtype=np.int8), 0.0
    c=max(float(np.percentile(np.abs(t),clip)),1e-10); s=c/127.0
    return np.clip(np.round(t/s),-127,127).astype(np.int8), float(s)

def fxp(a): return np.clip(a*(2**16),-(2**31),(2**31)-1).astype(np.int32)
def wr(img,off,d): b=d if isinstance(d,(bytes,bytearray)) else d.tobytes(); img[off:off+len(b)]=b

def main():
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer
    ap=argparse.ArgumentParser(); ap.add_argument("--output-dir",default="model/"); a=ap.parse_args()
    os.makedirs(a.output_dir, exist_ok=True); L=compute_layout()
    print(f"DDR: {L['w_size']/1024/1024:.1f} MB")

    model=AutoModelForCausalLM.from_pretrained("openai-community/gpt2",torch_dtype=torch.float32,device_map="cpu")
    tok=AutoTokenizer.from_pretrained("openai-community/gpt2"); st=model.state_dict(); cfg=model.config
    img=bytearray(L['w_size']); scales={}; lsq=DM*DM;ls1=DF*DM;ls2=DM*DF;blsq=DM*4;bls1=DF*4;bls2=DM*4;gls=DM*4

    for ly in range(NL):
        t0=time.time(); pfx=f"transformer.h.{ly}"
        ca=st[f"{pfx}.attn.c_attn.weight"].numpy().T; cab=st[f"{pfx}.attn.c_attn.bias"].numpy()
        wq=ca[:DM];wk=ca[DM:2*DM];wv=ca[2*DM:]; bq=cab[:DM];bk=cab[DM:2*DM];bv=cab[2*DM:]
        wo=st[f"{pfx}.attn.c_proj.weight"].numpy().T;bo=st[f"{pfx}.attn.c_proj.bias"].numpy()
        w1=st[f"{pfx}.mlp.c_fc.weight"].numpy().T;b1=st[f"{pfx}.mlp.c_fc.bias"].numpy()
        w2=st[f"{pfx}.mlp.c_proj.weight"].numpy().T;b2=st[f"{pfx}.mlp.c_proj.bias"].numpy()
        for nm,wt,base,ls in [("wq",wq,L['wq'],lsq),("wk",wk,L['wk'],lsq),("wv",wv,L['wv'],lsq),
                               ("wo",wo,L['wo'],lsq),("w1",w1,L['w1'],ls1),("w2",w2,L['w2'],ls2)]:
            q,s=q_perchannel(wt); wr(img,base+ly*ls,q); scales[f"layer{ly}.{nm}"]=s.tolist()
        wr(img,L['wq_bias']+ly*blsq,fxp(bq));wr(img,L['wk_bias']+ly*blsq,fxp(bk));wr(img,L['wv_bias']+ly*blsq,fxp(bv))
        wr(img,L['wo_bias']+ly*blsq,fxp(bo));wr(img,L['w1_bias']+ly*bls1,fxp(b1));wr(img,L['w2_bias']+ly*bls2,fxp(b2))
        wr(img,L['ln1_w']+ly*gls,fxp(st[f"{pfx}.ln_1.weight"].numpy()));wr(img,L['ln1_b']+ly*gls,fxp(st[f"{pfx}.ln_1.bias"].numpy()))
        wr(img,L['ln2_w']+ly*gls,fxp(st[f"{pfx}.ln_2.weight"].numpy()));wr(img,L['ln2_b']+ly*gls,fxp(st[f"{pfx}.ln_2.bias"].numpy()))
        ef=max(1,int(cfg.layer_norm_epsilon*(2**32)));wr(img,L['ln1_eps']+ly*4,struct.pack("<I",ef));wr(img,L['ln2_eps']+ly*4,struct.pack("<I",ef))
        print(f"  L{ly+1:02d}/{NL} ({time.time()-t0:.1f}s)")

    wr(img,L['fln_w'],fxp(st["transformer.ln_f.weight"].numpy()));wr(img,L['fln_b'],fxp(st["transformer.ln_f.bias"].numpy()))
    wr(img,L['fln_eps'],struct.pack("<I",max(1,int(cfg.layer_norm_epsilon*(2**32)))))
    wpe=st["transformer.wpe.weight"].numpy();pq,ps=q_pertensor(wpe);wr(img,L['pos_embed'],pq);scales["pos_embed"]=ps
    wte=st["transformer.wte.weight"].numpy();qlm,slm=q_perchannel(wte);wr(img,L['wlogit'],qlm);scales["lm_head"]=slm.tolist()
    eq,es=q_pertensor(wte);scales["embed_tokens"]=es

    with open(os.path.join(a.output_dir,"gpt2_weights_int8.bin"),"wb") as f: f.write(img)
    with open(os.path.join(a.output_dir,"embed_tokens.bin"),"wb") as f: f.write(eq.tobytes())
    with open(os.path.join(a.output_dir,"pos_embed.bin"),"wb") as f: f.write(pq.tobytes())
    with open(os.path.join(a.output_dir,"quant_scales.json"),"w") as f: json.dump(scales,f)
    tok.save_pretrained(a.output_dir)
    print(f"\nDone: {a.output_dir}  ({L['w_size']/1024/1024:.1f} MB DDR)")

if __name__=="__main__": main()
