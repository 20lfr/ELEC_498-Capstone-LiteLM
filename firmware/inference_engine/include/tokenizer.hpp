// tokenizer.hpp

#ifndef TOKENIZER_HPP
#define TOKENIZER_HPP

#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <limits>
#include <sstream>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "error_handler.hpp"
#include "logger.hpp"

class Tokenizer {
private:
    std::unordered_map<std::string, uint32_t> token_to_id;
    std::unordered_map<uint32_t, std::string> id_to_token;

    // BPE merge table: (left, right) → priority (lower = higher priority)
    struct PairHash {
        size_t operator()(const std::pair<std::string, std::string> &p) const {
            size_t h1 = std::hash<std::string>{}(p.first);
            size_t h2 = std::hash<std::string>{}(p.second);
            return h1 ^ (h2 * 0x9e3779b97f4a7c15ULL + 0x517cc1b727220a95ULL);
        }
    };
    std::unordered_map<std::pair<std::string, std::string>, int, PairHash>
        merge_priority;

    uint32_t vocab_size;
    uint32_t eos_token_id;
    uint32_t bos_token_id;
    uint32_t unk_token_id;

    // SentencePiece/Llama word-boundary marker (U+2581, "▁")
    static constexpr const char *SP_SPACE = "\xe2\x96\x81";
    static const int SP_SPACE_LEN = 3;

    ErrorHandler error_handler;

    // ---- Hex-escape decoding ----
    static std::string hexUnescape(const std::string &s) {
        std::string out;
        out.reserve(s.size());
        for (size_t i = 0; i < s.size(); i++) {
            if (s[i] == '\\' && i + 3 < s.size() && s[i + 1] == 'x') {
                auto hexVal = [](char c) -> int {
                    if (c >= '0' && c <= '9') return c - '0';
                    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
                    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
                    return -1;
                };
                int h = hexVal(s[i + 2]);
                int l = hexVal(s[i + 3]);
                if (h >= 0 && l >= 0) {
                    out.push_back(static_cast<char>((h << 4) | l));
                    i += 3;
                    continue;
                }
            }
            out.push_back(s[i]);
        }
        return out;
    }

    // ---- UTF-8 splitting ----
    static std::vector<std::string> splitUTF8(const std::string &s) {
        std::vector<std::string> chars;
        size_t i = 0;
        while (i < s.size()) {
            size_t len = 1;
            unsigned char c = static_cast<unsigned char>(s[i]);
            if ((c & 0x80) == 0)      len = 1;
            else if ((c & 0xE0) == 0xC0) len = 2;
            else if ((c & 0xF0) == 0xE0) len = 3;
            else if ((c & 0xF8) == 0xF0) len = 4;
            if (i + len > s.size()) len = s.size() - i;
            chars.push_back(s.substr(i, len));
            i += len;
        }
        return chars;
    }

    // ---- Byte fallback: char → "<0xHH>" token ----
    std::string byteFallback(unsigned char byte) const {
        char buf[8];
        snprintf(buf, sizeof(buf), "<0x%02X>", byte);
        return std::string(buf);
    }

public:
    Tokenizer()
        : vocab_size(0), eos_token_id(32000), bos_token_id(1),
          unk_token_id(0) {}

