#pragma once

// Requant scales/params generated from model/quant_scales.json.
//
// This header is intentionally the only requant_scales_* header in-tree.
// It provides:
//   - effective per-layer weight scales (from quant_scales.json *_eff keys)
//   - fixed-point requant M/N tables used by the HLS compute controllers
//
// Notes:
// - The *_eff values are used to keep tables compact; per-channel scales are
//   stored in quant_scales.json but are not embedded here.
// - M/N are derived with:
//     n = floor(log2((2^31-1)/real_scale))
//     M = round(real_scale * 2^n)
// - For lack of per-layer activation/output calibration in quant_scales.json,
//   real_scale is chosen using fixed-point assumptions consistent with the
//   current HLS datapath:
//     REQUANT1/3 (LN Q19.13 -> int8):  real_scale = 2^-13 / 2^-7 = 2^-6
//     REQUANT2   (out-proj -> int8):  real_scale = S_w_wo_eff
//     REQUANT4   (ffn_w2   -> int8):  real_scale = (2^-15 * S_w_w2_eff) / 2^-7 = S_w_w2_eff * 2^-8
//     REQUANT_Q/K/V (qkv   -> int8):  real_scale = S_w_w{q,k,v}_eff
//     REQUANT_HEAD (attn value -> int8): real_scale = 2^-7

#include <cstdint>

namespace requant_scales {
// Fixed-point scale for Q19.13 outputs (RMSNorm/LN): 2^-13
constexpr double S_FIXED_Q19_13 = 1.0 / 8192.0;

// Scales from model/quant_scales.json
constexpr double S_embed_tokens = 0.004292404264446343;
constexpr double S_pos_embed = 0.008029531533323876;
constexpr double S_lm_head_eff = 0.004471778869628906;

// Effective per-layer weight scales from quant_scales.json (*_eff)
constexpr double S_w_wq_L[MODEL_LAYERS] = {
    0.006595782469958067, 0.004401617683470249, 0.00501154875382781, 0.00445940438657999,
    0.004541229922324419, 0.003911091480404139, 0.003738116240128875, 0.003805357031524181,
    0.003616641508415341, 0.003467898815870285, 0.003384520066902041, 0.003232166403904557
};
constexpr double S_w_wk_L[MODEL_LAYERS] = {
    0.008214571513235569, 0.004332718905061483, 0.005206175148487091, 0.005454214289784431,
    0.005494147539138794, 0.004001563880592585, 0.003922928124666214, 0.003894979832693934,
    0.003723504021763802, 0.003588849678635597, 0.003554492024704814, 0.003374463645741343
};
constexpr double S_w_wv_L[MODEL_LAYERS] = {
    0.001666463329456747, 0.002910533919930458, 0.002849391661584377, 0.002578993327915668,
    0.002685535699129105, 0.002757042646408081, 0.003163109300658107, 0.003212477313354611,
    0.003385453717783093, 0.003664744319394231, 0.003896867856383324, 0.004784228280186653
};
constexpr double S_w_wo_L[MODEL_LAYERS] = {
    0.003078338457271457, 0.002802785485982895, 0.002550379605963826, 0.002527418779209256,
    0.002772920532152057, 0.002702495083212852, 0.003264704719185829, 0.003306752303615212,
    0.003370998194441199, 0.003776296973228455, 0.00405016029253602, 0.004635937977582216
};
constexpr double S_w_w1_L[MODEL_LAYERS] = {
    0.004370310809463263, 0.003621499985456467, 0.003623401978984475, 0.003447752445936203,
    0.003480033716186881, 0.003363567404448986, 0.003358175978064537, 0.003349150763824582,
    0.003399917157366872, 0.003426178591325879, 0.003484606044366956, 0.00357573782093823
};
constexpr double S_w_w2_L[MODEL_LAYERS] = {
    0.003863979829475284, 0.003493709256872535, 0.00388976838439703, 0.003728331299498677,
    0.003470210591331124, 0.003706247312948108, 0.004051461350172758, 0.004412712994962931,
    0.005155814345926046, 0.005945693701505661, 0.007285820320248604, 0.009685530327260494
};

// Backward-compatible single-layer aliases (layer 0)
constexpr double S_w_wq = S_w_wq_L[0];
constexpr double S_w_wk = S_w_wk_L[0];
constexpr double S_w_wv = S_w_wv_L[0];
constexpr double S_w_wo = S_w_wo_L[0];
constexpr double S_w_w1 = S_w_w1_L[0];
constexpr double S_w_w2 = S_w_w2_L[0];

// FFN per-stage fixed-point scale (Q1.15)
constexpr int16_t FFN_W1_SCALE_Q15 = 0x4000; // 0.5
constexpr int16_t FFN_W2_SCALE_Q15 = 0x4000; // 0.5
} // namespace requant_scales

