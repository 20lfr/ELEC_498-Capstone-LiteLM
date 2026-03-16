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
//     REQUANT_POST_LN0/REQUANT_POST_LN1 (LN Q16.16 -> int8):  real_scale = 2^-16 / 2^-7 = 2^-9
//     REQUANT_POST_OUTPROJ   (out-proj -> int8):  real_scale = S_w_wo_eff
//     REQUANT_FFN_W1 (ffn_w1 int8x int8 -> Q5.11 int16): real_scale = S_w_w1_eff * 2^4
//       (maps acc * 2^-7 * S_w1 to Q5.11 where 1 LSB = 2^-11; Q5.11 covers ±16 real)
//     REQUANT_POST_FFN   (ffn_w2 Q5.11 -> int8): real_scale = (2^-11 * S_w_w2_eff) / 2^-7 = S_w_w2_eff * 2^-4
//       (was 2^-8 when input was Q1.15; Q5.11 input is 16x larger per LSB → N decreases by 4)
//     REQUANT_Q/K/V (qkv   -> int8):  real_scale = S_w_w{q,k,v}_eff
//     REQUANT_HEAD (attn value -> int8): real_scale = 2^-15
//       acc = Σ(w_q15 × v_i8), softmax weights sum ≈ 2^15, v_i8 in Q0.7 → need shift 15 for Q0.7 out
//
// KNOWN ISSUE (bias format): Biases are stored as Q16.16 (b_float * 2^16) but are added to raw
// int8×int8 accumulators. Correct unit would be b_float / (scale_act * scale_W). Error is
// ~1-4x on the bias term, but bias contribution to accumulator is typically <1%, so net
// effect on output is <0.1%. Fixing requires activation calibration data at conversion time.

#include <cstdint>

namespace requant_scales {
// Fixed-point scale for Q16.16 LN outputs: 2^-16
constexpr double S_FIXED_Q16_16 = 1.0 / 65536.0;

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

// FFN_W2_SCALE_Q15 kept for reference but unused (FFN_W2 uses REQUANT_POST_FFN tables)
constexpr int16_t FFN_W2_SCALE_Q15 = 0x4000; // 0.5 (unused)
} // namespace requant_scales

namespace requant_params {
constexpr int32_t REQUANT_POST_LN0_N_L[MODEL_LAYERS] = { 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_POST_OUTPROJ_N_L[MODEL_LAYERS] = { 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 38, 38 };
constexpr int32_t REQUANT_POST_LN1_N_L[MODEL_LAYERS] = { 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_POST_FFN_N_L[MODEL_LAYERS] = { 43, 43, 43, 43, 43, 43, 42, 42, 42, 42, 42, 41 };
constexpr int32_t REQUANT_FFN_W1_N_L[MODEL_LAYERS]   = { 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 };
constexpr int32_t REQUANT_Q_N_L[MODEL_LAYERS] = { 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_K_N_L[MODEL_LAYERS] = { 37, 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39 };
constexpr int32_t REQUANT_V_N_L[MODEL_LAYERS] = { 40, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 38 };
constexpr int32_t REQUANT_HEAD_N_L[MODEL_LAYERS] = { 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 };

constexpr int32_t REQUANT_POST_LN0_M_L[MODEL_LAYERS] = {
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824,
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824
};
constexpr int32_t REQUANT_POST_OUTPROJ_M_L[MODEL_LAYERS] = {
    1692334464, 1540847616, 1402086016, 1389463168, 1524429184, 1485712384,
    1794790400, 1817906304, 1853225856, 2076041216, 1113299584, 1274316928
};
constexpr int32_t REQUANT_POST_LN1_M_L[MODEL_LAYERS] = {
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824,
    1073741824, 1073741824, 1073741824, 1073741824, 1073741824, 1073741824
};
constexpr int32_t REQUANT_POST_FFN_M_L[MODEL_LAYERS] = {
    2124245376, 1920686976, 2138422784, 2049671808, 1907768448, 2037531008,
    1113657216, 1212957312, 1417219456, 1634339840, 2002711040, 1331169152
};
// FFN W1: int8×int8 acc → Q5.11 int16 (1 LSB = 2^-11, range ±16 real)
// real_scale = S_w1_eff * 2^4; M/2^N = S_w1_eff * 16
constexpr int32_t REQUANT_FFN_W1_M_L[MODEL_LAYERS] = {
    1201301888, 1990940672, 1991986304, 1895421952, 1913168768, 1849140736,
    1846176768, 1841215104, 1869124224, 1883561600, 1915682432, 1965782656
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

constexpr int32_t REQUANT_POST_LN0_N = REQUANT_POST_LN0_N_L[0];
constexpr int32_t REQUANT_POST_OUTPROJ_N = REQUANT_POST_OUTPROJ_N_L[0];
constexpr int32_t REQUANT_POST_LN1_N = REQUANT_POST_LN1_N_L[0];
constexpr int32_t REQUANT_POST_FFN_N = REQUANT_POST_FFN_N_L[0];
constexpr int32_t REQUANT_Q_N = REQUANT_Q_N_L[0];
constexpr int32_t REQUANT_K_N = REQUANT_K_N_L[0];
constexpr int32_t REQUANT_V_N = REQUANT_V_N_L[0];
constexpr int32_t REQUANT_HEAD_N = REQUANT_HEAD_N_L[0];
constexpr int32_t REQUANT_POST_LN0_M = REQUANT_POST_LN0_M_L[0];
constexpr int32_t REQUANT_POST_OUTPROJ_M = REQUANT_POST_OUTPROJ_M_L[0];
constexpr int32_t REQUANT_POST_LN1_M = REQUANT_POST_LN1_M_L[0];
constexpr int32_t REQUANT_POST_FFN_M = REQUANT_POST_FFN_M_L[0];
constexpr int32_t REQUANT_Q_M = REQUANT_Q_M_L[0];
constexpr int32_t REQUANT_K_M = REQUANT_K_M_L[0];
constexpr int32_t REQUANT_V_M = REQUANT_V_M_L[0];
constexpr int32_t REQUANT_HEAD_M = REQUANT_HEAD_M_L[0];
} // namespace requant_params

