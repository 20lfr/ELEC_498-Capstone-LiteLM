// tokenizer.hpp
// Tokenizer with vocabulary support

#ifndef TOKENIZER_HPP
#define TOKENIZER_HPP

#include <string>
#include <vector>
#include <unordered_map>
#include <fstream>
#include "logger.hpp"
#include "error_handler.hpp"

class Tokenizer {
private:
    std::unordered_map<std::string, uint32_t> token_to_id;
    std::unordered_map<uint32_t, std::string> id_to_token;
    uint32_t vocab_size;
    uint32_t eos_token_id;
    uint32_t bos_token_id;
    uint32_t unk_token_id;
    ErrorHandler error_handler;
    
public:
    Tokenizer() : vocab_size(0), eos_token_id(0), bos_token_id(1), unk_token_id(2) {}
    
    // Load vocabulary from file
    // Format: Each line is "token id"
    bool loadVocabulary(const std::string& vocab_file) {
        LOG_INFO("Loading vocabulary from: " + vocab_file);
        
        std::ifstream file(vocab_file);
        if (!file.is_open()) {
            error_handler.setError(ErrorCode::FILE_NOT_FOUND, 
                                   "Cannot open vocab file: " + vocab_file);
            LOG_ERROR("Failed to open vocabulary file");
            return false;
        }
        
        std::string line;
        uint32_t line_num = 0;
        
        while (std::getline(file, line)) {
            // Parse line: "token id" or just "token" (auto-assign id)
            size_t space_pos = line.find_last_of(' ');
            
            std::string token;
            uint32_t id;
            
            if (space_pos != std::string::npos) {
                token = line.substr(0, space_pos);
                id = std::stoul(line.substr(space_pos + 1));
            } else {
                token = line;
                id = line_num;
            }
            
            token_to_id[token] = id;
            id_to_token[id] = token;
            line_num++;
        }
        
        vocab_size = token_to_id.size();
        LOG_INFO("Loaded " + std::to_string(vocab_size) + " tokens");
        
        file.close();
        return true;
    }
    
    // Simple word-based tokenization
    // TODO: Replace with BPE/SentencePiece for production
    std::vector<uint32_t> encode(const std::string& text) {
        std::vector<uint32_t> token_ids;
        
        // Add BOS token
        token_ids.push_back(bos_token_id);
        
        // Simple whitespace tokenization (replace with real tokenizer!)
        std::string current_word;
        for (char c : text) {
            if (c == ' ' || c == '\n' || c == '\t') {
                if (!current_word.empty()) {
                    uint32_t id = getTokenId(current_word);
                    token_ids.push_back(id);
                    current_word.clear();
                }
            } else {
                current_word += c;
            }
        }
        
        // Last word
        if (!current_word.empty()) {
            uint32_t id = getTokenId(current_word);
            token_ids.push_back(id);
        }
        
        return token_ids;
    }
    
    // Decode token IDs to text
    std::string decode(const std::vector<uint32_t>& token_ids) {
        std::string text;
        
        for (uint32_t id : token_ids) {
            // Skip special tokens
            if (id == bos_token_id || id == eos_token_id) {
                continue;
            }
            
            auto it = id_to_token.find(id);
            if (it != id_to_token.end()) {
                if (!text.empty()) {
                    text += " ";  // Add space between tokens
                }
                text += it->second;
            } else {
                text += "<UNK>";
            }
        }
        
        return text;
    }
    
    // Decode single token
    std::string decodeToken(uint32_t token_id) {
        if (token_id == eos_token_id) return "";
        if (token_id == bos_token_id) return "";
        
        auto it = id_to_token.find(token_id);
        if (it != id_to_token.end()) {
            return it->second;
        }
        return "<UNK>";
    }
    
    // Get token ID for word
    uint32_t getTokenId(const std::string& token) {
        auto it = token_to_id.find(token);
        if (it != token_to_id.end()) {
            return it->second;
        }
        return unk_token_id;  // Unknown token
    }
    
    uint32_t getVocabSize() const { return vocab_size; }
    uint32_t getEOSTokenId() const { return eos_token_id; }
    uint32_t getBOSTokenId() const { return bos_token_id; }
    
    ErrorCode getLastError() const { return error_handler.getLastError(); }
    std::string getLastErrorMessage() const { 
        return error_handler.getLastErrorMessage(); 
    }
};

#endif // TOKENIZER_HPP
