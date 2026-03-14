#pragma once
// Utility helpers for testbenches and C-sim drivers to locate repo-relative paths
// without hard-coding absolute directories.

#include <cstdlib>
#include <string>

#include <sys/stat.h>
#include <unistd.h>

namespace tb_paths {

static inline bool is_dir(const std::string &path) {
    struct stat st;
    return (stat(path.c_str(), &st) == 0) && S_ISDIR(st.st_mode);
}

static inline bool is_file(const std::string &path) {
    struct stat st;
    return (stat(path.c_str(), &st) == 0) && S_ISREG(st.st_mode);
}

static inline std::string normalize_slashes(std::string path) {
    for (char &c : path) {
        if (c == '\\') c = '/';
    }
    return path;
}

static inline std::string dirname_of(std::string path) {
    path = normalize_slashes(std::move(path));
    const std::string::size_type slash = path.find_last_of('/');
    if (slash == std::string::npos) return ".";
    if (slash == 0) return "/";
    return path.substr(0, slash);
}

static inline std::string parent_dir(std::string path) {
    path = normalize_slashes(std::move(path));
    if (path.empty() || path == "/" || path == ".") return path;
    while (!path.empty() && path.back() == '/') path.pop_back();
    const std::string::size_type slash = path.find_last_of('/');
    if (slash == std::string::npos) return ".";
    if (slash == 0) return "/";
    return path.substr(0, slash);
}

static inline bool looks_like_repo_root(const std::string &dir) {
    if (is_dir(dir + "/.git")) return true;
    // fallback marker check for tarball copies without .git
    return is_file(dir + "/README.md") && is_dir(dir + "/Model-architectures");
}

static inline std::string infer_repo_root_from_file(const char *file_macro) {
    const char *env_root = std::getenv("LITELM_REPO_ROOT");
    if (env_root != nullptr && env_root[0] != '\0') {
        return normalize_slashes(env_root);
    }

    std::string file_path = (file_macro != nullptr) ? normalize_slashes(file_macro) : std::string();

    // If __FILE__ is an absolute/relative path containing known repo layout markers,
    // derive repo root without relying on current working directory.
    const std::string marker_model = "/Model-architectures/";
    const std::string marker_hls = "/HLS-Verilog/";
    std::string::size_type pos = file_path.find(marker_model);
    if (pos != std::string::npos) {
        return file_path.substr(0, pos);
    }
    pos = file_path.find(marker_hls);
    if (pos != std::string::npos) {
        return file_path.substr(0, pos);
    }

    // Otherwise walk up from current working directory.
    char cwd_buf[4096];
    std::string cur = (::getcwd(cwd_buf, sizeof(cwd_buf)) != nullptr) ? normalize_slashes(cwd_buf)
                                                                      : std::string(".");
    for (int i = 0; i < 12; ++i) {
        if (looks_like_repo_root(cur)) {
            return normalize_slashes(cur);
        }
        const std::string next = parent_dir(cur);
        if (next == cur) break;
        cur = next;
    }
    return std::string();
}

static inline std::string log_root_from_file(const char *file_macro) {
    const char *env_log = std::getenv("LITELM_LOG_ROOT");
    if (env_log != nullptr && env_log[0] != '\0') {
        return normalize_slashes(env_log);
    }
    const std::string repo_root = infer_repo_root_from_file(file_macro);
    if (!repo_root.empty()) {
        return repo_root + "/logs";
    }
    return "logs";
}

} // namespace tb_paths
