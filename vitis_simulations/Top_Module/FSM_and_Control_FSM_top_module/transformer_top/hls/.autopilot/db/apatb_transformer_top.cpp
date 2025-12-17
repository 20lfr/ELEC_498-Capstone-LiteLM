#include "hls_signal_handler.h"
#include <algorithm>
#include <complex>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <fstream>
#include <functional>
#include <iomanip>
#include <iostream>
#include <map>
#include <set>
#include "ap_fixed.h"
#include "ap_int.h"
#include "autopilot_cbe.h"
#include "hls_half.h"
#include "hls_directio.h"
#include "hls_stream.h"

using namespace std;

// wrapc file define:
#define AUTOTB_TVIN_axis_in_valid "../tv/cdatafile/c.transformer_top.autotvin_axis_in_valid.dat"
#define AUTOTB_TVOUT_axis_in_valid "../tv/cdatafile/c.transformer_top.autotvout_axis_in_valid.dat"
#define AUTOTB_TVIN_axis_in_last "../tv/cdatafile/c.transformer_top.autotvin_axis_in_last.dat"
#define AUTOTB_TVOUT_axis_in_last "../tv/cdatafile/c.transformer_top.autotvout_axis_in_last.dat"
#define AUTOTB_TVIN_axis_in_ready "../tv/cdatafile/c.transformer_top.autotvin_axis_in_ready.dat"
#define AUTOTB_TVOUT_axis_in_ready "../tv/cdatafile/c.transformer_top.autotvout_axis_in_ready.dat"
#define AUTOTB_TVIN_dma_done "../tv/cdatafile/c.transformer_top.autotvin_dma_done.dat"
#define AUTOTB_TVOUT_dma_done "../tv/cdatafile/c.transformer_top.autotvout_dma_done.dat"
#define AUTOTB_TVIN_dma_address "../tv/cdatafile/c.transformer_top.autotvin_dma_address.dat"
#define AUTOTB_TVOUT_dma_address "../tv/cdatafile/c.transformer_top.autotvout_dma_address.dat"
#define AUTOTB_TVIN_memory_request "../tv/cdatafile/c.transformer_top.autotvin_memory_request.dat"
#define AUTOTB_TVOUT_memory_request "../tv/cdatafile/c.transformer_top.autotvout_memory_request.dat"
#define AUTOTB_TVIN_compute_ready "../tv/cdatafile/c.transformer_top.autotvin_compute_ready.dat"
#define AUTOTB_TVOUT_compute_ready "../tv/cdatafile/c.transformer_top.autotvout_compute_ready.dat"
#define AUTOTB_TVIN_compute_done "../tv/cdatafile/c.transformer_top.autotvin_compute_done.dat"
#define AUTOTB_TVOUT_compute_done "../tv/cdatafile/c.transformer_top.autotvout_compute_done.dat"
#define AUTOTB_TVIN_compute_start "../tv/cdatafile/c.transformer_top.autotvin_compute_start.dat"
#define AUTOTB_TVOUT_compute_start "../tv/cdatafile/c.transformer_top.autotvout_compute_start.dat"
#define AUTOTB_TVIN_compute_op "../tv/cdatafile/c.transformer_top.autotvin_compute_op.dat"
#define AUTOTB_TVOUT_compute_op "../tv/cdatafile/c.transformer_top.autotvout_compute_op.dat"
#define AUTOTB_TVIN_head_ctx_ref_0 "../tv/cdatafile/c.transformer_top.autotvin_head_ctx_ref_0.dat"
#define AUTOTB_TVOUT_head_ctx_ref_0 "../tv/cdatafile/c.transformer_top.autotvout_head_ctx_ref_0.dat"
#define AUTOTB_TVIN_head_ctx_ref_1 "../tv/cdatafile/c.transformer_top.autotvin_head_ctx_ref_1.dat"
#define AUTOTB_TVOUT_head_ctx_ref_1 "../tv/cdatafile/c.transformer_top.autotvout_head_ctx_ref_1.dat"
#define AUTOTB_TVIN_head_ctx_ref_2 "../tv/cdatafile/c.transformer_top.autotvin_head_ctx_ref_2.dat"
#define AUTOTB_TVOUT_head_ctx_ref_2 "../tv/cdatafile/c.transformer_top.autotvout_head_ctx_ref_2.dat"
#define AUTOTB_TVIN_head_ctx_ref_3 "../tv/cdatafile/c.transformer_top.autotvin_head_ctx_ref_3.dat"
#define AUTOTB_TVOUT_head_ctx_ref_3 "../tv/cdatafile/c.transformer_top.autotvout_head_ctx_ref_3.dat"
#define AUTOTB_TVIN_stream_ready "../tv/cdatafile/c.transformer_top.autotvin_stream_ready.dat"
#define AUTOTB_TVOUT_stream_ready "../tv/cdatafile/c.transformer_top.autotvout_stream_ready.dat"
#define AUTOTB_TVIN_stream_start "../tv/cdatafile/c.transformer_top.autotvin_stream_start.dat"
#define AUTOTB_TVOUT_stream_start "../tv/cdatafile/c.transformer_top.autotvout_stream_start.dat"
#define AUTOTB_TVIN_stream_done "../tv/cdatafile/c.transformer_top.autotvin_stream_done.dat"
#define AUTOTB_TVOUT_stream_done "../tv/cdatafile/c.transformer_top.autotvout_stream_done.dat"
#define AUTOTB_TVIN_ctrl_addr "../tv/cdatafile/c.transformer_top.autotvin_ctrl_addr.dat"
#define AUTOTB_TVOUT_ctrl_addr "../tv/cdatafile/c.transformer_top.autotvout_ctrl_addr.dat"
#define AUTOTB_TVIN_ctrl_data_in "../tv/cdatafile/c.transformer_top.autotvin_ctrl_data_in.dat"
#define AUTOTB_TVOUT_ctrl_data_in "../tv/cdatafile/c.transformer_top.autotvout_ctrl_data_in.dat"
#define AUTOTB_TVIN_ctrl_data_out "../tv/cdatafile/c.transformer_top.autotvin_ctrl_data_out.dat"
#define AUTOTB_TVOUT_ctrl_data_out "../tv/cdatafile/c.transformer_top.autotvout_ctrl_data_out.dat"
#define AUTOTB_TVIN_ctrl_read_en "../tv/cdatafile/c.transformer_top.autotvin_ctrl_read_en.dat"
#define AUTOTB_TVOUT_ctrl_read_en "../tv/cdatafile/c.transformer_top.autotvout_ctrl_read_en.dat"
#define AUTOTB_TVIN_ctrl_write_en "../tv/cdatafile/c.transformer_top.autotvin_ctrl_write_en.dat"
#define AUTOTB_TVOUT_ctrl_write_en "../tv/cdatafile/c.transformer_top.autotvout_ctrl_write_en.dat"
#define AUTOTB_TVIN_ctrl_chip_en "../tv/cdatafile/c.transformer_top.autotvin_ctrl_chip_en.dat"
#define AUTOTB_TVOUT_ctrl_chip_en "../tv/cdatafile/c.transformer_top.autotvout_ctrl_chip_en.dat"
#define AUTOTB_TVIN_ctrl_resetn_in "../tv/cdatafile/c.transformer_top.autotvin_ctrl_resetn_in.dat"
#define AUTOTB_TVOUT_ctrl_resetn_in "../tv/cdatafile/c.transformer_top.autotvout_ctrl_resetn_in.dat"
#define AUTOTB_TVIN_irq_ps "../tv/cdatafile/c.transformer_top.autotvin_irq_ps.dat"
#define AUTOTB_TVOUT_irq_ps "../tv/cdatafile/c.transformer_top.autotvout_irq_ps.dat"
#define AUTOTB_TVIN_dbg_state "../tv/cdatafile/c.transformer_top.autotvin_dbg_state.dat"
#define AUTOTB_TVOUT_dbg_state "../tv/cdatafile/c.transformer_top.autotvout_dbg_state.dat"
#define AUTOTB_TVIN_dbg_ctrl_mem "../tv/cdatafile/c.transformer_top.autotvin_dbg_ctrl_mem.dat"
#define AUTOTB_TVOUT_dbg_ctrl_mem "../tv/cdatafile/c.transformer_top.autotvout_dbg_ctrl_mem.dat"
#define AUTOTB_TVIN_control_reg "../tv/cdatafile/c.transformer_top.autotvin_control_reg.dat"
#define AUTOTB_TVOUT_control_reg "../tv/cdatafile/c.transformer_top.autotvout_control_reg.dat"
#define AUTOTB_TVIN_irq_status_reg "../tv/cdatafile/c.transformer_top.autotvin_irq_status_reg.dat"
#define AUTOTB_TVOUT_irq_status_reg "../tv/cdatafile/c.transformer_top.autotvout_irq_status_reg.dat"
#define AUTOTB_TVIN_irq_enable_reg "../tv/cdatafile/c.transformer_top.autotvin_irq_enable_reg.dat"
#define AUTOTB_TVOUT_irq_enable_reg "../tv/cdatafile/c.transformer_top.autotvout_irq_enable_reg.dat"
#define AUTOTB_TVIN_wq_base_addr "../tv/cdatafile/c.transformer_top.autotvin_wq_base_addr.dat"
#define AUTOTB_TVOUT_wq_base_addr "../tv/cdatafile/c.transformer_top.autotvout_wq_base_addr.dat"
#define AUTOTB_TVIN_wk_base_addr "../tv/cdatafile/c.transformer_top.autotvin_wk_base_addr.dat"
#define AUTOTB_TVOUT_wk_base_addr "../tv/cdatafile/c.transformer_top.autotvout_wk_base_addr.dat"
#define AUTOTB_TVIN_wv_base_addr "../tv/cdatafile/c.transformer_top.autotvin_wv_base_addr.dat"
#define AUTOTB_TVOUT_wv_base_addr "../tv/cdatafile/c.transformer_top.autotvout_wv_base_addr.dat"
#define AUTOTB_TVIN_wo_base_addr "../tv/cdatafile/c.transformer_top.autotvin_wo_base_addr.dat"
#define AUTOTB_TVOUT_wo_base_addr "../tv/cdatafile/c.transformer_top.autotvout_wo_base_addr.dat"
#define AUTOTB_TVIN_w1_base_addr "../tv/cdatafile/c.transformer_top.autotvin_w1_base_addr.dat"
#define AUTOTB_TVOUT_w1_base_addr "../tv/cdatafile/c.transformer_top.autotvout_w1_base_addr.dat"
#define AUTOTB_TVIN_w2_base_addr "../tv/cdatafile/c.transformer_top.autotvin_w2_base_addr.dat"
#define AUTOTB_TVOUT_w2_base_addr "../tv/cdatafile/c.transformer_top.autotvout_w2_base_addr.dat"
#define AUTOTB_TVIN_wq_head_stride "../tv/cdatafile/c.transformer_top.autotvin_wq_head_stride.dat"
#define AUTOTB_TVOUT_wq_head_stride "../tv/cdatafile/c.transformer_top.autotvout_wq_head_stride.dat"
#define AUTOTB_TVIN_wk_head_stride "../tv/cdatafile/c.transformer_top.autotvin_wk_head_stride.dat"
#define AUTOTB_TVOUT_wk_head_stride "../tv/cdatafile/c.transformer_top.autotvout_wk_head_stride.dat"
#define AUTOTB_TVIN_wv_head_stride "../tv/cdatafile/c.transformer_top.autotvin_wv_head_stride.dat"
#define AUTOTB_TVOUT_wv_head_stride "../tv/cdatafile/c.transformer_top.autotvout_wv_head_stride.dat"
#define AUTOTB_TVIN_wo_tile_stride "../tv/cdatafile/c.transformer_top.autotvin_wo_tile_stride.dat"
#define AUTOTB_TVOUT_wo_tile_stride "../tv/cdatafile/c.transformer_top.autotvout_wo_tile_stride.dat"
#define AUTOTB_TVIN_w1_tile_stride "../tv/cdatafile/c.transformer_top.autotvin_w1_tile_stride.dat"
#define AUTOTB_TVOUT_w1_tile_stride "../tv/cdatafile/c.transformer_top.autotvout_w1_tile_stride.dat"
#define AUTOTB_TVIN_w2_tile_stride "../tv/cdatafile/c.transformer_top.autotvin_w2_tile_stride.dat"
#define AUTOTB_TVOUT_w2_tile_stride "../tv/cdatafile/c.transformer_top.autotvout_w2_tile_stride.dat"
#define AUTOTB_TVIN_dbg_wl_ready "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_ready.dat"
#define AUTOTB_TVOUT_dbg_wl_ready "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_ready.dat"
#define AUTOTB_TVIN_dbg_wl_start "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_start.dat"
#define AUTOTB_TVOUT_dbg_wl_start "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_start.dat"
#define AUTOTB_TVIN_dbg_wl_addr_sel "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_addr_sel.dat"
#define AUTOTB_TVOUT_dbg_wl_addr_sel "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_addr_sel.dat"
#define AUTOTB_TVIN_dbg_wl_layer "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_layer.dat"
#define AUTOTB_TVOUT_dbg_wl_layer "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_layer.dat"
#define AUTOTB_TVIN_dbg_wl_head "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_head.dat"
#define AUTOTB_TVOUT_dbg_wl_head "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_head.dat"
#define AUTOTB_TVIN_dbg_wl_tile "../tv/cdatafile/c.transformer_top.autotvin_dbg_wl_tile.dat"
#define AUTOTB_TVOUT_dbg_wl_tile "../tv/cdatafile/c.transformer_top.autotvout_dbg_wl_tile.dat"
#define AUTOTB_TVIN_dbg_done "../tv/cdatafile/c.transformer_top.autotvin_dbg_done.dat"
#define AUTOTB_TVOUT_dbg_done "../tv/cdatafile/c.transformer_top.autotvout_dbg_done.dat"
#define AUTOTB_TVIN_dbg_error "../tv/cdatafile/c.transformer_top.autotvin_dbg_error.dat"
#define AUTOTB_TVOUT_dbg_error "../tv/cdatafile/c.transformer_top.autotvout_dbg_error.dat"