    // ---- Load vocabulary from export_vocab.py output ----
    bool loadVocabulary(const std::string &vocab_file) {
        LOG_INFO("Loading vocabulary from: " + vocab_file);

        std::ifstream file(vocab_file);
        if (!file.is_open()) {
            error_handler.setError(ErrorCode::FILE_NOT_FOUND,
                                   "Cannot open vocab file: " + vocab_file);
            LOG_ERROR("Failed to open vocabulary file");
            return false;
        }

        token_to_id.clear();
        id_to_token.clear();
        merge_priority.clear();

        enum Section { NONE, VOCAB, MERGES, ADDED } section = NONE;
        int merge_rank = 0;
        std::string line;

        while (std::getline(file, line)) {
            if (line.empty()) continue;

            // Parse header
            if (line.rfind("#config", 0) == 0) {
                std::istringstream ss(line.substr(7));
                uint32_t vs, bos, eos, unk;
                if (ss >> vs >> bos >> eos >> unk) {
                    bos_token_id = bos;
                    eos_token_id = eos;
                    unk_token_id = unk;
                }
                continue;
            }

            if (line == "#vocab")  { section = VOCAB;  continue; }
            if (line == "#merges") { section = MERGES;  continue; }
            if (line == "#added")  { section = ADDED;   continue; }
            if (line[0] == '#')    continue;

            size_t tab = line.find('\t');
            if (tab == std::string::npos) continue;

            if (section == VOCAB || section == ADDED) {
                std::string piece = hexUnescape(line.substr(0, tab));
                uint32_t id = static_cast<uint32_t>(
                    std::stoul(line.substr(tab + 1)));
                token_to_id[piece] = id;
                id_to_token[id] = piece;
            } else if (section == MERGES) {
                std::string left = hexUnescape(line.substr(0, tab));
                std::string right = hexUnescape(line.substr(tab + 1));
                merge_priority[{left, right}] = merge_rank++;
            }
        }

        vocab_size = static_cast<uint32_t>(token_to_id.size());
        LOG_INFO("Loaded " + std::to_string(vocab_size) + " tokens, " +
                 std::to_string(merge_priority.size()) + " merges" +
                 " (BOS=" + std::to_string(bos_token_id) +
                 " EOS=" + std::to_string(eos_token_id) +
                 " UNK=" + std::to_string(unk_token_id) + ")");

        file.close();
        return vocab_size > 0;
    }

    // ---- BPE Encoding ----
    std::vector<uint32_t> encode(const std::string &text) {
        std::vector<uint32_t> token_ids;

        if (text.empty()) return token_ids;

        // Normalize: prepend ▁, replace spaces with ▁
        // (matches tokenizer.json normalizer: Prepend("▁") + Replace(" ", "▁"))
        std::string normalized = SP_SPACE;
        for (char c : text) {
            if (c == ' ') {
                normalized += SP_SPACE;
            } else {
                normalized += c;
            }
        }

        // Split into UTF-8 characters, then map each to a vocab symbol
        // or byte fallback token
        std::vector<std::string> symbols;
        auto chars = splitUTF8(normalized);
        for (const auto &ch : chars) {
            if (token_to_id.count(ch)) {
                symbols.push_back(ch);
            } else {
                // Byte fallback: each byte becomes <0xHH>
                for (unsigned char b : ch) {
                    symbols.push_back(byteFallback(b));
                }
            }
        }

        // BPE: iteratively merge highest-priority pair
        while (symbols.size() > 1) {
            int best_rank = std::numeric_limits<int>::max();
            size_t best_pos = std::string::npos;

            for (size_t i = 0; i + 1 < symbols.size(); i++) {
                auto it = merge_priority.find({symbols[i], symbols[i + 1]});
                if (it != merge_priority.end() && it->second < best_rank) {
                    best_rank = it->second;
                    best_pos = i;
                }
            }

            if (best_pos == std::string::npos) break;

            symbols[best_pos] = symbols[best_pos] + symbols[best_pos + 1];
            symbols.erase(symbols.begin() +
                          static_cast<long>(best_pos + 1));
        }

        // Map symbols to token IDs
        for (const auto &sym : symbols) {
            auto it = token_to_id.find(sym);
            if (it != token_to_id.end()) {
                token_ids.push_back(it->second);
            } else {
                token_ids.push_back(unk_token_id);
            }
        }

        return token_ids;
    }

