#include "compute_controller.hpp"

#include <cstdint>
#include <cstdio>

namespace {

uint32_t make_instruction(ComputeOp op, uint8_t layer, uint8_t head, uint8_t tile) {
    return static_cast<uint32_t>(op)
        | (static_cast<uint32_t>(layer) << 8)
        | (static_cast<uint32_t>(head) << 16)
        | (static_cast<uint32_t>(tile) << 24);
}

int32_t sum_int8(const int8_t *data, int len) {
    int32_t sum = 0;
    for (int i = 0; i < len; ++i) {
        sum += static_cast<int32_t>(data[i]);
    }
    return sum;
}

int32_t sum_int16(const int16_t *data, int len) {
    int32_t sum = 0;
    for (int i = 0; i < len; ++i) {
        sum += static_cast<int32_t>(data[i]);
    }
    return sum;
}

int8_t requant_ref(int32_t x, int32_t m, int32_t n, int32_t z_out) {
    int64_t product = static_cast<int64_t>(x) * static_cast<int64_t>(m);
    int64_t rounded = 1LL << (n - 1);
    int32_t scaled = static_cast<int32_t>((product + rounded) >> n);
    int32_t shifted = scaled + z_out;

    if (shifted > 127) {
        return 127;
    }
    if (shifted < -128) {
        return -128;
    }
    return static_cast<int8_t>(shifted);
}

void fill_out_proj_weights(int4_t weights[D_MODEL * D_TILE_WO], int tile_idx) {
    const int out_base = tile_idx * D_TILE_WO;
    for (int t = 0; t < D_TILE_WO; ++t) {
        const int out = out_base + t;
        const int4_t w = (out % 2 == 0) ? int4_t(1) : int4_t(-1);
        for (int i = 0; i < D_MODEL; ++i) {
            weights[t * D_MODEL + i] = w;
        }
    }
}

void init_inputs(
    int8_t int8_activation[D_MODEL],
    int4_t ffn1_weights[D_MODEL * D_TILE_W1],
    int4_t ffn1_biases[D_TILE_W1],
    int16_t ffn1_scale[D_TILE_W1],
    int16_t relu_input[D_FFN],
    int16_t ffn2_input[D_FFN],
    int4_t ffn2_weights[D_TILE_W2 * D_FFN],
    int4_t ffn2_biases[D_TILE_W2],
    int16_t ffn2_scale[D_TILE_W2],
    int32_t requant_activation[D_MODEL],
    int32_t layernorm_gamma[D_MODEL],
    int32_t layernorm_beta[D_MODEL],
    int8_t residual[D_MODEL]
) {
    for (int i = 0; i < D_MODEL; ++i) {
        int8_activation[i] = static_cast<int8_t>((i % 16) - 8);
        requant_activation[i] = static_cast<int32_t>(i % 32);
        layernorm_gamma[i] = 0;
        layernorm_beta[i] = 5;
        residual[i] = static_cast<int8_t>((i % 4) - 2);
    }

    for (int i = 0; i < D_MODEL * D_TILE_W1; ++i) {
        ffn1_weights[i] = int4_t(1);
    }
    for (int i = 0; i < D_TILE_W1; ++i) {
        ffn1_biases[i] = int4_t(0);
        ffn1_scale[i] = static_cast<int16_t>(1 << 14);
    }

    for (int i = 0; i < D_FFN; ++i) {
        relu_input[i] = static_cast<int16_t>((i % 8) - 4);
        ffn2_input[i] = static_cast<int16_t>((i % 8) - 3);
    }

    for (int i = 0; i < D_TILE_W2 * D_FFN; ++i) {
        ffn2_weights[i] = int4_t(1);
    }
    for (int i = 0; i < D_TILE_W2; ++i) {
        ffn2_biases[i] = int4_t(0);
        ffn2_scale[i] = static_cast<int16_t>(1);
    }
}

void fill_int8(int8_t *data, int len, int8_t value) {
    for (int i = 0; i < len; ++i) {
        data[i] = value;
    }
}

void fill_int16(int16_t *data, int len, int16_t value) {
    for (int i = 0; i < len; ++i) {
        data[i] = value;
    }
}

void fill_int32(int32_t *data, int len, int32_t value) {
    for (int i = 0; i < len; ++i) {
        data[i] = value;
    }
}

struct TestCase {
    ComputeOp op;
    const char *name;
    int tile;
    bool expect_error;
    bool check_output;
};

bool check_outputs(
    const TestCase &test,
    const int8_t int8_activation[D_MODEL],
    const int4_t out_proj_weights[D_MODEL * D_TILE_WO],
    const int32_t out_proj_bias[D_TILE_WO],
    const int32_t out_proj_accum[D_TILE_WO],
    const int16_t ffn1_output[D_TILE_W1],
    const int16_t relu_input[D_FFN],
    const int16_t relu_output[D_FFN],
    const int32_t requant_activation[D_MODEL],
    int32_t requant_scale,
    int32_t requant_shift,
    int32_t requant_zero_point,
    const int8_t requant_output[D_MODEL],
    const int32_t layernorm_beta[D_MODEL],
    const int32_t layernorm_out[D_MODEL],
    const int8_t residual[D_MODEL],
    const int8_t residual_out[D_MODEL],
    const int16_t ffn2_input[D_FFN],
    const int32_t ffn2_output[D_MODEL]
) {
    switch (test.op) {
        case CMP_OUT_PROJ: {
            const int32_t sum = sum_int8(int8_activation, D_MODEL);
            for (int t = 0; t < D_TILE_WO; ++t) {
                const int out_idx = test.tile * D_TILE_WO + t;
                const int32_t expected = ((out_idx % 2 == 0) ? sum : -sum) + out_proj_bias[t];
                if (out_proj_accum[t] != expected) {
                    std::fprintf(stderr,
                                 "OUT_PROJ mismatch at t=%d: got %d expected %d\n",
                                 t, static_cast<int>(out_proj_accum[t]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_REQUANT1:
        case CMP_REQUANT3:
        case CMP_REQUANT4: {
            for (int i = 0; i < D_MODEL; ++i) {
                const int8_t expected = requant_ref(requant_activation[i],
                                                    requant_scale,
                                                    requant_shift,
                                                    requant_zero_point);
                if (requant_output[i] != expected) {
                    std::fprintf(stderr,
                                 "%s mismatch at i=%d: got %d expected %d\n",
                                 test.name,
                                 i,
                                 static_cast<int>(requant_output[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_RESID0:
        case CMP_RESID1: {
            for (int i = 0; i < D_MODEL; ++i) {
                const int8_t expected = static_cast<int8_t>(
                    static_cast<int>(int8_activation[i]) + static_cast<int>(residual[i]));
                if (residual_out[i] != expected) {
                    std::fprintf(stderr,
                                 "%s mismatch at i=%d: got %d expected %d\n",
                                 test.name,
                                 i,
                                 static_cast<int>(residual_out[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_LN0:
        case CMP_LN1: {
            for (int i = 0; i < D_MODEL; ++i) {
                const int32_t expected = layernorm_beta[i];
                if (layernorm_out[i] != expected) {
                    std::fprintf(stderr,
                                 "%s mismatch at i=%d: got %d expected %d\n",
                                 test.name,
                                 i,
                                 static_cast<int>(layernorm_out[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_FFN_W1: {
            const int32_t sum = sum_int8(int8_activation, D_MODEL);
            for (int i = 0; i < D_TILE_W1; ++i) {
                const int16_t expected = static_cast<int16_t>(sum >> 1);
                if (ffn1_output[i] != expected) {
                    std::fprintf(stderr,
                                 "FFN_W1 mismatch at i=%d: got %d expected %d\n",
                                 i,
                                 static_cast<int>(ffn1_output[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_FFN_ACT: {
            for (int i = 0; i < D_FFN; ++i) {
                const int16_t expected = (relu_input[i] < 0) ? 0 : relu_input[i];
                if (relu_output[i] != expected) {
                    std::fprintf(stderr,
                                 "FFN_ACT mismatch at i=%d: got %d expected %d\n",
                                 i,
                                 static_cast<int>(relu_output[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        case CMP_FFN_W2: {
            const int32_t sum = sum_int16(ffn2_input, D_FFN);
            for (int i = 0; i < D_TILE_W2; ++i) {
                const int32_t expected = sum;
                if (ffn2_output[i] != expected) {
                    std::fprintf(stderr,
                                 "FFN_W2 mismatch at i=%d: got %d expected %d\n",
                                 i,
                                 static_cast<int>(ffn2_output[i]),
                                 static_cast<int>(expected));
                    return false;
                }
            }
            return true;
        }
        default:
            return true;
    }
}

bool run_op(
    const TestCase &test,
    int8_t int8_activation[D_MODEL],
    int4_t out_proj_weights[D_MODEL * D_TILE_WO],
    int32_t out_proj_bias[D_TILE_WO],
    int32_t out_proj_accum[D_TILE_WO],
    int4_t ffn1_weights[D_MODEL * D_TILE_W1],
    int4_t ffn1_biases[D_TILE_W1],
    int16_t ffn1_scale[D_TILE_W1],
    int16_t ffn1_output[D_TILE_W1],
    int16_t relu_input[D_FFN],
    int16_t relu_output[D_FFN],
    int16_t ffn2_input[D_FFN],
    int4_t ffn2_weights[D_TILE_W2 * D_FFN],
    int4_t ffn2_biases[D_TILE_W2],
    int16_t ffn2_scale[D_TILE_W2],
    int32_t ffn2_output[D_MODEL],
    int32_t requant_activation[D_MODEL],
    int32_t &requant_scale,
    int32_t &requant_shift,
    int32_t &requant_zero_point,
    int8_t requant_output[D_MODEL],
    int32_t layernorm_gamma[D_MODEL],
    int32_t layernorm_beta[D_MODEL],
    int32_t &layernorm_epsilon,
    int32_t layernorm_out[D_MODEL],
    int8_t residual[D_MODEL],
    int8_t residual_out[D_MODEL]
) {
    bool compute_ready = false;
    bool compute_done = false;
    bool error = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    bool mem_transfer_done = false;
    uint32_t mem_op = 0;

    bool compute_start = false;
    bool started = false;

    const uint32_t instruction = make_instruction(test.op, 1, 0, static_cast<uint8_t>(test.tile));

    enum class MemPending { NONE, READ, WRITE };
    MemPending mem_pending = MemPending::NONE;
    bool mem_busy = false;
    int mem_timer = 0;
    const int MEM_LAT = 2;
    const int MAX_CYCLES = 200;

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        mem_transfer_done = false;
        if (mem_busy) {
            if (mem_timer == 0) {
                mem_transfer_done = true;
                mem_busy = false;
                mem_pending = MemPending::NONE;
            } else {
                --mem_timer;
            }
        }

        compute_controller(
            false,
            compute_start,
            instruction,
            compute_ready,
            compute_done,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            int8_activation,
            out_proj_weights,
            out_proj_bias,
            out_proj_accum,
            ffn1_weights,
            ffn1_biases,
            ffn1_scale,
            ffn1_output,
            relu_input,
            relu_output,
            ffn2_input,
            ffn2_weights,
            ffn2_biases,
            ffn2_scale,
            ffn2_output,
            requant_activation,
            requant_scale,
            requant_shift,
            requant_zero_point,
            requant_output,
            layernorm_gamma,
            layernorm_beta,
            layernorm_epsilon,
            layernorm_out,
            residual,
            residual_out,
            error);

        if (!mem_busy) {
            if (mem_read_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::READ;
            } else if (mem_write_request) {
                mem_busy = true;
                mem_timer = MEM_LAT - 1;
                mem_pending = MemPending::WRITE;
            }
        }

        compute_start = false;
        if (!started && compute_ready) {
            compute_start = true;
            started = true;
        }

        if (compute_done) {
            break;
        }
    }

    if (!compute_done) {
        std::fprintf(stderr, "%s timed out waiting for compute_done\n", test.name);
        return false;
    }

    if (error != test.expect_error) {
        std::fprintf(stderr,
                     "%s error mismatch: got %d expected %d\n",
                     test.name,
                     error ? 1 : 0,
                     test.expect_error ? 1 : 0);
        return false;
    }

    if (test.expect_error) {
        return true;
    }

    if (!test.check_output) {
        return true;
    }

    return check_outputs(
        test,
        int8_activation,
        out_proj_weights,
        out_proj_bias,
        out_proj_accum,
        ffn1_output,
        relu_input,
        relu_output,
        requant_activation,
        requant_scale,
        requant_shift,
        requant_zero_point,
        requant_output,
        layernorm_beta,
        layernorm_out,
        residual,
        residual_out,
        ffn2_input,
        ffn2_output);
}

void reset_controller(
    int8_t int8_activation[D_MODEL],
    int4_t out_proj_weights[D_MODEL * D_TILE_WO],
    int32_t out_proj_bias[D_TILE_WO],
    int32_t out_proj_accum[D_TILE_WO],
    int4_t ffn1_weights[D_MODEL * D_TILE_W1],
    int4_t ffn1_biases[D_TILE_W1],
    int16_t ffn1_scale[D_TILE_W1],
    int16_t ffn1_output[D_TILE_W1],
    int16_t relu_input[D_FFN],
    int16_t relu_output[D_FFN],
    int16_t ffn2_input[D_FFN],
    int4_t ffn2_weights[D_TILE_W2 * D_FFN],
    int4_t ffn2_biases[D_TILE_W2],
    int16_t ffn2_scale[D_TILE_W2],
    int32_t ffn2_output[D_MODEL],
    int32_t requant_activation[D_MODEL],
    int32_t &requant_scale,
    int32_t &requant_shift,
    int32_t &requant_zero_point,
    int8_t requant_output[D_MODEL],
    int32_t layernorm_gamma[D_MODEL],
    int32_t layernorm_beta[D_MODEL],
    int32_t &layernorm_epsilon,
    int32_t layernorm_out[D_MODEL],
    int8_t residual[D_MODEL],
    int8_t residual_out[D_MODEL]
) {
    bool compute_ready = false;
    bool compute_done = false;
    bool error = false;
    bool mem_read_request = false;
    bool mem_write_request = false;
    bool mem_transfer_done = false;
    uint32_t mem_op = 0;

    for (int i = 0; i < 2; ++i) {
        compute_controller(
            true,
            false,
            0,
            compute_ready,
            compute_done,
            mem_transfer_done,
            mem_read_request,
            mem_write_request,
            mem_op,
            int8_activation,
            out_proj_weights,
            out_proj_bias,
            out_proj_accum,
            ffn1_weights,
            ffn1_biases,
            ffn1_scale,
            ffn1_output,
            relu_input,
            relu_output,
            ffn2_input,
            ffn2_weights,
            ffn2_biases,
            ffn2_scale,
            ffn2_output,
            requant_activation,
            requant_scale,
            requant_shift,
            requant_zero_point,
            requant_output,
            layernorm_gamma,
            layernorm_beta,
            layernorm_epsilon,
            layernorm_out,
            residual,
            residual_out,
            error);
    }
}

} // namespace

int main() {
    int8_t int8_activation[D_MODEL] = {};
    int4_t out_proj_weights[D_MODEL * D_TILE_WO] = {};
    int32_t out_proj_bias[D_TILE_WO] = {};
    int32_t out_proj_accum[D_TILE_WO] = {};

    int4_t ffn1_weights[D_MODEL * D_TILE_W1] = {};
    int4_t ffn1_biases[D_TILE_W1] = {};
    int16_t ffn1_scale[D_TILE_W1] = {};
    int16_t ffn1_output[D_TILE_W1] = {};

    int16_t relu_input[D_FFN] = {};
    int16_t relu_output[D_FFN] = {};

    int16_t ffn2_input[D_FFN] = {};
    int4_t ffn2_weights[D_TILE_W2 * D_FFN] = {};
    int4_t ffn2_biases[D_TILE_W2] = {};
    int16_t ffn2_scale[D_TILE_W2] = {};
    int32_t ffn2_output[D_MODEL] = {};

    int32_t requant_activation[D_MODEL] = {};
    int32_t requant_scale = 1;
    int32_t requant_shift = 1;
    int32_t requant_zero_point = 0;
    int8_t requant_output[D_MODEL] = {};

    int32_t layernorm_gamma[D_MODEL] = {};
    int32_t layernorm_beta[D_MODEL] = {};
    int32_t layernorm_epsilon = 1;
    int32_t layernorm_out[D_MODEL] = {};

    int8_t residual[D_MODEL] = {};
    int8_t residual_out[D_MODEL] = {};

    init_inputs(
        int8_activation,
        ffn1_weights,
        ffn1_biases,
        ffn1_scale,
        relu_input,
        ffn2_input,
        ffn2_weights,
        ffn2_biases,
        ffn2_scale,
        requant_activation,
        layernorm_gamma,
        layernorm_beta,
        residual);

    for (int t = 0; t < D_TILE_WO; ++t) {
        out_proj_bias[t] = static_cast<int32_t>(t - 2);
    }

    reset_controller(
        int8_activation,
        out_proj_weights,
        out_proj_bias,
        out_proj_accum,
        ffn1_weights,
        ffn1_biases,
        ffn1_scale,
        ffn1_output,
        relu_input,
        relu_output,
        ffn2_input,
        ffn2_weights,
        ffn2_biases,
        ffn2_scale,
        ffn2_output,
        requant_activation,
        requant_scale,
        requant_shift,
        requant_zero_point,
        requant_output,
        layernorm_gamma,
        layernorm_beta,
        layernorm_epsilon,
        layernorm_out,
        residual,
        residual_out);

    const TestCase tests[] = {
        {CMP_OUT_PROJ, "OUT_PROJ", 0, false, true},
        {CMP_REQUANT1, "REQUANT1", 0, false, true},
        {CMP_RESID0, "RESID0", 0, false, true},
        {CMP_LN0, "LN0", 0, false, true},
        {CMP_REQUANT3, "REQUANT3", 0, false, true},
        {CMP_FFN_W1, "FFN_W1", 0, false, true},
        {CMP_FFN_ACT, "FFN_ACT", 0, false, true},
        {CMP_FFN_W2, "FFN_W2", 0, false, true},
        {CMP_REQUANT4, "REQUANT4", 0, false, true},
        {CMP_RESID1, "RESID1", 0, false, true},
        {CMP_LN1, "LN1", 0, false, true},
        {CMP_DEQUANT, "DEQUANT", 0, true, false},
        {CMP_LOGITS, "LOGITS", 0, true, false},
        {CMP_REQUANT2, "REQUANT2", 0, true, false}
    };

    int failures = 0;
    for (const auto &test : tests) {
        if (test.op == CMP_OUT_PROJ) {
            fill_out_proj_weights(out_proj_weights, test.tile);
            fill_int32(out_proj_accum, D_TILE_WO, 0x7f7f7f7f);
        } else if (test.op == CMP_REQUANT1 || test.op == CMP_REQUANT3 || test.op == CMP_REQUANT4) {
            fill_int8(requant_output, D_MODEL, static_cast<int8_t>(0x7f));
        } else if (test.op == CMP_RESID0 || test.op == CMP_RESID1) {
            fill_int8(residual_out, D_MODEL, static_cast<int8_t>(0x7f));
        } else if (test.op == CMP_LN0 || test.op == CMP_LN1) {
            fill_int32(layernorm_out, D_MODEL, 0);
        } else if (test.op == CMP_FFN_W1) {
            fill_int16(ffn1_output, D_TILE_W1, static_cast<int16_t>(0x7f7f));
        } else if (test.op == CMP_FFN_ACT) {
            fill_int16(relu_output, D_FFN, static_cast<int16_t>(0x7f7f));
        } else if (test.op == CMP_FFN_W2) {
            fill_int32(ffn2_output, D_MODEL, 0x7f7f7f7f);
        }

        const bool ok = run_op(
            test,
            int8_activation,
            out_proj_weights,
            out_proj_bias,
            out_proj_accum,
            ffn1_weights,
            ffn1_biases,
            ffn1_scale,
            ffn1_output,
            relu_input,
            relu_output,
            ffn2_input,
            ffn2_weights,
            ffn2_biases,
            ffn2_scale,
            ffn2_output,
            requant_activation,
            requant_scale,
            requant_shift,
            requant_zero_point,
            requant_output,
            layernorm_gamma,
            layernorm_beta,
            layernorm_epsilon,
            layernorm_out,
            residual,
            residual_out);

        if (!ok) {
            std::fprintf(stderr, "Test failed: %s\n", test.name);
            failures++;
        } else {
            std::printf("Test passed: %s\n", test.name);
        }
    }

    if (failures) {
        std::fprintf(stderr, "compute_controller_tb: %d failure(s)\n", failures);
        return 1;
    }

    std::printf("compute_controller_tb: PASS\n");
    return 0;
}