// tvout file define:
#define AUTOTB_TVOUT_PC_axis_in_ready "../tv/rtldatafile/rtl.transformer_top.autotvout_axis_in_ready.dat"
#define AUTOTB_TVOUT_PC_dma_address "../tv/rtldatafile/rtl.transformer_top.autotvout_dma_address.dat"
#define AUTOTB_TVOUT_PC_memory_request "../tv/rtldatafile/rtl.transformer_top.autotvout_memory_request.dat"
#define AUTOTB_TVOUT_PC_compute_start "../tv/rtldatafile/rtl.transformer_top.autotvout_compute_start.dat"
#define AUTOTB_TVOUT_PC_compute_op "../tv/rtldatafile/rtl.transformer_top.autotvout_compute_op.dat"
#define AUTOTB_TVOUT_PC_head_ctx_ref_0 "../tv/rtldatafile/rtl.transformer_top.autotvout_head_ctx_ref_0.dat"
#define AUTOTB_TVOUT_PC_head_ctx_ref_1 "../tv/rtldatafile/rtl.transformer_top.autotvout_head_ctx_ref_1.dat"
#define AUTOTB_TVOUT_PC_head_ctx_ref_2 "../tv/rtldatafile/rtl.transformer_top.autotvout_head_ctx_ref_2.dat"
#define AUTOTB_TVOUT_PC_head_ctx_ref_3 "../tv/rtldatafile/rtl.transformer_top.autotvout_head_ctx_ref_3.dat"
#define AUTOTB_TVOUT_PC_stream_start "../tv/rtldatafile/rtl.transformer_top.autotvout_stream_start.dat"
#define AUTOTB_TVOUT_PC_ctrl_data_out "../tv/rtldatafile/rtl.transformer_top.autotvout_ctrl_data_out.dat"
#define AUTOTB_TVOUT_PC_irq_ps "../tv/rtldatafile/rtl.transformer_top.autotvout_irq_ps.dat"
#define AUTOTB_TVOUT_PC_dbg_state "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_state.dat"
#define AUTOTB_TVOUT_PC_control_reg "../tv/rtldatafile/rtl.transformer_top.autotvout_control_reg.dat"
#define AUTOTB_TVOUT_PC_irq_status_reg "../tv/rtldatafile/rtl.transformer_top.autotvout_irq_status_reg.dat"
#define AUTOTB_TVOUT_PC_irq_enable_reg "../tv/rtldatafile/rtl.transformer_top.autotvout_irq_enable_reg.dat"
#define AUTOTB_TVOUT_PC_wq_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_wq_base_addr.dat"
#define AUTOTB_TVOUT_PC_wk_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_wk_base_addr.dat"
#define AUTOTB_TVOUT_PC_wv_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_wv_base_addr.dat"
#define AUTOTB_TVOUT_PC_wo_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_wo_base_addr.dat"
#define AUTOTB_TVOUT_PC_w1_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_w1_base_addr.dat"
#define AUTOTB_TVOUT_PC_w2_base_addr "../tv/rtldatafile/rtl.transformer_top.autotvout_w2_base_addr.dat"
#define AUTOTB_TVOUT_PC_wq_head_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_wq_head_stride.dat"
#define AUTOTB_TVOUT_PC_wk_head_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_wk_head_stride.dat"
#define AUTOTB_TVOUT_PC_wv_head_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_wv_head_stride.dat"
#define AUTOTB_TVOUT_PC_wo_tile_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_wo_tile_stride.dat"
#define AUTOTB_TVOUT_PC_w1_tile_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_w1_tile_stride.dat"
#define AUTOTB_TVOUT_PC_w2_tile_stride "../tv/rtldatafile/rtl.transformer_top.autotvout_w2_tile_stride.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_ready "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_ready.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_start "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_start.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_addr_sel "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_addr_sel.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_layer "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_layer.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_head "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_head.dat"
#define AUTOTB_TVOUT_PC_dbg_wl_tile "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_wl_tile.dat"
#define AUTOTB_TVOUT_PC_dbg_done "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_done.dat"
#define AUTOTB_TVOUT_PC_dbg_error "../tv/rtldatafile/rtl.transformer_top.autotvout_dbg_error.dat"


