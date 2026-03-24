#define TOP_NO_DEBUG_TB_BASENAME "top_no_debug_multiple_tokentb"
#define TOP_NO_DEBUG_TB_LOG_SUBDIR "top_no_debug_multiple_token"
#define main top_no_debug_tb_single_token_entry
#include "top_no_debug_tb.cpp"
#undef main

#include <algorithm>
#include <fstream>
#include <cstdlib>
#include <unordered_map>
#include <cstring>

// Number of autoregressive feedback steps to run after the prompt tokens.
// Each step feeds the previous output token id back as the next input.
// Set to 0 to disable. Has no effect in TB_DEBUG_MODE.
static constexpr size_t NUM_FEEDBACK_TOKENS = 3;

// Loads all tokens from stream_in.bin into a flat byte buffer.
// Returns the number of complete tokens loaded, or 0 on error.
// out_bytes is resized to (token_count * STREAM_IN_BUF_BYTES).
static size_t load_all_stream_tokens(std::vector<uint8_t> &out_bytes) {
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

    const size_t token_count =
        static_cast<size_t>(total_bytes) / static_cast<size_t>(STREAM_IN_BUF_BYTES);
    if (token_count == 0) {
        return 0;
    }

    const size_t load_bytes = token_count * static_cast<size_t>(STREAM_IN_BUF_BYTES);
    out_bytes.resize(load_bytes, 0);
    in.seekg(0, std::ios::beg);
    in.read(reinterpret_cast<char *>(out_bytes.data()),
            static_cast<std::streamsize>(load_bytes));
    if (static_cast<size_t>(in.gcount()) != load_bytes) {
        std::fprintf(stderr, "ERROR: Short read from '%s'\n", stream_path.c_str());
        return 0;
    }
    return token_count;
}

// Minimal JSON vocab parser — builds an id->token-string reverse map from
// the "model": { "vocab": { "TOKEN": ID, ... } } section of tokenizer.json.
static std::unordered_map<int32_t, std::string> load_tokenizer_vocab() {
    std::unordered_map<int32_t, std::string> id_to_token;
    const std::string path = tb_source_dir() + "/../model/tokenizer.json";
    std::ifstream f(path.c_str());
    if (!f) {
        std::fprintf(stderr, "[WARN] Could not open tokenizer at '%s' — token strings will not be shown\n",
                     path.c_str());
        return id_to_token;
    }
    const std::string content((std::istreambuf_iterator<char>(f)),
                               std::istreambuf_iterator<char>());

    // Locate "vocab": {
    const size_t vocab_pos = content.find("\"vocab\"");
    if (vocab_pos == std::string::npos) return id_to_token;
    const size_t brace_pos = content.find('{', vocab_pos);
    if (brace_pos == std::string::npos) return id_to_token;

    size_t pos = brace_pos + 1;
    while (pos < content.size()) {
        // skip whitespace
        while (pos < content.size() &&
               (content[pos] == ' ' || content[pos] == '\n' ||
                content[pos] == '\r' || content[pos] == '\t'))
            pos++;
        if (pos >= content.size() || content[pos] == '}') break;
        if (content[pos] != '"') break;
        pos++; // skip opening "

        // parse JSON string key (token text)
        std::string token;
        while (pos < content.size() && content[pos] != '"') {
            if (content[pos] == '\\' && pos + 1 < content.size()) {
                pos++;
                switch (content[pos]) {
                    case '"':  token += '"';  break;
                    case '\\': token += '\\'; break;
                    case 'n':  token += '\n'; break;
                    case 'r':  token += '\r'; break;
                    case 't':  token += '\t'; break;
                    case 'u': {
                        if (pos + 4 < content.size()) {
                            const unsigned int cp =
                                static_cast<unsigned int>(
                                    std::stoul(content.substr(pos + 1, 4), nullptr, 16));
                            pos += 4;
                            if (cp < 0x80u) {
                                token += static_cast<char>(cp);
                            } else if (cp < 0x800u) {
                                token += static_cast<char>(0xC0u | (cp >> 6));
                                token += static_cast<char>(0x80u | (cp & 0x3Fu));
                            } else {
                                token += static_cast<char>(0xE0u | (cp >> 12));
                                token += static_cast<char>(0x80u | ((cp >> 6) & 0x3Fu));
                                token += static_cast<char>(0x80u | (cp & 0x3Fu));
                            }
                        }
                        break;
                    }
                    default: token += content[pos]; break;
                }
            } else {
                token += content[pos];
            }
            pos++;
        }
        pos++; // skip closing "

        // skip ": "
        while (pos < content.size() && (content[pos] == ':' || content[pos] == ' ')) pos++;

        // parse integer value
        const size_t num_start = pos;
        while (pos < content.size() && std::isdigit(static_cast<unsigned char>(content[pos]))) pos++;
        if (pos > num_start) {
            const int32_t id = static_cast<int32_t>(
                std::stoul(content.substr(num_start, pos - num_start)));
            id_to_token[id] = std::move(token);
        }

        // advance past comma to next entry
        while (pos < content.size() && content[pos] != ',' && content[pos] != '}') pos++;
        if (pos < content.size() && content[pos] == ',') pos++;
    }
    return id_to_token;
}

