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

    // GPT-2 byte <-> unicode mapping
    uint32_t byte_to_unicode[256];
    std::unordered_map<uint32_t, uint8_t> unicode_to_byte;

    ErrorHandler error_handler;
    void initByteUnicode() {
        int n = 0;
        for (int b = 0; b < 256; b++) {
            if ((b >= 33 && b <= 126) ||
                (b >= 161 && b <= 172) ||
                (b >= 174 && b <= 255)) {
                byte_to_unicode[b] = static_cast<uint32_t>(b);
            } else {
                byte_to_unicode[b] = static_cast<uint32_t>(256 + n);
                n++;
            }
        }
        unicode_to_byte.clear();
        for (int b = 0; b < 256; b++)
            unicode_to_byte[byte_to_unicode[b]] = static_cast<uint8_t>(b);
    }

    // ── Unicode codepoint to UTF-8 ──
    static std::string cpToUTF8(uint32_t cp) {
        std::string out;
        if (cp < 0x80) {
            out.push_back(static_cast<char>(cp));
        } else if (cp < 0x800) {
            out.push_back(static_cast<char>(0xC0 | (cp >> 6)));
            out.push_back(static_cast<char>(0x80 | (cp & 0x3F)));
        } else {
            out.push_back(static_cast<char>(0xE0 | (cp >> 12)));
            out.push_back(static_cast<char>(0x80 | ((cp >> 6) & 0x3F)));
            out.push_back(static_cast<char>(0x80 | (cp & 0x3F)));
        }
        return out;
    }

    // ── Raw bytes → GPT-2 unicode string ──
    std::string bytesToUnicode(const std::string &raw) const {
        std::string out;
        for (unsigned char b : raw)
            out += cpToUTF8(byte_to_unicode[b]);
        return out;
    }

    // ── GPT-2 unicode string → raw bytes ──
    std::string unicodeToBytes(const std::string &s) const {
        std::string out;
        size_t i = 0;
        while (i < s.size()) {
            uint32_t cp = 0;
            unsigned char c = static_cast<unsigned char>(s[i]);
            size_t len = 1;
            if ((c & 0x80) == 0)         { cp = c;          len = 1; }
            else if ((c & 0xE0) == 0xC0) { cp = c & 0x1F;   len = 2; }
            else if ((c & 0xF0) == 0xE0) { cp = c & 0x0F;   len = 3; }
            else if ((c & 0xF8) == 0xF0) { cp = c & 0x07;   len = 4; }
            for (size_t j = 1; j < len && i + j < s.size(); j++)
                cp = (cp << 6) | (static_cast<unsigned char>(s[i + j]) & 0x3F);
            auto it = unicode_to_byte.find(cp);
            if (it != unicode_to_byte.end())
                out.push_back(static_cast<char>(it->second));
            else
                out.append(s, i, len);
            i += len;
        }
        return out;
    }

    // ── Hex-escape decoding (for vocab.txt) ──
    static std::string hexUnescape(const std::string &s) {
        std::string out;
        out.reserve(s.size());
        for (size_t i = 0; i < s.size(); i++) {
            if (s[i] == '\\' && i + 3 < s.size() && s[i + 1] == 'x') {
                auto hv = [](char c) -> int {
                    if (c >= '0' && c <= '9') return c - '0';
                    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
                    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
                    return -1;
                };
                int h = hv(s[i + 2]), l = hv(s[i + 3]);
                if (h >= 0 && l >= 0) {
                    out.push_back(static_cast<char>((h << 4) | l));
                    i += 3; continue;
                }
            }
            out.push_back(s[i]);
        }
        return out;
    }

    // ── UTF-8 character splitting ──
    static std::vector<std::string> splitUTF8(const std::string &s) {
        std::vector<std::string> chars;
        size_t i = 0;
        while (i < s.size()) {
            size_t len = 1;
            unsigned char c = static_cast<unsigned char>(s[i]);
            if ((c & 0x80) == 0)         len = 1;
            else if ((c & 0xE0) == 0xC0) len = 2;
            else if ((c & 0xF0) == 0xE0) len = 3;
            else if ((c & 0xF8) == 0xF0) len = 4;
            if (i + len > s.size()) len = s.size() - i;
            chars.push_back(s.substr(i, len));
            i += len;
        }
        return chars;
    }

    std::vector<std::string> preTokenize(const std::string &text) const {
        std::vector<std::string> words;
        std::string current;

        auto isAlnum = [](char c) {
            return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
                   (c >= '0' && c <= '9');
        };

        size_t i = 0;
        while (i < text.size()) {
            char c = text[i];

            // Contractions
            if (c == '\'' && i + 1 < text.size()) {
                char nc = text[i + 1];
                if (nc == 's' || nc == 't' || nc == 'm' || nc == 'd') {
                    if (!current.empty()) { words.push_back(current); current.clear(); }
                    words.push_back(std::string(1, c) + nc);
                    i += 2; continue;
                }
                if (i + 2 < text.size()) {
                    std::string tri(text, i, 3);
                    if (tri == "'re" || tri == "'ve" || tri == "'ll") {
                        if (!current.empty()) { words.push_back(current); current.clear(); }
                        words.push_back(tri);
                        i += 3; continue;
                    }
                }
            }

            // Space starts new word (space belongs to next word in GPT-2)
            if (c == ' ') {
                if (!current.empty()) { words.push_back(current); current.clear(); }
                current.push_back(c);
                i++; continue;
            }

            // Split on alnum <-> punct boundary
            if (!current.empty() && current.back() != ' ') {
                bool prev_an = isAlnum(current.back());
                bool curr_an = isAlnum(c);
                if (prev_an != curr_an) {
                    words.push_back(current); current.clear();
                }
            }

            current.push_back(c);
            i++;
        }
        if (!current.empty()) words.push_back(current);
        return words;
    }

    // ── BPE on a single GPT-2 unicode word ──
    std::vector<std::string> applyBPE(const std::string &word) const {
        auto symbols = splitUTF8(word);
        if (symbols.size() <= 1) return symbols;

        while (symbols.size() > 1) {
            int best_rank = std::numeric_limits<int>::max();
            size_t best_pos = std::string::npos;
            for (size_t j = 0; j + 1 < symbols.size(); j++) {
                auto it = merge_priority.find({symbols[j], symbols[j + 1]});
                if (it != merge_priority.end() && it->second < best_rank) {
                    best_rank = it->second;
                    best_pos = j;
                }
            }
            if (best_pos == std::string::npos) break;
            symbols[best_pos] += symbols[best_pos + 1];
            symbols.erase(symbols.begin() + static_cast<long>(best_pos + 1));
        }
        return symbols;
    }