namespace hls::sim
{
  template<size_t n>
  struct Byte {
    unsigned char a[n];

    Byte()
    {
      for (size_t i = 0; i < n; ++i) {
        a[i] = 0;
      }
    }

    template<typename T>
    Byte<n>& operator= (const T &val)
    {
      std::memcpy(a, &val, n);
      return *this;
    }
  };

  struct SimException : public std::exception {
    const std::string msg;
    const size_t line;
    SimException(const std::string &msg, const size_t line)
      : msg(msg), line(line)
    {
    }
  };

  void errExit(const size_t line, const std::string &msg)
  {
    std::string s;
    s += "ERROR";
//  s += '(';
//  s += __FILE__;
//  s += ":";
//  s += std::to_string(line);
//  s += ')';
    s += ": ";
    s += msg;
    s += "\n";
    fputs(s.c_str(), stderr);
    exit(1);
  }
}

namespace hls::sim
{
  size_t divide_ceil(size_t a, size_t b)
  {
    return (a + b - 1) / b;
  }

  const bool little_endian()
  {
    int a = 1;
    return *(char*)&a == 1;
  }

  inline void rev_endian(unsigned char *p, size_t nbytes)
  {
    std::reverse(p, p+nbytes);
  }

  const bool LE = little_endian();

  inline size_t least_nbyte(size_t width)
  {
    return (width+7)>>3;
  }

  std::string formatData(unsigned char *pos, size_t wbits)
  {
    size_t wbytes = least_nbyte(wbits);
    size_t i = LE ? wbytes-1 : 0;
    auto next = [&] () {
      auto c = pos[i];
      LE ? --i : ++i;
      return c;
    };
    std::ostringstream ss;
    ss << "0x";
    if (int t = (wbits & 0x7)) {
      if (t <= 4) {
        unsigned char mask = (1<<t)-1;
        ss << std::hex << std::setfill('0') << std::setw(1)
           << (int) (next() & mask);
        wbytes -= 1;
      }
    }
    for (size_t i = 0; i < wbytes; ++i) {
      ss << std::hex << std::setfill('0') << std::setw(2) << (int)next();
    }
    return ss.str();
  }

  char ord(char c)
  {
    if (c >= 'a' && c <= 'f') {
      return c-'a'+10;
    } else if (c >= 'A' && c <= 'F') {
      return c-'A'+10;
    } else if (c >= '0' && c <= '9') {
      return c-'0';
    } else {
      throw SimException("Not Hexdecimal Digit", __LINE__);
    }
  }

  void unformatData(const char *data, unsigned char *put, size_t pbytes = 0)
  {
    size_t nchars = strlen(data+2);
    size_t nbytes = (nchars+1)>>1;
    if (pbytes == 0) {
      pbytes = nbytes;
    } else if (pbytes > nbytes) {
      throw SimException("Wrong size specified", __LINE__);
    }
    put = LE ? put : put+pbytes-1;
    auto nextp = [&] () {
      return LE ? put++ : put--;
    };
    const char *c = data + (nchars + 2) - 1;
    auto next = [&] () {
      char res { *c == 'x' ? (char)0 : ord(*c) };
      --c;
      return res;
    };
    for (size_t i = 0; i < pbytes; ++i) {
      char l = next();
      char h = next();
      *nextp() = (h<<4)+l;
    }
  }

  char* strip(char *s)
  {
    while (isspace(*s)) {
      ++s;
    }
    for (char *p = s+strlen(s)-1; p >= s; --p) {
      if (isspace(*p)) {
        *p = 0;
      } else {
        return s;
      }
    }
    return s;
  }

  size_t sum(const std::vector<size_t> &v)
  {
    size_t res = 0;
    for (const auto &e : v) {
      res += e;
    }
    return res;
  }

  const char* bad = "Bad TV file";
  const char* err = "Error on TV file";

  const unsigned char bmark[] = {
    0x5a, 0x5a, 0xa5, 0xa5, 0x0f, 0x0f, 0xf0, 0xf0
  };

  class Input {
    FILE *fp;
    long pos;

    void read(unsigned char *buf, size_t size)
    {
      if (fread(buf, size, 1, fp) != 1) {
        throw SimException(bad, __LINE__);
      }
      if (LE) {
        rev_endian(buf, size);
      }
    }

  public:
    void advance(size_t nbytes)
    {
      if (fseek(fp, nbytes, SEEK_CUR) == -1) {
        throw SimException(bad, __LINE__);
      }
    }

    Input(const char *path) : fp(nullptr)
    {
      fp = fopen(path, "rb");
      if (fp == nullptr) {
        errExit(__LINE__, err);
      }
    }

    void begin()
    {
      advance(8);
      pos = ftell(fp);
    }

    void reset()
    {
      fseek(fp, pos, SEEK_SET);
    }

    void into(unsigned char *param, size_t wbytes, size_t asize, size_t nbytes)
    {
      size_t n = nbytes / asize;
      size_t r = nbytes % asize;
      for (size_t i = 0; i < n; ++i) {
        read(param, wbytes);
        param += asize;
      }
      if (r > 0) {
        advance(asize-r);
        read(param, r);
      }
    }

    ~Input()
    {
      long curPos = ftell(fp);
      unsigned char buf[8];
      size_t res = fread(buf, 8, 1, fp);
      fclose(fp);
      if (res != 1) {
        errExit(__LINE__, bad);
      }
      // curPos == 0 -> the file is only opened but not read
      if (curPos != 0 && std::memcmp(buf, bmark, 8) != 0) {
        errExit(__LINE__, bad);
      }
    }
  };

  class Output {
    FILE *fp;

    void write(unsigned char *buf, size_t size)
    {
      if (LE) {
        rev_endian(buf, size);
      }
      if (fwrite(buf, size, 1, fp) != 1) {
        throw SimException(err, __LINE__);
      }
      if (LE) {
        rev_endian(buf, size);
      }
    }

  public:
    Output(const char *path) : fp(nullptr)
    {
      fp = fopen(path, "wb");
      if (fp == nullptr) {
        errExit(__LINE__, err);
      }
    }

    void begin(size_t total)
    {
      unsigned char buf[8] = {0};
      std::memcpy(buf, &total, sizeof(buf));
      write(buf, sizeof(buf));
    }

    void from(unsigned char *param, size_t wbytes, size_t asize, size_t nbytes, size_t skip)
    {
      param -= asize*skip;
      size_t n = divide_ceil(nbytes, asize);
      for (size_t i = 0; i < n; ++i) {
        write(param, wbytes);
        param += asize;
      }
    }

    ~Output()
    {
      size_t res = fwrite(bmark, 8, 1, fp);
      fclose(fp);
      if (res != 1) {
        errExit(__LINE__, err);
      }
    }
  };

  class Reader {
    FILE *fp;
    long pos;
    int size;
    char *s;

    void readline()
    {
      s = fgets(s, size, fp);
      if (s == nullptr) {
        throw SimException(bad, __LINE__);
      }
    }

  public:
    Reader(const char *path) : fp(nullptr), size(1<<12), s(new char[size])
    {
      try {
        fp = fopen(path, "r");
        if (fp == nullptr) {
          throw SimException(err, __LINE__);
        } else {
          readline();
          static const char mark[] = "[[[runtime]]]\n";
          if (strcmp(s, mark) != 0) {
            throw SimException(bad, __LINE__);
          }
        }
      } catch (const hls::sim::SimException &e) {
        errExit(e.line, e.msg);
      }
    }

    ~Reader()
    {
      fclose(fp);
      delete[] s;
    }

    void begin()
    {
      readline();
      static const char mark[] = "[[transaction]]";
      if (strncmp(s, mark, strlen(mark)) != 0) {
        throw SimException(bad, __LINE__);
      }
      pos = ftell(fp);
    }

    void reset()
    {
      fseek(fp, pos, SEEK_SET);
    }

    void skip(size_t n)
    {
      for (size_t i = 0; i < n; ++i) {
        readline();
      }
    }

    char* next()
    {
      long pos = ftell(fp);
      readline();
      if (*s == '[') {
        fseek(fp, pos, SEEK_SET);
        return nullptr;
      }
      return strip(s);
    }

    void end()
    {
      do {
        readline();
      } while (strcmp(s, "[[/transaction]]\n") != 0);
    }
  };

  class Writer {
    FILE *fp;

    void write(const char *s)
    {
      if (fputs(s, fp) == EOF) {
        throw SimException(err, __LINE__);
      }
    }

  public:
    Writer(const char *path) : fp(nullptr)
    {
      try {
        fp = fopen(path, "w");
        if (fp == nullptr) {
          throw SimException(err, __LINE__);
        } else {
          static const char mark[] = "[[[runtime]]]\n";
          write(mark);
        }
      } catch (const hls::sim::SimException &e) {
        errExit(e.line, e.msg);
      }
    }