// Builds the stream_in payload for a given token at a given position:
//   out_buf = wte[token_id] + wpe[position]  (saturating int8, element-wise)
// embed_tokens.bin: D_VOCAB rows x STREAM_IN_BUF_BYTES int8 bytes (wte)
// pos_embed.bin:    CONTEXT_LEN rows x STREAM_IN_BUF_BYTES int8 bytes (wpe)
static bool build_token_stream_input(int32_t token_id, size_t position,
                                     uint8_t out_buf[STREAM_IN_BUF_BYTES]) {
    const std::string model_dir = tb_source_dir() + "/../model/";

    // Load wte[token_id]
    uint8_t wte[STREAM_IN_BUF_BYTES] = {};
    {
        const std::string path = model_dir + "embed_tokens.bin";
        std::ifstream f(path.c_str(), std::ios::binary);
        if (!f) {
            std::fprintf(stderr, "ERROR: Could not open '%s'\n", path.c_str());
            return false;
        }
        f.seekg(static_cast<std::streamoff>(token_id) *
                static_cast<std::streamoff>(STREAM_IN_BUF_BYTES), std::ios::beg);
        f.read(reinterpret_cast<char *>(wte), STREAM_IN_BUF_BYTES);
        if (f.gcount() != static_cast<std::streamsize>(STREAM_IN_BUF_BYTES)) {
            std::fprintf(stderr, "ERROR: Short read from embed_tokens.bin for token %d\n", token_id);
            return false;
        }
    }

    // Load wpe[position]
    uint8_t wpe[STREAM_IN_BUF_BYTES] = {};
    {
        const std::string path = model_dir + "pos_embed.bin";
        std::ifstream f(path.c_str(), std::ios::binary);
        if (!f) {
            std::fprintf(stderr, "ERROR: Could not open '%s'\n", path.c_str());
            return false;
        }
        f.seekg(static_cast<std::streamoff>(position) *
                static_cast<std::streamoff>(STREAM_IN_BUF_BYTES), std::ios::beg);
        f.read(reinterpret_cast<char *>(wpe), STREAM_IN_BUF_BYTES);
        if (f.gcount() != static_cast<std::streamsize>(STREAM_IN_BUF_BYTES)) {
            std::fprintf(stderr, "ERROR: Short read from pos_embed.bin for position %zu\n", position);
            return false;
        }
    }

    // wte + wpe, saturating int8
    for (int i = 0; i < STREAM_IN_BUF_BYTES; ++i) {
        const int32_t sum = static_cast<int32_t>(static_cast<int8_t>(wte[i])) +
                            static_cast<int32_t>(static_cast<int8_t>(wpe[i]));
        const int32_t clamped = sum < -128 ? -128 : (sum > 127 ? 127 : sum);
        out_buf[i] = static_cast<uint8_t>(static_cast<int8_t>(clamped));
    }
    return true;
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

    const std::unordered_map<int32_t, std::string> vocab = load_tokenizer_vocab();

    std::vector<uint8_t> stream_bytes;
    const size_t total_stream_tokens = load_all_stream_tokens(stream_bytes);
    if (total_stream_tokens == 0) {
        std::fprintf(stderr, "ERROR: stream_in.bin does not contain any full tokens\n");
        return 1;
    }
    std::printf("[TEST] stream_in.bin loaded: %zu token(s) x %d bytes\n",
                total_stream_tokens, STREAM_IN_BUF_BYTES);
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

    std::vector<int32_t> output_tokens;
    output_tokens.reserve(run_stream_tokens + NUM_FEEDBACK_TOKENS);

    for (size_t token_idx = 0; token_idx < run_stream_tokens; ++token_idx) {
        std::printf("\n[TEST] ===== Begin prompt token %zu =====\n", token_idx);
        const uint8_t *token_bytes = stream_bytes.data() + token_idx * static_cast<size_t>(STREAM_IN_BUF_BYTES);
        const int32_t rc = run_top_no_debug_tb_single_token_with_mem(
            token_idx, token_bytes, ddr_mem.data(), kv_cache.data());
        if (rc < 0) {
            std::fprintf(stderr, "ERROR: prompt token %zu failed (rc=%d)\n", token_idx, rc);
            return 1;
        }
        const auto it = vocab.find(rc);
        const std::string token_str = (it != vocab.end()) ? it->second : "<unknown>";
        std::printf("[TEST] Output: id=%-6d  text=\"%s\"\n", rc, token_str.c_str());
        std::printf("[TEST] ===== End prompt token %zu =====\n", token_idx);
        output_tokens.push_back(rc);
    }

    // Autoregressive feedback: feed each output token back as the next input.
    // Skipped in debug mode since expected_debug_sum checks would be meaningless.
    if (!TB_DEBUG_MODE && NUM_FEEDBACK_TOKENS > 0 && !output_tokens.empty()) {
        std::printf("\n[TEST] Starting %zu feedback token(s) (autoregressive)\n",
                    NUM_FEEDBACK_TOKENS);
        for (size_t fb = 0; fb < NUM_FEEDBACK_TOKENS; ++fb) {
            const size_t token_idx = run_stream_tokens + fb;
            const int32_t prev_id = output_tokens.back();

            // Build wte[prev_id] + wpe[token_idx] for the stream input.
            uint8_t feedback_buf[STREAM_IN_BUF_BYTES] = {};
            if (!build_token_stream_input(prev_id, token_idx, feedback_buf)) {
                std::fprintf(stderr,
                             "ERROR: Failed to build stream input for token id %d at position %zu\n",
                             prev_id, token_idx);
                return 1;
            }

            std::printf("\n[TEST] ===== Begin feedback token %zu (input id=%d) =====\n",
                        fb, prev_id);
            const int32_t rc = run_top_no_debug_tb_single_token_with_mem(
                token_idx, feedback_buf, ddr_mem.data(), kv_cache.data());
            if (rc < 0) {
                std::fprintf(stderr, "ERROR: feedback token %zu failed (rc=%d)\n", fb, rc);
                return 1;
            }
            const auto it = vocab.find(rc);
            const std::string token_str = (it != vocab.end()) ? it->second : "<unknown>";
            std::printf("[TEST] Output: id=%-6d  text=\"%s\"\n", rc, token_str.c_str());
            std::printf("[TEST] ===== End feedback token %zu =====\n", fb);
            output_tokens.push_back(rc);
        }
    }

    std::printf("\nPASS: Multi-token inference complete (%zu prompt + %zu feedback token(s))\n",
                run_stream_tokens, NUM_FEEDBACK_TOKENS);
    std::printf("[TEST] Output token sequence:\n");
    for (size_t i = 0; i < output_tokens.size(); ++i) {
        const int32_t id = output_tokens[i];
        const auto it = vocab.find(id);
        const std::string token_str = (it != vocab.end()) ? it->second : "<unknown>";
        std::printf("  [%zu]  id=%-6d  text=\"%s\"\n", i, id, token_str.c_str());
    }
    return 0;
}
