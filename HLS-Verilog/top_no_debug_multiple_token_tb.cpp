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

    const size_t total_stream_tokens = count_stream_tokens_from_file();
    if (total_stream_tokens == 0) {
        std::fprintf(stderr, "ERROR: stream_in.bin does not contain any full tokens\n");
        return 1;
    }

    std::printf("[TEST] Multi-token autoregressive run across %zu token(s) (debug_mode=%s)\n",
                total_stream_tokens, tb_debug_mode_name());

    if (TB_AXI_DEBUG_MODE) {
        std::printf("[TEST] AXI debug mode has no stream dependence; running one session only.\n");
        return run_top_no_debug_tb_single_token(0);
    }

    return run_top_no_debug_tb_autoregressive();
}