    virtual ~Writer()
    {
      try {
        static const char mark[] = "[[[/runtime]]]\n";
        write(mark);
      } catch (const hls::sim::SimException &e) {
        errExit(e.line, e.msg);
      }
      fclose(fp);
    }

    void begin(size_t AESL_transaction)
    {
      static const char mark[] = "[[transaction]]           ";
      write(mark);
      auto buf = std::to_string(AESL_transaction);
      buf.push_back('\n');
      buf.push_back('\0');
      write(buf.data());
    }

    void next(const char *s)
    {
      write(s);
      write("\n");
    }

    void end()
    {
      static const char mark[] = "[[/transaction]]\n";
      write(mark);
    }
  };

  bool RTLOutputCheckAndReplacement(char *data)
  {
    bool changed = false;
    for (size_t i = 2; i < strlen(data); ++i) {
      if (data[i] == 'X' || data[i] == 'x') {
        data[i] = '0';
        changed = true;
      }
    }
    return changed;
  }

  void warnOnX()
  {
    static const char msg[] =
      "WARNING: [SIM 212-201] RTL produces unknown value "
      "'x' or 'X' on some port, possible cause: "
      "There are uninitialized variables in the design.\n";
    fprintf(stderr, msg);
  }

#ifndef POST_CHECK
  class RefTCL {
    FILE *fp;
    std::ostringstream ss;

    void fmt(std::vector<size_t> &vec)
    {
      ss << "{";
      for (auto &x : vec) {
        ss << " " << x;
      }
      ss << " }";
    }

    void formatDepth()
    {
      ss << "set depth_list {\n";
      for (auto &p : depth) {
        ss << "  {" << p.first << " " << p.second << "}\n";
      }
      if (nameHBM != "") {
        ss << "  {" << nameHBM << " " << depthHBM << "}\n";
      }
      ss << "}\n";
    }

    void formatTransDepth()
    {
      ss << "set trans_depth {\n";
      for (auto &p : transDepth) {
        ss << "  {" << p.first << " ";
        fmt(p.second);
        ss << " " << bundleNameFor[p.first] << "}\n";
      }
      ss << "}\n";
    }

    void formatTransNum()
    {
      ss << "set trans_num " << AESL_transaction << "\n";
    }

    void formatContainsVLA()
    {
      ss << "set containsVLA " << containsVLA << "\n";
    }

    void formatHBM()
    {
      ss << "set HBM_ArgDict {\n"
         << "  Name " << nameHBM << "\n"
         << "  Port " << portHBM << "\n"
         << "  BitWidth " << widthHBM << "\n"
         << "}\n";
    }

    void close()
    {
      formatDepth();
      formatTransDepth();
      formatContainsVLA();
      formatTransNum();
      if (nameHBM != "") {
        formatHBM();
      }
      std::string &&s { ss.str() };
      size_t res = fwrite(s.data(), s.size(), 1, fp);
      fclose(fp);
      if (res != 1) {
        errExit(__LINE__, err);
      }
    }

  public:
    std::map<const std::string, size_t> depth;
    typedef const std::string PortName;
    typedef const char *BundleName;
    std::map<PortName, std::vector<size_t>> transDepth;
    std::map<PortName, BundleName> bundleNameFor;
    std::string nameHBM;
    size_t depthHBM;
    std::string portHBM;
    unsigned widthHBM;
    size_t AESL_transaction;
    bool containsVLA;
    std::mutex mut;

    RefTCL(const char *path)
    {
      fp = fopen(path, "w");
      if (fp == nullptr) {
        errExit(__LINE__, err);
      }
    }

    void set(const char* name, size_t dep)
    {
      std::lock_guard<std::mutex> guard(mut);
      if (depth[name] < dep) {
        depth[name] = dep;
      }
    }

    void append(const char* portName, size_t dep, const char* bundleName)
    {
      std::lock_guard<std::mutex> guard(mut);
      transDepth[portName].push_back(dep);
      bundleNameFor[portName] = bundleName;
    }

    ~RefTCL()
    {
      close();
    }
  };

#endif

  struct Register {
    const char* name;
    unsigned width;
#ifdef POST_CHECK
    Reader* reader;
#else
    Writer* owriter;
    Writer* iwriter;
#endif
    void* param;
    std::vector<std::function<void()>> delayed;

#ifndef POST_CHECK
    void doTCL(RefTCL &tcl)
    {
      if (strcmp(name, "return") == 0) {
        tcl.set("ap_return", 1);
      } else {
        tcl.set(name, 1);
      }
    }
#endif
    ~Register()
    {
      for (auto &f : delayed) {
        f();
      }
      delayed.clear();
#ifdef POST_CHECK
      delete reader;
#else
      delete owriter;
      delete iwriter;
#endif
    }
  };

  template<typename E>
  struct DirectIO {
    unsigned width;
    const char* name;
#ifdef POST_CHECK
    Reader* reader;
#else
    Writer* writer;
    Writer* swriter;
    Writer* gwriter;
#endif
    hls::directio<E>* param;
    std::vector<E> buf;
    size_t initSize;
    size_t depth;
    bool hasWrite;

    void markSize()
    {
      initSize = param->size();
    }

    void buffer()
    {
      buf.clear();
      while (param->valid()) {
        buf.push_back(param->read());
      }
      for (auto &e : buf) {
        param->write(e);
      }
    }

#ifndef POST_CHECK
    void doTCL(RefTCL &tcl)
    {
      tcl.set(name, depth);
    }
#endif

    ~DirectIO()
    {
#ifdef POST_CHECK
      delete reader;
#else
      delete writer;
      delete swriter;
      delete gwriter;
#endif
    }
  };

  template<typename Reader, typename Writer>
  struct Memory {
    unsigned width;
    unsigned asize;
    bool hbm;
    std::vector<const char*> name;
#ifdef POST_CHECK
    Reader* reader;
#else
    Writer* owriter;
    Writer* iwriter;
#endif
    std::vector<void*> param;
    std::vector<const char*> mname;
    std::vector<size_t> offset;
    std::vector<bool> hasWrite;
    std::vector<size_t> nbytes;
    std::vector<size_t> max_nbytes;

    size_t depth()
    {
      if (hbm) {
        return divide_ceil(nbytes[0], asize);
      }
      else {
        size_t depth = 0;
        for (size_t n : nbytes) {
          depth += divide_ceil(n, asize);
        }
        return depth;
      }
    }

#ifndef POST_CHECK
    void doTCL(RefTCL &tcl)
    {
      if (hbm) {
        tcl.nameHBM.clear();
        tcl.portHBM.clear();
        tcl.nameHBM.append(name[0]);
        tcl.portHBM.append("{").append(name[0]);
        for (size_t i = 1; i < name.size(); ++i) {
          tcl.nameHBM.append("_").append(name[i]);
          tcl.portHBM.append(" ").append(name[i]);
        }
        tcl.nameHBM.append("_HBM");
        tcl.portHBM.append("}");
        tcl.widthHBM = width;
        size_t depthHBM = divide_ceil(nbytes[0], asize);
        tcl.append(tcl.nameHBM.c_str(), depthHBM, tcl.nameHBM.c_str());
        if (depthHBM > tcl.depthHBM) {
          tcl.depthHBM = depthHBM;
        }
      } else {
        tcl.set(name[0], depth());
        for (size_t i = 0; i < mname.size(); ++i) {
          tcl.append(mname[i], divide_ceil(nbytes[i], asize), name[0]);
        }
      }
    }
#endif

    ~Memory()
    {
#ifdef POST_CHECK
      delete reader;
#else
      delete owriter;
      delete iwriter;
#endif
    }
  };

  struct A2Stream {
    unsigned width;
    unsigned asize;
    const char* name;
#ifdef POST_CHECK
    Reader* reader;
#else
    Writer* owriter;
    Writer* iwriter;
#endif
    void* param;
    size_t nbytes;
    bool hasWrite;

#ifndef POST_CHECK
    void doTCL(RefTCL &tcl)
    {
      tcl.set(name, divide_ceil(nbytes, asize));
    }
#endif

    ~A2Stream()
    {
#ifdef POST_CHECK
      delete reader;
#else
      delete owriter;
      delete iwriter;
#endif
    }
  };

  template<typename E>
  struct Stream {
    unsigned width;
    const char* name;
#ifdef POST_CHECK
    Reader* reader;
#else
    Writer* writer;
    Writer* swriter;
    Writer* gwriter;
#endif
    hls::stream<E>* param;
    std::vector<E> buf;
    size_t initSize;
    size_t depth;
    bool hasWrite;

    void markSize()
    {
      initSize = param->size();
    }

    void buffer()
    {
      buf.clear();
      while (!param->empty()) {
        buf.push_back(param->read());
      }
      for (auto &e : buf) {
        param->write(e);
      }
    }

#ifndef POST_CHECK
    void doTCL(RefTCL &tcl)
    {
      tcl.set(name, depth);
    }
#endif