namespace requant_params {
constexpr int32_t REQUANT1_N_L[MODEL_LAYERS] = { 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36 };
constexpr int32_t REQUANT2_N_L[MODEL_LAYERS] = { 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 38, 38 };
constexpr int32_t REQUANT3_N_L[MODEL_LAYERS] = { 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36 };
constexpr int32_t REQUANT4_N_L[MODEL_LAYERS] = { 47, 47, 47, 47, 47, 47, 46, 46, 46, 46, 46, 45 };
constexpr int32_t REQUANT_Q_N_L[MODEL_LAYERS] = { 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_K_N_L[MODEL_LAYERS] = { 37, 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_V_N_L[MODEL_LAYERS] = { 40, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 38 };
constexpr int32_t REQUANT_HEAD_N_L[MODEL_LAYERS] = { 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37 };

constexpr int32_t REQUANT1_M_L[MODEL_LAYERS] = {
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824,
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824
};
constexpr int32_t REQUANT2_M_L[MODEL_LAYERS] = {
    1692334464, 1540847616, 1402086016, 1389463168, 1524429184, 1485712384,
    1794790400, 1817906304, 1853225856, 2076041216, 1113299584, 1274316928
};
constexpr int32_t REQUANT3_M_L[MODEL_LAYERS] = {
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824,
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824
};
constexpr int32_t REQUANT4_M_L[MODEL_LAYERS] = {
    2124245376, 1920686976, 2138422784, 2049671808, 1907768448, 2037531008,
    1113657216, 1212957312, 1417219456, 1634339840, 2002711040, 1331169152
};
constexpr int32_t REQUANT_Q_M_L[MODEL_LAYERS] = {
    1813034880, 1209907456, 1377564032, 1225791744, 1248283776, 1075072640,
    2055051136, 2092017152, 1988269696, 1906497536, 1860659584, 1776902272
};
constexpr int32_t REQUANT_K_M_L[MODEL_LAYERS] = {
    1129002112, 1190968704, 1431062528, 1499243008, 1510219776, 1099941504,
    1078326272, 2141287808, 2047017984, 1972990976, 1954102656, 1855131008
};
constexpr int32_t REQUANT_V_M_L[MODEL_LAYERS] = {
    1832295808, 1600082944, 1566469632, 1417816576, 1476388864, 1515700224,
    1738937728, 1766078080, 1861172864, 2014714496, 2142325760, 1315078656
};
constexpr int32_t REQUANT_HEAD_M_L[MODEL_LAYERS] = {
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824,
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824
};

constexpr int32_t REQUANT1_N = REQUANT1_N_L[0];
constexpr int32_t REQUANT2_N = REQUANT2_N_L[0];
constexpr int32_t REQUANT3_N = REQUANT3_N_L[0];
constexpr int32_t REQUANT4_N = REQUANT4_N_L[0];
constexpr int32_t REQUANT_Q_N = REQUANT_Q_N_L[0];
constexpr int32_t REQUANT_K_N = REQUANT_K_N_L[0];
constexpr int32_t REQUANT_V_N = REQUANT_V_N_L[0];
constexpr int32_t REQUANT_HEAD_N = REQUANT_HEAD_N_L[0];
constexpr int32_t REQUANT1_M = REQUANT1_M_L[0];
constexpr int32_t REQUANT2_M = REQUANT2_M_L[0];
constexpr int32_t REQUANT3_M = REQUANT3_M_L[0];
constexpr int32_t REQUANT4_M = REQUANT4_M_L[0];
constexpr int32_t REQUANT_Q_M = REQUANT_Q_M_L[0];
constexpr int32_t REQUANT_K_M = REQUANT_K_M_L[0];
constexpr int32_t REQUANT_V_M = REQUANT_V_M_L[0];
constexpr int32_t REQUANT_HEAD_M = REQUANT_HEAD_M_L[0];
} // namespace requant_params

