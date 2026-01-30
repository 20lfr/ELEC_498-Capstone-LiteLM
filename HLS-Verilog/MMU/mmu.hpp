#pragma once

#ifndef MMU_HPP
#define MMU_HPP

#include <cstdint>
#include <cstring>


struct ModelDims {
    uint16_t d_model;        
    uint16_t d_ffn;          
    uint16_t d_heads;        
    uint16_t num_heads;      
    uint16_t num_layers;     
    uint16_t context_len;    
    uint16_t d_tile_wo;      
    uint16_t d_tile_w1;      
    uint16_t d_tile_w2;      
    uint16_t num_wo_tiles;   
    uint16_t num_w1_tiles;   
    uint16_t num_w2_tiles;   
    
    ModelDims() :
        d_model(2048), d_ffn(5504), d_heads(64), num_heads(32), num_layers(22),
        context_len(2048), d_tile_wo(64), d_tile_w1(64), d_tile_w2(172),
        num_wo_tiles(32), num_w1_tiles(86), num_w2_tiles(32) {}
};


enum class ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_LN0 = 1,           // 0x01
    CMP_REQUANT1 = 2,      // 0x02
    CMP_Q = 3,             // 0x03
    CMP_K = 4,             // 0x04
    CMP_K_REQUANT = 5,     // 0x05
    CMP_V = 6,             // 0x06
    CMP_V_REQUANT = 7,     // 0x07
    CMP_Q_REQUANT = 8,     // 0x08
    CMP_ATT_SCORES = 9,    // 0x09
    CMP_VALUE_SCALE = 10,  // 0x0A
    CMP_SOFTMAX = 11,      // 0x0B
    CMP_ATT_VALUE = 12,    // 0x0C
    CMP_HEAD_REQUANT = 13, // 0x0D
    CMP_CONCAT = 14,       // 0x0E
    CMP_OUT_PROJ = 15,     // 0x0F
    CMP_RESID0 = 16,       // 0x10
    CMP_REQUANT2 = 17,     // 0x11
    CMP_FFN_W1 = 18,       // 0x12
    CMP_FFN_ACT = 19,      // 0x13
    CMP_FFN_W2 = 20,       // 0x14
    CMP_REQUANT3 = 21,     // 0x15
    CMP_RESID1 = 22,       // 0x16
    CMP_LN1 = 23,          // 0x17
    CMP_REQUANT4 = 24      // 0x18
};

enum class DmaSel : uint8_t {
    DMASEL_NONE = 0,       // 0x00
    DMASEL_WQ = 1,         // 0x01
    DMASEL_WK = 2,         // 0x02
    DMASEL_K_WRITE = 3,    // 0x03
    DMASEL_WV = 4,         // 0x04
    DMASEL_V_WRITE = 5,    // 0x05
    DMASEL_CTX_K = 6,      // 0x06
    DMASEL_CTX_V = 7,      // 0x07
    DMASEL_WO = 8,         // 0x08
    DMASEL_W1 = 9,         // 0x09
    DMASEL_W2 = 10,        // 0x0A
    DMASEL_WLOGIT = 11     // 0x0B
};

// FSM Memory Request: <31:24 tile><23:16 head><15:8 layer><7:0 mem_request>
struct MemoryRequest {
    uint8_t request;  // DmaSel (7:0)
    uint8_t layer;    // (15:8)
    uint8_t head;     // (23:16)
    uint8_t tile;     // (31:24)
    
    MemoryRequest() : request(0), layer(0), head(0), tile(0) {}
    MemoryRequest(uint32_t packed) {
        request = packed & 0xFF;
        layer = (packed >> 8) & 0xFF;
        head = (packed >> 16) & 0xFF;
        tile = (packed >> 24) & 0xFF;
    }
    
    uint32_t pack() const {
        return static_cast<uint32_t>(request) |
               (static_cast<uint32_t>(layer) << 8) |
               (static_cast<uint32_t>(head) << 16) |
               (static_cast<uint32_t>(tile) << 24);
    }
    
    DmaSel get_dma_sel() const {
        return static_cast<DmaSel>(request);
    }
};

struct ComputeRequest {
    uint8_t op;       // ComputeOp (7:0)
    uint8_t layer;    // (15:8)
    uint8_t head;     // (23:16)
    uint8_t tile;     // (31:24)
    
    ComputeRequest() : op(0), layer(0), head(0), tile(0) {}
    ComputeRequest(uint32_t packed) {
        op = packed & 0xFF;
        layer = (packed >> 8) & 0xFF;
        head = (packed >> 16) & 0xFF;
        tile = (packed >> 24) & 0xFF;
    }
    
    uint32_t pack() const {
        return static_cast<uint32_t>(op) |
               (static_cast<uint32_t>(layer) << 8) |
               (static_cast<uint32_t>(head) << 16) |
               (static_cast<uint32_t>(tile) << 24);
    }
    
    ComputeOp get_compute_op() const {
        return static_cast<ComputeOp>(op);
    }
};

struct BufferRegion {
    uint16_t offset;    // Byte offset in buffer
    uint16_t size;      // Size in bytes
    
    BufferRegion() : offset(0), size(0) {}
    BufferRegion(uint16_t off, uint16_t sz) : offset(off), size(sz) {}
};

struct BufferLayout {
    BufferRegion regions[8];  // Up to 8 regions per buffer
    uint8_t num_regions;
    uint16_t total_size;
    
    BufferLayout() : num_regions(0), total_size(0) {}
};

struct WeightBlob {
    BufferRegion weights;  // W location
    BufferRegion biases;   // B location
    BufferRegion scales;   // S location (for FFN)
    uint16_t total_size;
    