    ~Stream()
    {
#ifdef POST_CHECK
      delete reader;
#else
      delete writer;
      delete swriter;
      delete gwriter;
#endif
    }
  };

#ifdef POST_CHECK
  void check(Register &port)
  {
    port.reader->begin();
    bool foundX = false;
    if (char *s = port.reader->next()) {
      foundX |= RTLOutputCheckAndReplacement(s);
      unformatData(s, (unsigned char*)port.param);
    }
    port.reader->end();
    if (foundX) {
      warnOnX();
    }
  }

  template<typename E>
  void check(DirectIO<E> &port)
  {
    if (port.hasWrite) {
      port.reader->begin();
      bool foundX = false;
      E *p = new E;
      while (char *s = port.reader->next()) {
        foundX |= RTLOutputCheckAndReplacement(s);
        unformatData(s, (unsigned char*)p);
        port.param->write(*p);
      }
      delete p;
      port.reader->end();
      if (foundX) {
        warnOnX();
      }
    } else {
      port.reader->begin();
      size_t n = 0;
      if (char *s = port.reader->next()) {
        std::istringstream ss(s);
        ss >> n;
      } else {
        throw SimException(bad, __LINE__);
      }
      port.reader->end();
      for (size_t j = 0; j < n; ++j) {
        port.param->read();
      }
    }
  }

  void checkHBM(Memory<Input, Output> &port)
  {
    port.reader->begin();
    size_t wbytes = least_nbyte(port.width);
    for (size_t i = 0; i < port.param.size(); ++i) {
      if (port.hasWrite[i]) {
        port.reader->reset();
        size_t skip = wbytes * port.offset[i];
        port.reader->advance(skip);
        port.reader->into((unsigned char*)port.param[i], wbytes,
                           port.asize, port.nbytes[i] - skip);
      }
    }
  }

  void check(Memory<Input, Output> &port)
  {
    if (port.hbm) {
      return checkHBM(port);
    } else {
      port.reader->begin();
      size_t wbytes = least_nbyte(port.width);
      for (size_t i = 0; i < port.param.size(); ++i) {
        if (port.hasWrite[i]) {
          port.reader->into((unsigned char*)port.param[i], wbytes,
                             port.asize, port.nbytes[i]);
        } else {
          size_t n = divide_ceil(port.nbytes[i], port.asize);
          port.reader->advance(port.asize*n);
        }
      }
    }
  }

  void transfer(Reader *reader, size_t nbytes, unsigned char *put, bool &foundX)
  {
    if (char *s = reader->next()) {
      foundX |= RTLOutputCheckAndReplacement(s);
      unformatData(s, put, nbytes);
    } else {
      throw SimException("No more data", __LINE__);
    }
  }

  void checkHBM(Memory<Reader, Writer> &port)
  {
    port.reader->begin();
    bool foundX = false;
    size_t wbytes = least_nbyte(port.width);
    for (size_t i = 0, last = port.param.size()-1; i <= last; ++i) {
      if (port.hasWrite[i]) {
        port.reader->skip(port.offset[i]);
        size_t n = port.nbytes[i] / port.asize - port.offset[i];
        unsigned char *put = (unsigned char*)port.param[i];
        for (size_t j = 0; j < n; ++j) {
          transfer(port.reader, wbytes, put, foundX);
          put += port.asize;
        }
        if (i < last) {
          port.reader->reset();
        }
      }
    }
    port.reader->end();
    if (foundX) {
      warnOnX();
    }
  }

  void check(Memory<Reader, Writer> &port)
  {
    if (port.hbm) {
      return checkHBM(port);
    } else {
      port.reader->begin();
      bool foundX = false;
      size_t wbytes = least_nbyte(port.width);
      for (size_t i = 0; i < port.param.size(); ++i) {
        if (port.hasWrite[i]) {
          size_t n = port.nbytes[i] / port.asize;
          size_t r = port.nbytes[i] % port.asize;
          unsigned char *put = (unsigned char*)port.param[i];
          for (size_t j = 0; j < n; ++j) {
            transfer(port.reader, wbytes, put, foundX);
            put += port.asize;
          }
          if (r > 0) {
            transfer(port.reader, r, put, foundX);
          }
        } else {
          size_t n = divide_ceil(port.nbytes[i], port.asize);
          port.reader->skip(n);
        }
      }
      port.reader->end();
      if (foundX) {
        warnOnX();
      }
    }
  }

  void check(A2Stream &port)
  {
    port.reader->begin();
    bool foundX = false;
    if (port.hasWrite) {
      size_t wbytes = least_nbyte(port.width);
      size_t n = port.nbytes / port.asize;
      size_t r = port.nbytes % port.asize;
      unsigned char *put = (unsigned char*)port.param;
      for (size_t j = 0; j < n; ++j) {
        if (char *s = port.reader->next()) {
          foundX |= RTLOutputCheckAndReplacement(s);
          unformatData(s, put, wbytes);
        }
        put += port.asize;
      }
      if (r > 0) {
        if (char *s = port.reader->next()) {
          foundX |= RTLOutputCheckAndReplacement(s);
          unformatData(s, put, r);
        }
      }
    }
    port.reader->end();
    if (foundX) {
      warnOnX();
    }
  }

  template<typename E>
  void check(Stream<E> &port)
  {
    if (port.hasWrite) {
      port.reader->begin();
      bool foundX = false;
      E *p = new E;
      while (char *s = port.reader->next()) {
        foundX |= RTLOutputCheckAndReplacement(s);
        unformatData(s, (unsigned char*)p);
        port.param->write(*p);
      }
      delete p;
      port.reader->end();
      if (foundX) {
        warnOnX();
      }
    } else {
      port.reader->begin();
      size_t n = 0;
      if (char *s = port.reader->next()) {
        std::istringstream ss(s);
        ss >> n;
      } else {
        throw SimException(bad, __LINE__);
      }
      port.reader->end();
      for (size_t j = 0; j < n; ++j) {
        port.param->read();
      }
    }
  }
#else
  void dump(Register &port, Writer *writer, size_t AESL_transaction)
  {
    writer->begin(AESL_transaction);
    std::string &&s { formatData((unsigned char*)port.param, port.width) };
    writer->next(s.data());
    writer->end();
  }

  void delay_dump(Register &port, Writer *writer, size_t AESL_transaction)
  {
    port.delayed.push_back(std::bind(dump, std::ref(port), writer, AESL_transaction));
  }

  template<typename E>
  void dump(DirectIO<E> &port, size_t AESL_transaction)
  {
    if (port.hasWrite) {
      port.writer->begin(AESL_transaction);
      port.depth = port.param->size()-port.initSize;
      for (size_t j = 0; j < port.depth; ++j) {
        std::string &&s {
          formatData((unsigned char*)&port.buf[port.initSize+j], port.width)
        };
        port.writer->next(s.c_str());
      }
      port.writer->end();

      port.swriter->begin(AESL_transaction);
      port.swriter->next(std::to_string(port.depth).c_str());
      port.swriter->end();
    } else {
      port.writer->begin(AESL_transaction);
      port.depth = port.initSize-port.param->size();
      for (size_t j = 0; j < port.depth; ++j) {
        std::string &&s {
          formatData((unsigned char*)&port.buf[j], port.width)
        };
        port.writer->next(s.c_str());
      }
      port.writer->end();

      port.swriter->begin(AESL_transaction);
      port.swriter->next(std::to_string(port.depth).c_str());
      port.swriter->end();

      port.gwriter->begin(AESL_transaction);
      size_t n = (port.depth ? port.initSize : port.depth);
      size_t d = port.depth;
      do {
        port.gwriter->next(std::to_string(n--).c_str());
      } while (d--);
      port.gwriter->end();
    }
  }

  void error_on_depth_unspecified(const char *portName)
  {
    std::string msg {"A depth specification is required for interface port "};
    msg.append("'");
    msg.append(portName);
    msg.append("'");
    msg.append(" for cosimulation.");
    throw SimException(msg, __LINE__);
  }

  void dump(Memory<Input, Output> &port, Output *writer, size_t AESL_transaction)
  {
    for (size_t i = 0; i < port.param.size(); ++i) {
      if (port.nbytes[i] == 0) {
        error_on_depth_unspecified(port.mname[i]);
      }
    }

    writer->begin(port.depth());
    size_t wbytes = least_nbyte(port.width);
    if (port.hbm) {
      writer->from((unsigned char*)port.param[0], wbytes, port.asize,
                   port.nbytes[0], 0);
    }
    else {
      for (size_t i = 0; i < port.param.size(); ++i) {
        writer->from((unsigned char*)port.param[i], wbytes, port.asize,
                     port.nbytes[i], 0);
      }
    }
  }

  void dump(Memory<Reader, Writer> &port, Writer *writer, size_t AESL_transaction)
  {
    for (size_t i = 0; i < port.param.size(); ++i) {
      if (port.nbytes[i] == 0) {
        error_on_depth_unspecified(port.mname[i]);
      }
    }
    writer->begin(AESL_transaction);
    for (size_t i = 0; i < port.param.size(); ++i) {
      size_t n = divide_ceil(port.nbytes[i], port.asize);
      unsigned char *put = (unsigned char*)port.param[i];
      for (size_t j = 0; j < n; ++j) {
        std::string &&s {
          formatData(put, port.width)
        };
        writer->next(s.data());
        put += port.asize;
      }
      if (port.hbm) {
        break;
      }
    }
    writer->end();
  }

