#define TOP_NO_DEBUG_TB_BASENAME "top_no_debug_multiple_tokentb"
#define TOP_NO_DEBUG_TB_LOG_SUBDIR "top_no_debug_multiple_token"
#define main top_no_debug_tb_single_token_entry
#include "top_no_debug_tb.cpp"
#undef main

#include <fstream>

static size_t count_stream_tokens_from_file() {
    const std::string stream_path = tb_source_dir() + "/test_data/stream_in.bin";
    std::ifstream in(stream_path.c_str(), std::ios::binary | std::ios::ate);
    if (!in) {
        std::fprintf(stderr, "ERROR: Failed to open shared stream image '%s'\n", stream_path.c_str());
        return 0;
    }

    const std::streamoff total_bytes = in.tellg();
    if (total_bytes <= 0) {
        return 0;
    }

    const size_t usable_bytes = static_cast<size_t>(total_bytes);
    return usable_bytes / static_cast<size_t>(STREAM_IN_BUF_BYTES);
}

int main() {
    if (!init_tb_logs()) {
        return 1;
    }

    ensure_default_ctrl_mem_loaded();

    const size_t total_stream_tokens = count_stream_tokens_from_file();
    if (total_stream_tokens == 0) {
        std::fprintf(stderr, "ERROR: stream_in.bin does not contain any full tokens\n");
        return 1;
    }

    std::vector<axi_gmem_word_t> ddr_mem(static_cast<size_t>(TB_DDR_IMAGE_WORDS));
    std::vector<axi_gmem_word_t> kv_cache(static_cast<size_t>(TB_KV_IMAGE_WORDS));
    if (!load_shared_ddr_image(ddr_mem.data(), TB_DDR_IMAGE_WORDS)) {
        return 1;
    }
    zero_axi_mem(kv_cache.data(), TB_KV_IMAGE_WORDS);

    std::printf("[TEST] Multi-token run across %zu token(s) (debug_mode=%s)\n",
                total_stream_tokens, TB_DEBUG_MODE ? "on" : "off");
    dump_ctrl_mem_words(g_loaded_ctrl_mem);
    for (size_t token_idx = 0; token_idx < total_stream_tokens; ++token_idx) {
        std::printf("\n[TEST] ===== Begin token %zu =====\n", token_idx);
        const int rc = run_top_no_debug_tb_single_token_with_mem(
            token_idx, ddr_mem.data(), kv_cache.data());
        if (rc != 0) {
            std::fprintf(stderr, "ERROR: token %zu failed with rc=%d\n", token_idx, rc);
            return rc;
        }
        std::printf("[TEST] ===== End token %zu =====\n", token_idx);
    }

    std::printf("PASS: Multi-token inference complete for %zu token(s)\n", total_stream_tokens);
    return 0;
}