    // ---- Decoding ----
    std::string decode(const std::vector<uint32_t> &token_ids) {
        std::string raw;
        for (uint32_t id : token_ids) {
            if (id == bos_token_id || id == eos_token_id) continue;
            auto it = id_to_token.find(id);
            if (it != id_to_token.end())
                raw += it->second;
        }
        std::string result = postProcess(raw);
        // Strip leading space (matches HuggingFace Strip decoder: start=1)
        if (!result.empty() && result[0] == ' ')
            result.erase(0, 1);
        return result;
    }

    std::string decodeToken(uint32_t token_id) {
        if (token_id == eos_token_id || token_id == bos_token_id)
            return "";
        auto it = id_to_token.find(token_id);
        if (it == id_to_token.end()) return "";
        return postProcess(it->second);
    }

    // ---- Lookup ----
    uint32_t getTokenId(const std::string &token) {
        auto it = token_to_id.find(token);
        if (it != token_to_id.end()) return it->second;
        return unk_token_id;
    }

    uint32_t getVocabSize() const { return vocab_size; }
    uint32_t getEOSTokenId() const { return eos_token_id; }
    uint32_t getBOSTokenId() const { return bos_token_id; }

    ErrorCode getLastError() const { return error_handler.getLastError(); }
    std::string getLastErrorMessage() const {
        return error_handler.getLastErrorMessage();
    }

private:
    // ---- Post-process decoded text ----
    // 1. Resolve byte fallback tokens: <0xHH> → raw byte
    // 2. Replace ▁ → space
    std::string postProcess(const std::string &raw) {
        std::string resolved;
        resolved.reserve(raw.size());

        // Pass 1: resolve <0xHH> byte fallback tokens
        size_t i = 0;
        while (i < raw.size()) {
            if (i + 5 < raw.size() && raw[i] == '<' && raw[i + 1] == '0' &&
                raw[i + 2] == 'x' && raw[i + 5] == '>') {
                auto hexVal = [](char c) -> int {
                    if (c >= '0' && c <= '9') return c - '0';
                    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
                    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
                    return -1;
                };
                int h = hexVal(raw[i + 3]);
                int l = hexVal(raw[i + 4]);
                if (h >= 0 && l >= 0) {
                    resolved.push_back(static_cast<char>((h << 4) | l));
                    i += 6;
                    continue;
                }
            }
            resolved.push_back(raw[i]);
            i++;
        }

        // Pass 2: replace ▁ with space
        std::string result;
        result.reserve(resolved.size());
        i = 0;
        while (i < resolved.size()) {
            if (i + 2 < resolved.size() &&
                static_cast<unsigned char>(resolved[i]) == 0xE2 &&
                static_cast<unsigned char>(resolved[i + 1]) == 0x96 &&
                static_cast<unsigned char>(resolved[i + 2]) == 0x81) {
                result += ' ';
                i += 3;
            } else {
                result += resolved[i];
                i++;
            }
        }

        return result;
    }

    // ---- BPE core for a single word ----
    std::vector<uint32_t> bpeEncode(const std::string &word) {
        auto chars = splitUTF8(word);
        if (chars.empty()) return {};

        auto whole = token_to_id.find(word);
        if (whole != token_to_id.end())
            return {whole->second};

        while (chars.size() > 1) {
            int best_rank = std::numeric_limits<int>::max();
            size_t best_pos = std::string::npos;
            for (size_t j = 0; j + 1 < chars.size(); j++) {
                auto it = merge_priority.find({chars[j], chars[j + 1]});
                if (it != merge_priority.end() && it->second < best_rank) {
                    best_rank = it->second;
                    best_pos = j;
                }
            }
            if (best_pos == std::string::npos) break;
            chars[best_pos] = chars[best_pos] + chars[best_pos + 1];
            chars.erase(chars.begin() + static_cast<long>(best_pos + 1));
        }

        std::vector<uint32_t> ids;
        for (const auto &sym : chars) {
            auto it = token_to_id.find(sym);
            ids.push_back(it != token_to_id.end() ? it->second : unk_token_id);
        }
        return ids;
    }
};

#endif // TOKENIZER_HPP