  void dump(A2Stream &port, Writer *writer, size_t AESL_transaction)
  {
    if (port.nbytes == 0) {
      error_on_depth_unspecified(port.name);
    }
    writer->begin(AESL_transaction);
    size_t n = divide_ceil(port.nbytes, port.asize);
    unsigned char *put = (unsigned char*)port.param;
    for (size_t j = 0; j < n; ++j) {
      std::string &&s { formatData(put, port.width) };
      writer->next(s.data());
      put += port.asize;
    }
    writer->end();
  }

  template<typename E>
  void dump(Stream<E> &port, size_t AESL_transaction)
  {
    if (port.hasWrite) {
      port.writer->begin(AESL_transaction);
      port.depth = port.param->size()-port.initSize;
      for (size_t j = 0; j < port.depth; ++j) {
        std::string &&s {
          formatData((unsigned char*)&port.buf[port.initSize+j], port.width)
        };
        port.writer->next(s.c_str());
      }
      port.writer->end();

      port.swriter->begin(AESL_transaction);
      port.swriter->next(std::to_string(port.depth).c_str());
      port.swriter->end();
    } else {
      port.writer->begin(AESL_transaction);
      port.depth = port.initSize-port.param->size();
      for (size_t j = 0; j < port.depth; ++j) {
        std::string &&s {
          formatData((unsigned char*)&port.buf[j], port.width)
        };
        port.writer->next(s.c_str());
      }
      port.writer->end();

      port.swriter->begin(AESL_transaction);
      port.swriter->next(std::to_string(port.depth).c_str());
      port.swriter->end();

      port.gwriter->begin(AESL_transaction);
      size_t n = (port.depth ? port.initSize : port.depth);
      size_t d = port.depth;
      do {
        port.gwriter->next(std::to_string(n--).c_str());
      } while (d--);
      port.gwriter->end();
    }
  }
#endif
}



extern "C"
void transformer_top_hw_stub_wrapper(hls::sim::Byte<1>, hls::sim::Byte<1>, void*, hls::sim::Byte<1>, void*, void*, hls::sim::Byte<1>, hls::sim::Byte<1>, void*, void*, void*, void*, void*, void*, hls::sim::Byte<1>, void*, hls::sim::Byte<1>, hls::sim::Byte<4>, hls::sim::Byte<4>, void*, hls::sim::Byte<1>, hls::sim::Byte<1>, hls::sim::Byte<1>, hls::sim::Byte<1>, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*, void*);

extern "C"
void apatb_transformer_top_hw(hls::sim::Byte<1> __xlx_apatb_param_axis_in_valid, hls::sim::Byte<1> __xlx_apatb_param_axis_in_last, void* __xlx_apatb_param_axis_in_ready, hls::sim::Byte<1> __xlx_apatb_param_dma_done, void* __xlx_apatb_param_dma_address, void* __xlx_apatb_param_memory_request, hls::sim::Byte<1> __xlx_apatb_param_compute_ready, hls::sim::Byte<1> __xlx_apatb_param_compute_done, void* __xlx_apatb_param_compute_start, void* __xlx_apatb_param_compute_op, void* __xlx_apatb_param_head_ctx_ref_0, void* __xlx_apatb_param_head_ctx_ref_1, void* __xlx_apatb_param_head_ctx_ref_2, void* __xlx_apatb_param_head_ctx_ref_3, hls::sim::Byte<1> __xlx_apatb_param_stream_ready, void* __xlx_apatb_param_stream_start, hls::sim::Byte<1> __xlx_apatb_param_stream_done, hls::sim::Byte<4> __xlx_apatb_param_ctrl_addr, hls::sim::Byte<4> __xlx_apatb_param_ctrl_data_in, void* __xlx_apatb_param_ctrl_data_out, hls::sim::Byte<1> __xlx_apatb_param_ctrl_read_en, hls::sim::Byte<1> __xlx_apatb_param_ctrl_write_en, hls::sim::Byte<1> __xlx_apatb_param_ctrl_chip_en, hls::sim::Byte<1> __xlx_apatb_param_ctrl_resetn_in, void* __xlx_apatb_param_irq_ps, void* __xlx_apatb_param_dbg_state, void* __xlx_apatb_param_dbg_ctrl_mem, void* __xlx_apatb_param_control_reg, void* __xlx_apatb_param_irq_status_reg, void* __xlx_apatb_param_irq_enable_reg, void* __xlx_apatb_param_wq_base_addr, void* __xlx_apatb_param_wk_base_addr, void* __xlx_apatb_param_wv_base_addr, void* __xlx_apatb_param_wo_base_addr, void* __xlx_apatb_param_w1_base_addr, void* __xlx_apatb_param_w2_base_addr, void* __xlx_apatb_param_wq_head_stride, void* __xlx_apatb_param_wk_head_stride, void* __xlx_apatb_param_wv_head_stride, void* __xlx_apatb_param_wo_tile_stride, void* __xlx_apatb_param_w1_tile_stride, void* __xlx_apatb_param_w2_tile_stride, void* __xlx_apatb_param_dbg_wl_ready, void* __xlx_apatb_param_dbg_wl_start, void* __xlx_apatb_param_dbg_wl_addr_sel, void* __xlx_apatb_param_dbg_wl_layer, void* __xlx_apatb_param_dbg_wl_head, void* __xlx_apatb_param_dbg_wl_tile, void* __xlx_apatb_param_dbg_done, void* __xlx_apatb_param_dbg_error)
{
  static hls::sim::Register port0 {
    .name = "axis_in_valid",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_axis_in_valid),
#endif
  };
  port0.param = &__xlx_apatb_param_axis_in_valid;

  static hls::sim::Register port1 {
    .name = "axis_in_last",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_axis_in_last),
#endif
  };
  port1.param = &__xlx_apatb_param_axis_in_last;

  static hls::sim::Register port2 {
    .name = "axis_in_ready",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_axis_in_ready),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_axis_in_ready),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_axis_in_ready),
#endif
  };
  port2.param = __xlx_apatb_param_axis_in_ready;

  static hls::sim::Register port3 {
    .name = "dma_done",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dma_done),
#endif
  };
  port3.param = &__xlx_apatb_param_dma_done;

  static hls::sim::Register port4 {
    .name = "dma_address",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dma_address),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dma_address),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dma_address),
#endif
  };
  port4.param = __xlx_apatb_param_dma_address;

  static hls::sim::Register port5 {
    .name = "memory_request",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_memory_request),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_memory_request),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_memory_request),
#endif
  };
  port5.param = __xlx_apatb_param_memory_request;

  static hls::sim::Register port6 {
    .name = "compute_ready",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_compute_ready),
#endif
  };
  port6.param = &__xlx_apatb_param_compute_ready;

  static hls::sim::Register port7 {
    .name = "compute_done",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_compute_done),
#endif
  };
  port7.param = &__xlx_apatb_param_compute_done;

  static hls::sim::Register port8 {
    .name = "compute_start",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_compute_start),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_compute_start),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_compute_start),
#endif
  };
  port8.param = __xlx_apatb_param_compute_start;

  static hls::sim::Register port9 {
    .name = "compute_op",
    .width = 8,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_compute_op),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_compute_op),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_compute_op),
#endif
  };
  port9.param = __xlx_apatb_param_compute_op;

  static hls::sim::Register port10 {
    .name = "head_ctx_ref_0",
    .width = 235,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_head_ctx_ref_0),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_head_ctx_ref_0),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_head_ctx_ref_0),
#endif
  };
  port10.param = __xlx_apatb_param_head_ctx_ref_0;

  static hls::sim::Register port11 {
    .name = "head_ctx_ref_1",
    .width = 235,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_head_ctx_ref_1),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_head_ctx_ref_1),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_head_ctx_ref_1),
#endif
  };
  port11.param = __xlx_apatb_param_head_ctx_ref_1;

  static hls::sim::Register port12 {
    .name = "head_ctx_ref_2",
    .width = 235,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_head_ctx_ref_2),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_head_ctx_ref_2),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_head_ctx_ref_2),
#endif
  };
  port12.param = __xlx_apatb_param_head_ctx_ref_2;

  static hls::sim::Register port13 {
    .name = "head_ctx_ref_3",
    .width = 235,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_head_ctx_ref_3),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_head_ctx_ref_3),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_head_ctx_ref_3),
#endif
  };
  port13.param = __xlx_apatb_param_head_ctx_ref_3;

  static hls::sim::Register port14 {
    .name = "stream_ready",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_stream_ready),
#endif
  };
  port14.param = &__xlx_apatb_param_stream_ready;

  static hls::sim::Register port15 {
    .name = "stream_start",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_stream_start),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_stream_start),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_stream_start),
#endif
  };
  port15.param = __xlx_apatb_param_stream_start;

  static hls::sim::Register port16 {
    .name = "stream_done",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_stream_done),
#endif
  };
  port16.param = &__xlx_apatb_param_stream_done;

  static hls::sim::Register port17 {
    .name = "ctrl_addr",
    .width = 32,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_addr),