public:
    Tokenizer()
        : vocab_size(0), eos_token_id(50256), bos_token_id(50256),
          unk_token_id(50256) {
        initByteUnicode();
    }

    bool loadVocabulary(const std::string &vocab_file) {
        LOG_INFO("Loading vocabulary from: " + vocab_file);
        std::ifstream file(vocab_file);
        if (!file.is_open()) {
            error_handler.setError(ErrorCode::FILE_NOT_FOUND,
                                   "Cannot open vocab file: " + vocab_file);
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
            if (line.rfind("#config", 0) == 0) {
                std::istringstream ss(line.substr(7));
                uint32_t vs, bos, eos, unk;
                if (ss >> vs >> bos >> eos >> unk) {
                    bos_token_id = bos; eos_token_id = eos; unk_token_id = unk;
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
                uint32_t id = static_cast<uint32_t>(std::stoul(line.substr(tab + 1)));
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
                 std::to_string(merge_priority.size()) + " merges");
        return vocab_size > 0;
    }

    // ── GPT-2 Encode ──
    std::vector<uint32_t> encode(const std::string &text) {
        std::vector<uint32_t> ids;
        if (text.empty()) return ids;

        auto words = preTokenize(text);
        for (const auto &word : words) {
            std::string uword = bytesToUnicode(word);

            // Try whole word
            auto whole = token_to_id.find(uword);
            if (whole != token_to_id.end()) {
                ids.push_back(whole->second);
                continue;
            }

            // BPE merge
            auto symbols = applyBPE(uword);
            for (const auto &sym : symbols) {
                auto it = token_to_id.find(sym);
                if (it != token_to_id.end()) {
                    ids.push_back(it->second);
                } else {
                    ids.push_back(unk_token_id);
                }
            }
        }
        return ids;
    }

    // ── GPT-2 Decode ──
    std::string decode(const std::vector<uint32_t> &token_ids) {
        std::string ustr;
        for (uint32_t id : token_ids) {
            if (id == eos_token_id) break;
            auto it = id_to_token.find(id);
            if (it != id_to_token.end()) ustr += it->second;
        }
        return unicodeToBytes(ustr);
    }

    std::string decodeToken(uint32_t token_id) {
        if (token_id == eos_token_id) return "";
        auto it = id_to_token.find(token_id);
        if (it == id_to_token.end()) return "";
        return unicodeToBytes(it->second);
    }

    uint32_t getTokenId(const std::string &token) {
        auto it = token_to_id.find(token);
        return (it != token_to_id.end()) ? it->second : unk_token_id;
    }

    uint32_t getVocabSize() const { return vocab_size; }
    uint32_t getEOSTokenId() const { return eos_token_id; }
    uint32_t getBOSTokenId() const { return bos_token_id; }

    ErrorCode getLastError() const { return error_handler.getLastError(); }
    std::string getLastErrorMessage() const {
        return error_handler.getLastErrorMessage();
    }
};

#endif