    WeightBlob() : total_size(0) {}
};


struct KVCacheAddr {
    uint32_t base_addr;      // Base address in DDR
    uint16_t token_offset;   // Offset for specific token
    uint8_t head;            // Head index
    bool valid;
    
    KVCacheAddr() : base_addr(0), token_offset(0), head(0), valid(false) {}
};


struct TileDescriptor {
    DmaSel addr_sel;
    int8_t layer;
    int8_t head;
    int8_t tile;
    uint8_t uram_bank;         // 0 or 1 (ping-pong)
    uint32_t uram_offset;
    uint16_t size;
    bool valid;
    
    TileDescriptor() :
        addr_sel(DmaSel::DMASEL_NONE), layer(-1), head(-1), tile(-1),
        uram_bank(0), uram_offset(0), size(0), valid(false) {}
};

constexpr int MMU_MAX_TILES = 64;
constexpr int MMU_MAX_HEADS = 32;
constexpr int MMU_URAM_BANKS = 2;
constexpr uint32_t MMU_BANK_SIZE = 0x10000;  // 64KB
constexpr int MMU_REQUEST_QUEUE_DEPTH = 16;

struct MMUState {

    TileDescriptor tile_table[MMU_MAX_TILES];
    uint16_t num_tiles;
    uint8_t next_bank;  
    uint32_t bank_offsets[MMU_URAM_BANKS];
    
    ModelDims dims;
    
    uint16_t current_token;
    
    uint32_t k_cache_base;
    uint32_t v_cache_base;
    
    bool head_dma_done[MMU_MAX_HEADS];
    bool head_compute_done[MMU_MAX_HEADS];
    bool main_dma_done;
    bool main_compute_done;
    
    MMUState() :
        num_tiles(0), next_bank(0), current_token(0),
        k_cache_base(0), v_cache_base(0),
        main_dma_done(false), main_compute_done(false) {
        for (int i = 0; i < MMU_URAM_BANKS; ++i) {
            bank_offsets[i] = 0;
        }
        for (int i = 0; i < MMU_MAX_HEADS; ++i) {
            head_dma_done[i] = false;
            head_compute_done[i] = false;
        }
    }
};

struct MMUAllocation {
    bool success;
    uint8_t uram_bank;
    uint32_t uram_offset;
    uint16_t size;
    bool overflow;
    
    MMUAllocation() :
        success(false), uram_bank(0), uram_offset(0), size(0), overflow(false) {}
};

struct MMULookup {
    bool found;
    uint8_t uram_bank;
    uint32_t uram_offset;
    uint16_t size;
    
    MMULookup() : found(false), uram_bank(0), uram_offset(0), size(0) {}
};

void mmu_init(MMUState &state, const ModelDims &dims);
void mmu_reset(MMUState &state);
void mmu_set_kv_cache_bases(MMUState &state, uint32_t k_base, uint32_t v_base);

MemoryRequest mmu_decode_memory_request(uint32_t packed);
ComputeRequest mmu_decode_compute_request(uint32_t packed);

uint16_t mmu_calc_dma_size(DmaSel sel, const ModelDims &dims, int tile);
uint16_t mmu_calc_input_buffer_size(ComputeOp op, const ModelDims &dims);
uint16_t mmu_calc_output_buffer_size(ComputeOp op, const ModelDims &dims);

BufferLayout mmu_calc_input_layout(ComputeOp op, const ModelDims &dims);
BufferLayout mmu_calc_output_layout(ComputeOp op, const ModelDims &dims);
BufferRegion mmu_get_head_input_slice(ComputeOp op, int head, const ModelDims &dims);
BufferRegion mmu_get_head_output_slice(ComputeOp op, int head, const ModelDims &dims);

WeightBlob mmu_parse_weight_blob(DmaSel sel, const ModelDims &dims);

KVCacheAddr mmu_calc_kv_write_addr(MMUState &state, int layer, int head, bool is_v);
KVCacheAddr mmu_calc_kv_read_addr(MMUState &state, int layer, int head, bool is_v);
uint32_t mmu_calc_kv_cache_size(const ModelDims &dims);

bool mmu_check_cache(const MMUState &state, DmaSel sel, int layer, int head, int tile);
MMULookup mmu_lookup(const MMUState &state, DmaSel sel, int layer, int head, int tile);
MMUAllocation mmu_allocate(MMUState &state, DmaSel sel, int layer, int head, int tile);
void mmu_commit(MMUState &state, DmaSel sel, int layer, int head, int tile,
                uint8_t bank, uint32_t offset, uint16_t size);

void mmu_set_head_dma_done(MMUState &state, int head);
void mmu_set_head_compute_done(MMUState &state, int head);
void mmu_set_main_dma_done(MMUState &state);
void mmu_set_main_compute_done(MMUState &state);
bool mmu_get_head_dma_done(const MMUState &state, int head);
bool mmu_get_head_compute_done(const MMUState &state, int head);
bool mmu_get_main_dma_done(const MMUState &state);
bool mmu_get_main_compute_done(const MMUState &state);
void mmu_clear_head_dma_done(MMUState &state, int head);
void mmu_clear_head_compute_done(MMUState &state, int head);
void mmu_clear_main_dma_done(MMUState &state);
void mmu_clear_main_compute_done(MMUState &state);

bool mmu_is_headed_op(ComputeOp op);
bool mmu_is_dma_write(DmaSel sel);
const char* mmu_op_name(ComputeOp op);
const char* mmu_dma_name(DmaSel sel);

#endif 