#endif
  };
  port17.param = &__xlx_apatb_param_ctrl_addr;

  static hls::sim::Register port18 {
    .name = "ctrl_data_in",
    .width = 32,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_data_in),
#endif
  };
  port18.param = &__xlx_apatb_param_ctrl_data_in;

  static hls::sim::Register port19 {
    .name = "ctrl_data_out",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_ctrl_data_out),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_ctrl_data_out),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_data_out),
#endif
  };
  port19.param = __xlx_apatb_param_ctrl_data_out;

  static hls::sim::Register port20 {
    .name = "ctrl_read_en",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_read_en),
#endif
  };
  port20.param = &__xlx_apatb_param_ctrl_read_en;

  static hls::sim::Register port21 {
    .name = "ctrl_write_en",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_write_en),
#endif
  };
  port21.param = &__xlx_apatb_param_ctrl_write_en;

  static hls::sim::Register port22 {
    .name = "ctrl_chip_en",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_chip_en),
#endif
  };
  port22.param = &__xlx_apatb_param_ctrl_chip_en;

  static hls::sim::Register port23 {
    .name = "ctrl_resetn_in",
    .width = 1,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_ctrl_resetn_in),
#endif
  };
  port23.param = &__xlx_apatb_param_ctrl_resetn_in;

  static hls::sim::Register port24 {
    .name = "irq_ps",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_irq_ps),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_irq_ps),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_irq_ps),
#endif
  };
  port24.param = __xlx_apatb_param_irq_ps;

  static hls::sim::Register port25 {
    .name = "dbg_state",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_state),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_state),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_state),
#endif
  };
  port25.param = __xlx_apatb_param_dbg_state;

  static hls::sim::Register port26 {
    .name = "dbg_ctrl_mem",
    .width = 1056,
#ifdef POST_CHECK
#else
    .owriter = nullptr,
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_ctrl_mem),
#endif
  };
  port26.param = __xlx_apatb_param_dbg_ctrl_mem;

  static hls::sim::Register port27 {
    .name = "control_reg",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_control_reg),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_control_reg),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_control_reg),
#endif
  };
  port27.param = __xlx_apatb_param_control_reg;

  static hls::sim::Register port28 {
    .name = "irq_status_reg",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_irq_status_reg),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_irq_status_reg),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_irq_status_reg),
#endif
  };
  port28.param = __xlx_apatb_param_irq_status_reg;

  static hls::sim::Register port29 {
    .name = "irq_enable_reg",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_irq_enable_reg),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_irq_enable_reg),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_irq_enable_reg),
#endif
  };
  port29.param = __xlx_apatb_param_irq_enable_reg;

  static hls::sim::Register port30 {
    .name = "wq_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wq_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wq_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wq_base_addr),
#endif
  };
  port30.param = __xlx_apatb_param_wq_base_addr;

  static hls::sim::Register port31 {
    .name = "wk_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wk_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wk_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wk_base_addr),
#endif
  };
  port31.param = __xlx_apatb_param_wk_base_addr;

  static hls::sim::Register port32 {
    .name = "wv_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wv_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wv_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wv_base_addr),
#endif
  };
  port32.param = __xlx_apatb_param_wv_base_addr;

  static hls::sim::Register port33 {
    .name = "wo_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wo_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wo_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wo_base_addr),
#endif
  };
  port33.param = __xlx_apatb_param_wo_base_addr;

  static hls::sim::Register port34 {
    .name = "w1_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_w1_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_w1_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_w1_base_addr),
#endif
  };
  port34.param = __xlx_apatb_param_w1_base_addr;

  static hls::sim::Register port35 {
    .name = "w2_base_addr",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_w2_base_addr),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_w2_base_addr),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_w2_base_addr),
#endif
  };
  port35.param = __xlx_apatb_param_w2_base_addr;

  static hls::sim::Register port36 {
    .name = "wq_head_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wq_head_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wq_head_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wq_head_stride),
#endif
  };
  port36.param = __xlx_apatb_param_wq_head_stride;

  static hls::sim::Register port37 {
    .name = "wk_head_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wk_head_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wk_head_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wk_head_stride),
#endif
  };
  port37.param = __xlx_apatb_param_wk_head_stride;

  static hls::sim::Register port38 {
    .name = "wv_head_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wv_head_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wv_head_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wv_head_stride),
#endif
  };
  port38.param = __xlx_apatb_param_wv_head_stride;

  static hls::sim::Register port39 {
    .name = "wo_tile_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_wo_tile_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_wo_tile_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_wo_tile_stride),
#endif
  };
  port39.param = __xlx_apatb_param_wo_tile_stride;

  static hls::sim::Register port40 {
    .name = "w1_tile_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_w1_tile_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_w1_tile_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_w1_tile_stride),
#endif
  };
  port40.param = __xlx_apatb_param_w1_tile_stride;

  static hls::sim::Register port41 {
    .name = "w2_tile_stride",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_w2_tile_stride),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_w2_tile_stride),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_w2_tile_stride),
#endif
  };
  port41.param = __xlx_apatb_param_w2_tile_stride;

  static hls::sim::Register port42 {
    .name = "dbg_wl_ready",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_ready),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_ready),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_ready),
#endif
  };
  port42.param = __xlx_apatb_param_dbg_wl_ready;

  static hls::sim::Register port43 {
    .name = "dbg_wl_start",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_start),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_start),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_start),
#endif
  };
  port43.param = __xlx_apatb_param_dbg_wl_start;

  static hls::sim::Register port44 {
    .name = "dbg_wl_addr_sel",
    .width = 8,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_addr_sel),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_addr_sel),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_addr_sel),
#endif
  };
  port44.param = __xlx_apatb_param_dbg_wl_addr_sel;

  static hls::sim::Register port45 {
    .name = "dbg_wl_layer",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_layer),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_layer),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_layer),
#endif
  };
  port45.param = __xlx_apatb_param_dbg_wl_layer;

  static hls::sim::Register port46 {
    .name = "dbg_wl_head",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_head),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_head),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_head),
#endif
  };
  port46.param = __xlx_apatb_param_dbg_wl_head;

  static hls::sim::Register port47 {
    .name = "dbg_wl_tile",
    .width = 32,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_wl_tile),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_wl_tile),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_wl_tile),
#endif
  };
  port47.param = __xlx_apatb_param_dbg_wl_tile;

  static hls::sim::Register port48 {
    .name = "dbg_done",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_done),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_done),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_done),
