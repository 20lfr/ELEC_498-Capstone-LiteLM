#define TOP_NO_DEBUG_TB_BASENAME "top_no_debug_multiple_tokentb"
#define TOP_NO_DEBUG_TB_LOG_SUBDIR "top_no_debug_multiple_token"
#define main top_no_debug_tb_single_token_entry
#include "top_no_debug_tb.cpp"
#undef main

#include <algorithm>
#include <fstream>
#include <cstdlib>

static size_t count_stream_tokens_from_file() {
#ifdef FULL_MODEL_TEST
    const std::string stream_path = tb_source_dir() + "/../model/stream_in.bin";
#else
    const std::string stream_path = tb_source_dir() + "/test_data/stream_in.bin";
#endif
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
    const char *env_log_root = std::getenv("LITELM_LOG_ROOT");
    if (env_log_root == nullptr || env_log_root[0] == '\0') {
        const std::string repo_root = tb_paths::infer_repo_root_from_file(__FILE__);
        if (!repo_root.empty()) {
            const std::string log_root = repo_root + "/Model-architectures/gpt2-HARDWARE/logs";
            ::setenv("LITELM_LOG_ROOT", log_root.c_str(), 1);
        }
    }
    if (!init_tb_logs()) {
        return 1;
    }

    ensure_default_ctrl_mem_loaded();
    maybe_print_tb_repro_info();

    const size_t total_stream_tokens = count_stream_tokens_from_file();
    if (total_stream_tokens == 0) {
        std::fprintf(stderr, "ERROR: stream_in.bin does not contain any full tokens\n");
        return 1;
    }
    size_t run_stream_tokens = total_stream_tokens;
    if (const char *env_max_tokens = std::getenv("LITELM_TB_MAX_TOKENS")) {
        char *end = nullptr;
        const unsigned long parsed = std::strtoul(env_max_tokens, &end, 10);
        if (end != env_max_tokens && end != nullptr && *end == '\0' && parsed > 0) {
            run_stream_tokens = std::min(run_stream_tokens, static_cast<size_t>(parsed));
        }
    }

    std::vector<axi_gmem_word_t> ddr_mem(static_cast<size_t>(TB_DDR_IMAGE_WORDS));
    std::vector<axi_gmem_word_t> kv_cache(static_cast<size_t>(TB_KV_IMAGE_WORDS));
    if (!load_shared_ddr_image(ddr_mem.data(), TB_DDR_IMAGE_WORDS)) {
        return 1;
    }
    zero_axi_mem(kv_cache.data(), TB_KV_IMAGE_WORDS);

    {
        uint64_t ddr_checksum = 0;
        for (size_t wi = 0; wi < TB_DDR_IMAGE_WORDS; ++wi) {
            const uint32_t w = (uint32_t)ddr_mem[wi];
            ddr_checksum += (w & 0xFF);
            ddr_checksum += ((w >> 8) & 0xFF);
            ddr_checksum += ((w >> 16) & 0xFF);
            ddr_checksum += ((w >> 24) & 0xFF);
        }
        std::printf("[TEST] DDR image byte-sum checksum = %llu (0x%016llx)\n",
                    (unsigned long long)ddr_checksum, (unsigned long long)ddr_checksum);
    }

    std::printf("[TEST] Multi-token run across %zu/%zu token(s) (debug_mode=%s)\n",
                run_stream_tokens, total_stream_tokens, TB_DEBUG_MODE ? "on" : "off");
    dump_ctrl_mem_words(g_loaded_ctrl_mem);
    for (size_t token_idx = 0; token_idx < run_stream_tokens; ++token_idx) {
        std::printf("\n[TEST] ===== Begin token %zu =====\n", token_idx);
        const int rc = run_top_no_debug_tb_single_token_with_mem(
            token_idx, ddr_mem.data(), kv_cache.data());
        if (rc != 0) {
            std::fprintf(stderr, "ERROR: token %zu failed with rc=%d\n", token_idx, rc);
            return rc;
        }
        std::printf("[TEST] ===== End token %zu =====\n", token_idx);
    }

    std::printf("PASS: Multi-token inference complete for %zu token(s)\n", run_stream_tokens);
    return 0;
}