#endif
  };
  port48.param = __xlx_apatb_param_dbg_done;

  static hls::sim::Register port49 {
    .name = "dbg_error",
    .width = 1,
#ifdef POST_CHECK
    .reader = new hls::sim::Reader(AUTOTB_TVOUT_PC_dbg_error),
#else
    .owriter = new hls::sim::Writer(AUTOTB_TVOUT_dbg_error),
    .iwriter = new hls::sim::Writer(AUTOTB_TVIN_dbg_error),
#endif
  };
  port49.param = __xlx_apatb_param_dbg_error;

  try {
#ifdef POST_CHECK
    CodeState = ENTER_WRAPC_PC;
    check(port2);
    check(port4);
    check(port5);
    check(port8);
    check(port9);
    check(port10);
    check(port11);
    check(port12);
    check(port13);
    check(port15);
    check(port19);
    check(port24);
    check(port25);
    check(port27);
    check(port28);
    check(port29);
    check(port30);
    check(port31);
    check(port32);
    check(port33);
    check(port34);
    check(port35);
    check(port36);
    check(port37);
    check(port38);
    check(port39);
    check(port40);
    check(port41);
    check(port42);
    check(port43);
    check(port44);
    check(port45);
    check(port46);
    check(port47);
    check(port48);
    check(port49);
#else
    static hls::sim::RefTCL tcl("../tv/cdatafile/ref.tcl");
    tcl.containsVLA = 0;
    CodeState = DUMP_INPUTS;
    dump(port0, port0.iwriter, tcl.AESL_transaction);
    dump(port1, port1.iwriter, tcl.AESL_transaction);
    dump(port2, port2.iwriter, tcl.AESL_transaction);
    dump(port3, port3.iwriter, tcl.AESL_transaction);
    dump(port4, port4.iwriter, tcl.AESL_transaction);
    dump(port5, port5.iwriter, tcl.AESL_transaction);
    dump(port6, port6.iwriter, tcl.AESL_transaction);
    dump(port7, port7.iwriter, tcl.AESL_transaction);
    dump(port8, port8.iwriter, tcl.AESL_transaction);
    dump(port9, port9.iwriter, tcl.AESL_transaction);
    dump(port10, port10.iwriter, tcl.AESL_transaction);
    dump(port11, port11.iwriter, tcl.AESL_transaction);
    dump(port12, port12.iwriter, tcl.AESL_transaction);
    dump(port13, port13.iwriter, tcl.AESL_transaction);
    dump(port14, port14.iwriter, tcl.AESL_transaction);
    dump(port15, port15.iwriter, tcl.AESL_transaction);
    dump(port16, port16.iwriter, tcl.AESL_transaction);
    dump(port17, port17.iwriter, tcl.AESL_transaction);
    dump(port18, port18.iwriter, tcl.AESL_transaction);
    dump(port19, port19.iwriter, tcl.AESL_transaction);
    dump(port20, port20.iwriter, tcl.AESL_transaction);
    dump(port21, port21.iwriter, tcl.AESL_transaction);
    dump(port22, port22.iwriter, tcl.AESL_transaction);
    dump(port23, port23.iwriter, tcl.AESL_transaction);
    dump(port24, port24.iwriter, tcl.AESL_transaction);
    dump(port25, port25.iwriter, tcl.AESL_transaction);
    dump(port26, port26.iwriter, tcl.AESL_transaction);
    dump(port27, port27.iwriter, tcl.AESL_transaction);
    dump(port28, port28.iwriter, tcl.AESL_transaction);
    dump(port29, port29.iwriter, tcl.AESL_transaction);
    dump(port30, port30.iwriter, tcl.AESL_transaction);
    dump(port31, port31.iwriter, tcl.AESL_transaction);
    dump(port32, port32.iwriter, tcl.AESL_transaction);
    dump(port33, port33.iwriter, tcl.AESL_transaction);
    dump(port34, port34.iwriter, tcl.AESL_transaction);
    dump(port35, port35.iwriter, tcl.AESL_transaction);
    dump(port36, port36.iwriter, tcl.AESL_transaction);
    dump(port37, port37.iwriter, tcl.AESL_transaction);
    dump(port38, port38.iwriter, tcl.AESL_transaction);
    dump(port39, port39.iwriter, tcl.AESL_transaction);
    dump(port40, port40.iwriter, tcl.AESL_transaction);
    dump(port41, port41.iwriter, tcl.AESL_transaction);
    dump(port42, port42.iwriter, tcl.AESL_transaction);
    dump(port43, port43.iwriter, tcl.AESL_transaction);
    dump(port44, port44.iwriter, tcl.AESL_transaction);
    dump(port45, port45.iwriter, tcl.AESL_transaction);
    dump(port46, port46.iwriter, tcl.AESL_transaction);
    dump(port47, port47.iwriter, tcl.AESL_transaction);
    dump(port48, port48.iwriter, tcl.AESL_transaction);
    dump(port49, port49.iwriter, tcl.AESL_transaction);
    port0.doTCL(tcl);
    port1.doTCL(tcl);
    port2.doTCL(tcl);
    port3.doTCL(tcl);
    port4.doTCL(tcl);
    port5.doTCL(tcl);
    port6.doTCL(tcl);
    port7.doTCL(tcl);
    port8.doTCL(tcl);
    port9.doTCL(tcl);
    port10.doTCL(tcl);
    port11.doTCL(tcl);
    port12.doTCL(tcl);
    port13.doTCL(tcl);
    port14.doTCL(tcl);
    port15.doTCL(tcl);
    port16.doTCL(tcl);
    port17.doTCL(tcl);
    port18.doTCL(tcl);
    port19.doTCL(tcl);
    port20.doTCL(tcl);
    port21.doTCL(tcl);
    port22.doTCL(tcl);
    port23.doTCL(tcl);
    port24.doTCL(tcl);
    port25.doTCL(tcl);
    port26.doTCL(tcl);
    port27.doTCL(tcl);
    port28.doTCL(tcl);
    port29.doTCL(tcl);
    port30.doTCL(tcl);
    port31.doTCL(tcl);
    port32.doTCL(tcl);
    port33.doTCL(tcl);
    port34.doTCL(tcl);
    port35.doTCL(tcl);
    port36.doTCL(tcl);
    port37.doTCL(tcl);
    port38.doTCL(tcl);
    port39.doTCL(tcl);
    port40.doTCL(tcl);
    port41.doTCL(tcl);
    port42.doTCL(tcl);
    port43.doTCL(tcl);
    port44.doTCL(tcl);
    port45.doTCL(tcl);
    port46.doTCL(tcl);
    port47.doTCL(tcl);
    port48.doTCL(tcl);
    port49.doTCL(tcl);
    CodeState = CALL_C_DUT;
    transformer_top_hw_stub_wrapper(__xlx_apatb_param_axis_in_valid, __xlx_apatb_param_axis_in_last, __xlx_apatb_param_axis_in_ready, __xlx_apatb_param_dma_done, __xlx_apatb_param_dma_address, __xlx_apatb_param_memory_request, __xlx_apatb_param_compute_ready, __xlx_apatb_param_compute_done, __xlx_apatb_param_compute_start, __xlx_apatb_param_compute_op, __xlx_apatb_param_head_ctx_ref_0, __xlx_apatb_param_head_ctx_ref_1, __xlx_apatb_param_head_ctx_ref_2, __xlx_apatb_param_head_ctx_ref_3, __xlx_apatb_param_stream_ready, __xlx_apatb_param_stream_start, __xlx_apatb_param_stream_done, __xlx_apatb_param_ctrl_addr, __xlx_apatb_param_ctrl_data_in, __xlx_apatb_param_ctrl_data_out, __xlx_apatb_param_ctrl_read_en, __xlx_apatb_param_ctrl_write_en, __xlx_apatb_param_ctrl_chip_en, __xlx_apatb_param_ctrl_resetn_in, __xlx_apatb_param_irq_ps, __xlx_apatb_param_dbg_state, __xlx_apatb_param_dbg_ctrl_mem, __xlx_apatb_param_control_reg, __xlx_apatb_param_irq_status_reg, __xlx_apatb_param_irq_enable_reg, __xlx_apatb_param_wq_base_addr, __xlx_apatb_param_wk_base_addr, __xlx_apatb_param_wv_base_addr, __xlx_apatb_param_wo_base_addr, __xlx_apatb_param_w1_base_addr, __xlx_apatb_param_w2_base_addr, __xlx_apatb_param_wq_head_stride, __xlx_apatb_param_wk_head_stride, __xlx_apatb_param_wv_head_stride, __xlx_apatb_param_wo_tile_stride, __xlx_apatb_param_w1_tile_stride, __xlx_apatb_param_w2_tile_stride, __xlx_apatb_param_dbg_wl_ready, __xlx_apatb_param_dbg_wl_start, __xlx_apatb_param_dbg_wl_addr_sel, __xlx_apatb_param_dbg_wl_layer, __xlx_apatb_param_dbg_wl_head, __xlx_apatb_param_dbg_wl_tile, __xlx_apatb_param_dbg_done, __xlx_apatb_param_dbg_error);
    CodeState = DUMP_OUTPUTS;
    dump(port2, port2.owriter, tcl.AESL_transaction);
    dump(port4, port4.owriter, tcl.AESL_transaction);
    dump(port5, port5.owriter, tcl.AESL_transaction);
    dump(port8, port8.owriter, tcl.AESL_transaction);
    dump(port9, port9.owriter, tcl.AESL_transaction);
    dump(port10, port10.owriter, tcl.AESL_transaction);
    dump(port11, port11.owriter, tcl.AESL_transaction);
    dump(port12, port12.owriter, tcl.AESL_transaction);
    dump(port13, port13.owriter, tcl.AESL_transaction);
    dump(port15, port15.owriter, tcl.AESL_transaction);
    dump(port19, port19.owriter, tcl.AESL_transaction);
    dump(port24, port24.owriter, tcl.AESL_transaction);
    dump(port25, port25.owriter, tcl.AESL_transaction);
    dump(port27, port27.owriter, tcl.AESL_transaction);
    dump(port28, port28.owriter, tcl.AESL_transaction);
    dump(port29, port29.owriter, tcl.AESL_transaction);
    dump(port30, port30.owriter, tcl.AESL_transaction);
    dump(port31, port31.owriter, tcl.AESL_transaction);
    dump(port32, port32.owriter, tcl.AESL_transaction);
    dump(port33, port33.owriter, tcl.AESL_transaction);
    dump(port34, port34.owriter, tcl.AESL_transaction);
    dump(port35, port35.owriter, tcl.AESL_transaction);
    dump(port36, port36.owriter, tcl.AESL_transaction);
    dump(port37, port37.owriter, tcl.AESL_transaction);
    dump(port38, port38.owriter, tcl.AESL_transaction);
    dump(port39, port39.owriter, tcl.AESL_transaction);
    dump(port40, port40.owriter, tcl.AESL_transaction);
    dump(port41, port41.owriter, tcl.AESL_transaction);
    dump(port42, port42.owriter, tcl.AESL_transaction);
    dump(port43, port43.owriter, tcl.AESL_transaction);
    dump(port44, port44.owriter, tcl.AESL_transaction);
    dump(port45, port45.owriter, tcl.AESL_transaction);
    dump(port46, port46.owriter, tcl.AESL_transaction);
    dump(port47, port47.owriter, tcl.AESL_transaction);
    dump(port48, port48.owriter, tcl.AESL_transaction);
    dump(port49, port49.owriter, tcl.AESL_transaction);
    tcl.AESL_transaction++;
#endif
  } catch (const hls::sim::SimException &e) {
    hls::sim::errExit(e.line, e.msg);
  }
}