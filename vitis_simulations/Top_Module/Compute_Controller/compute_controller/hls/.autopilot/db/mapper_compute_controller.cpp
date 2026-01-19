#include "hls_signal_handler.h"
#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <vector>
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_directio.h"
#include "hls_stream.h"
using namespace std;

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
  struct Buffer {
    char *first;
    Buffer(char *addr) : first(addr)
    {
    }
  };

  struct DBuffer : public Buffer {
    static const size_t total = 1<<10;
    size_t ufree;

    DBuffer(size_t usize) : Buffer(nullptr), ufree(total)
    {
      first = new char[usize*ufree];
    }

    ~DBuffer()
    {
      delete[] first;
    }
  };

  struct CStream {
    char *front;
    char *back;
    size_t num;
    size_t usize;
    std::list<Buffer*> bufs;
    bool dynamic;

    CStream() : front(nullptr), back(nullptr),
                num(0), usize(0), dynamic(true)
    {
    }

    ~CStream()
    {
      for (Buffer *p : bufs) {
        delete p;
      }
    }

    template<typename T>
    T* data()
    {
      return (T*)front;
    }

    template<typename T>
    void transfer(hls::stream<T> *param)
    {
      while (!empty()) {
        param->write(*(T*)nextRead());
      }
    }

    bool empty();
    char* nextRead();
    char* nextWrite();
  };

  bool CStream::empty()
  {
    return num == 0;
  }

  char* CStream::nextRead()
  {
    assert(num > 0);
    char *res = front;
    front += usize;
    if (dynamic) {
      if (++static_cast<DBuffer*>(bufs.front())->ufree == DBuffer::total) {
        if (bufs.size() > 1) {
          bufs.pop_front();
          front = bufs.front()->first;
        } else {
          front = back = bufs.front()->first;
        }
      }
    }
    --num;
    return res;
  }

  char* CStream::nextWrite()
  {
    if (dynamic) {
      if (static_cast<DBuffer*>(bufs.back())->ufree == 0) {
        bufs.push_back(new DBuffer(usize));
        back = bufs.back()->first;
      }
      --static_cast<DBuffer*>(bufs.back())->ufree;
    }
    char *res = back;
    back += usize;
    ++num;
    return res;
  }

  std::list<CStream> streams;
  std::map<char*, CStream*> prebuilt;

  CStream* createStream(size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = true;
      s.bufs.push_back(new DBuffer(usize));
      s.front = s.bufs.back()->first;
      s.back = s.front;
      s.num = 0;
      s.usize = usize;
    }
    return &s;
  }

  template<typename T>
  CStream* createStream(hls::stream<T> *param)
  {
    CStream *s = createStream(sizeof(T));
    {
      s->dynamic = true;
      while (!param->empty()) {
        T data = param->read();
        memcpy(s->nextWrite(), (char*)&data, sizeof(T));
      }
      prebuilt[s->front] = s;
    }
    return s;
  }

  template<typename T>
  CStream* createStream(T *param, size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = false;
      s.bufs.push_back(new Buffer((char*)param));
      s.front = s.back = s.bufs.back()->first;
      s.usize = usize;
      s.num = ~0UL;
    }
    prebuilt[s.front] = &s;
    return &s;
  }

  CStream* findStream(char *buf)
  {
    return prebuilt.at(buf);
  }
}
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
using hls::sim::Byte;
extern "C" void compute_controller(char, char, int, volatile void *, volatile void *, char, volatile void *, volatile void *, volatile void *, Byte<1>*, Byte<1>*, Byte<4>*, Byte<4>*, Byte<1>*, Byte<1>*, Byte<2>*, Byte<2>*, Byte<2>*, Byte<2>*, Byte<2>*, Byte<1>*, Byte<1>*, Byte<2>*, Byte<4>*, Byte<4>*, int, int, int, Byte<1>*, Byte<4>*, Byte<4>*, int, Byte<4>*, Byte<1>*, Byte<1>*, volatile void *);
extern "C" void apatb_compute_controller_hw(char __xlx_apatb_param_reset, char __xlx_apatb_param_compute_start, int __xlx_apatb_param_compute_instruction, volatile void * __xlx_apatb_param_compute_ready, volatile void * __xlx_apatb_param_compute_done, char __xlx_apatb_param_mem_transfer_done, volatile void * __xlx_apatb_param_mem_read_request, volatile void * __xlx_apatb_param_mem_write_request, volatile void * __xlx_apatb_param_mem_op, volatile void * __xlx_apatb_param_int8_activation, volatile void * __xlx_apatb_param_OUT_PROJ_valueB, volatile void * __xlx_apatb_param_OUT_PROJ_bias, volatile void * __xlx_apatb_param_OUT_PROJ_accum, volatile void * __xlx_apatb_param_FFN1_weights1, volatile void * __xlx_apatb_param_FFN1_biases, volatile void * __xlx_apatb_param_FFN1_scale, volatile void * __xlx_apatb_param_FFN1_output, volatile void * __xlx_apatb_param_RELU_input, volatile void * __xlx_apatb_param_RELU_output, volatile void * __xlx_apatb_param_FFN2_input, volatile void * __xlx_apatb_param_FFN2_weights2, volatile void * __xlx_apatb_param_FFN2_biases, volatile void * __xlx_apatb_param_FFN2_scale, volatile void * __xlx_apatb_param_FFN2_output, volatile void * __xlx_apatb_param_requant_activation, int __xlx_apatb_param_requant_scale, int __xlx_apatb_param_requant_shift, int __xlx_apatb_param_requant_zero_point, volatile void * __xlx_apatb_param_requant_output, volatile void * __xlx_apatb_param_layerNorm_gamma, volatile void * __xlx_apatb_param_layerNorm_beta, int __xlx_apatb_param_layerNorm_epsilon, volatile void * __xlx_apatb_param_layerNorm_out, volatile void * __xlx_apatb_param_residualAdd_residual, volatile void * __xlx_apatb_param_residualAdd_output, volatile void * __xlx_apatb_param_error) {
using hls::sim::createStream;
  // Collect __xlx_int8_activation__tmp_vec
std::vector<Byte<1>> __xlx_int8_activation__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_int8_activation__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_int8_activation)[i]);
}
  int __xlx_size_param_int8_activation = 8;
  int __xlx_offset_param_int8_activation = 0;
  int __xlx_offset_byte_param_int8_activation = 0*1;
  // Collect __xlx_OUT_PROJ_valueB__tmp_vec
std::vector<Byte<1>> __xlx_OUT_PROJ_valueB__tmp_vec;
for (size_t i = 0; i < 16; ++i){
__xlx_OUT_PROJ_valueB__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_OUT_PROJ_valueB)[i]);
}
  int __xlx_size_param_OUT_PROJ_valueB = 16;
  int __xlx_offset_param_OUT_PROJ_valueB = 0;
  int __xlx_offset_byte_param_OUT_PROJ_valueB = 0*1;
  // Collect __xlx_OUT_PROJ_bias__tmp_vec
std::vector<Byte<4>> __xlx_OUT_PROJ_bias__tmp_vec;
for (size_t i = 0; i < 2; ++i){
__xlx_OUT_PROJ_bias__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_OUT_PROJ_bias)[i]);
}
  int __xlx_size_param_OUT_PROJ_bias = 2;
  int __xlx_offset_param_OUT_PROJ_bias = 0;
  int __xlx_offset_byte_param_OUT_PROJ_bias = 0*4;
  // Collect __xlx_OUT_PROJ_accum__tmp_vec
std::vector<Byte<4>> __xlx_OUT_PROJ_accum__tmp_vec;
for (size_t i = 0; i < 2; ++i){
__xlx_OUT_PROJ_accum__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_OUT_PROJ_accum)[i]);
}
  int __xlx_size_param_OUT_PROJ_accum = 2;
  int __xlx_offset_param_OUT_PROJ_accum = 0;
  int __xlx_offset_byte_param_OUT_PROJ_accum = 0*4;
  // Collect __xlx_FFN1_weights1__tmp_vec
std::vector<Byte<1>> __xlx_FFN1_weights1__tmp_vec;
for (size_t i = 0; i < 16; ++i){
__xlx_FFN1_weights1__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_FFN1_weights1)[i]);
}
  int __xlx_size_param_FFN1_weights1 = 16;
  int __xlx_offset_param_FFN1_weights1 = 0;
  int __xlx_offset_byte_param_FFN1_weights1 = 0*1;
  // Collect __xlx_FFN1_biases__tmp_vec
std::vector<Byte<1>> __xlx_FFN1_biases__tmp_vec;
for (size_t i = 0; i < 2; ++i){
__xlx_FFN1_biases__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_FFN1_biases)[i]);
}
  int __xlx_size_param_FFN1_biases = 2;
  int __xlx_offset_param_FFN1_biases = 0;
  int __xlx_offset_byte_param_FFN1_biases = 0*1;
  // Collect __xlx_FFN1_scale__tmp_vec
std::vector<Byte<2>> __xlx_FFN1_scale__tmp_vec;
for (size_t i = 0; i < 2; ++i){
__xlx_FFN1_scale__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_FFN1_scale)[i]);
}
  int __xlx_size_param_FFN1_scale = 2;
  int __xlx_offset_param_FFN1_scale = 0;
  int __xlx_offset_byte_param_FFN1_scale = 0*2;
  // Collect __xlx_FFN1_output__tmp_vec
std::vector<Byte<2>> __xlx_FFN1_output__tmp_vec;
for (size_t i = 0; i < 2; ++i){
__xlx_FFN1_output__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_FFN1_output)[i]);
}
  int __xlx_size_param_FFN1_output = 2;
  int __xlx_offset_param_FFN1_output = 0;
  int __xlx_offset_byte_param_FFN1_output = 0*2;
  // Collect __xlx_RELU_input__tmp_vec
std::vector<Byte<2>> __xlx_RELU_input__tmp_vec;
for (size_t i = 0; i < 22; ++i){
__xlx_RELU_input__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_RELU_input)[i]);
}
  int __xlx_size_param_RELU_input = 22;
  int __xlx_offset_param_RELU_input = 0;
  int __xlx_offset_byte_param_RELU_input = 0*2;
  // Collect __xlx_RELU_output__tmp_vec
std::vector<Byte<2>> __xlx_RELU_output__tmp_vec;
for (size_t i = 0; i < 22; ++i){
__xlx_RELU_output__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_RELU_output)[i]);
}
  int __xlx_size_param_RELU_output = 22;
  int __xlx_offset_param_RELU_output = 0;
  int __xlx_offset_byte_param_RELU_output = 0*2;
  // Collect __xlx_FFN2_input__tmp_vec
std::vector<Byte<2>> __xlx_FFN2_input__tmp_vec;
for (size_t i = 0; i < 22; ++i){
__xlx_FFN2_input__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_FFN2_input)[i]);
}
  int __xlx_size_param_FFN2_input = 22;
  int __xlx_offset_param_FFN2_input = 0;
  int __xlx_offset_byte_param_FFN2_input = 0*2;
  // Collect __xlx_FFN2_weights2__tmp_vec
std::vector<Byte<1>> __xlx_FFN2_weights2__tmp_vec;
for (size_t i = 0; i < 110; ++i){
__xlx_FFN2_weights2__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_FFN2_weights2)[i]);
}
  int __xlx_size_param_FFN2_weights2 = 110;
  int __xlx_offset_param_FFN2_weights2 = 0;
  int __xlx_offset_byte_param_FFN2_weights2 = 0*1;
  // Collect __xlx_FFN2_biases__tmp_vec
std::vector<Byte<1>> __xlx_FFN2_biases__tmp_vec;
for (size_t i = 0; i < 5; ++i){
__xlx_FFN2_biases__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_FFN2_biases)[i]);
}
  int __xlx_size_param_FFN2_biases = 5;
  int __xlx_offset_param_FFN2_biases = 0;
  int __xlx_offset_byte_param_FFN2_biases = 0*1;
  // Collect __xlx_FFN2_scale__tmp_vec
std::vector<Byte<2>> __xlx_FFN2_scale__tmp_vec;
for (size_t i = 0; i < 5; ++i){
__xlx_FFN2_scale__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_FFN2_scale)[i]);
}
  int __xlx_size_param_FFN2_scale = 5;
  int __xlx_offset_param_FFN2_scale = 0;
  int __xlx_offset_byte_param_FFN2_scale = 0*2;
  // Collect __xlx_FFN2_output__tmp_vec
std::vector<Byte<4>> __xlx_FFN2_output__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_FFN2_output__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_FFN2_output)[i]);
}
  int __xlx_size_param_FFN2_output = 8;
  int __xlx_offset_param_FFN2_output = 0;
  int __xlx_offset_byte_param_FFN2_output = 0*4;
  // Collect __xlx_requant_activation__tmp_vec
std::vector<Byte<4>> __xlx_requant_activation__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_requant_activation__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_requant_activation)[i]);
}
  int __xlx_size_param_requant_activation = 8;
  int __xlx_offset_param_requant_activation = 0;
  int __xlx_offset_byte_param_requant_activation = 0*4;
  // Collect __xlx_requant_output__tmp_vec
std::vector<Byte<1>> __xlx_requant_output__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_requant_output__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_requant_output)[i]);
}
  int __xlx_size_param_requant_output = 8;
  int __xlx_offset_param_requant_output = 0;
  int __xlx_offset_byte_param_requant_output = 0*1;
  // Collect __xlx_layerNorm_gamma__tmp_vec
std::vector<Byte<4>> __xlx_layerNorm_gamma__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_layerNorm_gamma__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_layerNorm_gamma)[i]);
}
  int __xlx_size_param_layerNorm_gamma = 8;
  int __xlx_offset_param_layerNorm_gamma = 0;
  int __xlx_offset_byte_param_layerNorm_gamma = 0*4;
  // Collect __xlx_layerNorm_beta__tmp_vec
std::vector<Byte<4>> __xlx_layerNorm_beta__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_layerNorm_beta__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_layerNorm_beta)[i]);
}
  int __xlx_size_param_layerNorm_beta = 8;
  int __xlx_offset_param_layerNorm_beta = 0;
  int __xlx_offset_byte_param_layerNorm_beta = 0*4;
  // Collect __xlx_layerNorm_out__tmp_vec
std::vector<Byte<4>> __xlx_layerNorm_out__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_layerNorm_out__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_layerNorm_out)[i]);
}
  int __xlx_size_param_layerNorm_out = 8;
  int __xlx_offset_param_layerNorm_out = 0;
  int __xlx_offset_byte_param_layerNorm_out = 0*4;
  // Collect __xlx_residualAdd_residual__tmp_vec
std::vector<Byte<1>> __xlx_residualAdd_residual__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_residualAdd_residual__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_residualAdd_residual)[i]);
}
  int __xlx_size_param_residualAdd_residual = 8;
  int __xlx_offset_param_residualAdd_residual = 0;
  int __xlx_offset_byte_param_residualAdd_residual = 0*1;
  // Collect __xlx_residualAdd_output__tmp_vec
std::vector<Byte<1>> __xlx_residualAdd_output__tmp_vec;
for (size_t i = 0; i < 8; ++i){
__xlx_residualAdd_output__tmp_vec.push_back(((Byte<1>*)__xlx_apatb_param_residualAdd_output)[i]);
}
  int __xlx_size_param_residualAdd_output = 8;
  int __xlx_offset_param_residualAdd_output = 0;
  int __xlx_offset_byte_param_residualAdd_output = 0*1;
  // DUT call
  compute_controller(__xlx_apatb_param_reset, __xlx_apatb_param_compute_start, __xlx_apatb_param_compute_instruction, __xlx_apatb_param_compute_ready, __xlx_apatb_param_compute_done, __xlx_apatb_param_mem_transfer_done, __xlx_apatb_param_mem_read_request, __xlx_apatb_param_mem_write_request, __xlx_apatb_param_mem_op, __xlx_int8_activation__tmp_vec.data(), __xlx_OUT_PROJ_valueB__tmp_vec.data(), __xlx_OUT_PROJ_bias__tmp_vec.data(), __xlx_OUT_PROJ_accum__tmp_vec.data(), __xlx_FFN1_weights1__tmp_vec.data(), __xlx_FFN1_biases__tmp_vec.data(), __xlx_FFN1_scale__tmp_vec.data(), __xlx_FFN1_output__tmp_vec.data(), __xlx_RELU_input__tmp_vec.data(), __xlx_RELU_output__tmp_vec.data(), __xlx_FFN2_input__tmp_vec.data(), __xlx_FFN2_weights2__tmp_vec.data(), __xlx_FFN2_biases__tmp_vec.data(), __xlx_FFN2_scale__tmp_vec.data(), __xlx_FFN2_output__tmp_vec.data(), __xlx_requant_activation__tmp_vec.data(), __xlx_apatb_param_requant_scale, __xlx_apatb_param_requant_shift, __xlx_apatb_param_requant_zero_point, __xlx_requant_output__tmp_vec.data(), __xlx_layerNorm_gamma__tmp_vec.data(), __xlx_layerNorm_beta__tmp_vec.data(), __xlx_apatb_param_layerNorm_epsilon, __xlx_layerNorm_out__tmp_vec.data(), __xlx_residualAdd_residual__tmp_vec.data(), __xlx_residualAdd_output__tmp_vec.data(), __xlx_apatb_param_error);
// print __xlx_apatb_param_int8_activation
for (size_t i = 0; i < __xlx_size_param_int8_activation; ++i) {
((Byte<1>*)__xlx_apatb_param_int8_activation)[i] = __xlx_int8_activation__tmp_vec[__xlx_offset_param_int8_activation+i];
}
// print __xlx_apatb_param_OUT_PROJ_valueB
for (size_t i = 0; i < __xlx_size_param_OUT_PROJ_valueB; ++i) {
((Byte<1>*)__xlx_apatb_param_OUT_PROJ_valueB)[i] = __xlx_OUT_PROJ_valueB__tmp_vec[__xlx_offset_param_OUT_PROJ_valueB+i];
}
// print __xlx_apatb_param_OUT_PROJ_bias
for (size_t i = 0; i < __xlx_size_param_OUT_PROJ_bias; ++i) {
((Byte<4>*)__xlx_apatb_param_OUT_PROJ_bias)[i] = __xlx_OUT_PROJ_bias__tmp_vec[__xlx_offset_param_OUT_PROJ_bias+i];
}
// print __xlx_apatb_param_OUT_PROJ_accum
for (size_t i = 0; i < __xlx_size_param_OUT_PROJ_accum; ++i) {
((Byte<4>*)__xlx_apatb_param_OUT_PROJ_accum)[i] = __xlx_OUT_PROJ_accum__tmp_vec[__xlx_offset_param_OUT_PROJ_accum+i];
}
// print __xlx_apatb_param_FFN1_weights1
for (size_t i = 0; i < __xlx_size_param_FFN1_weights1; ++i) {
((Byte<1>*)__xlx_apatb_param_FFN1_weights1)[i] = __xlx_FFN1_weights1__tmp_vec[__xlx_offset_param_FFN1_weights1+i];
}
// print __xlx_apatb_param_FFN1_biases
for (size_t i = 0; i < __xlx_size_param_FFN1_biases; ++i) {
((Byte<1>*)__xlx_apatb_param_FFN1_biases)[i] = __xlx_FFN1_biases__tmp_vec[__xlx_offset_param_FFN1_biases+i];
}
// print __xlx_apatb_param_FFN1_scale
for (size_t i = 0; i < __xlx_size_param_FFN1_scale; ++i) {
((Byte<2>*)__xlx_apatb_param_FFN1_scale)[i] = __xlx_FFN1_scale__tmp_vec[__xlx_offset_param_FFN1_scale+i];
}
// print __xlx_apatb_param_FFN1_output
for (size_t i = 0; i < __xlx_size_param_FFN1_output; ++i) {
((Byte<2>*)__xlx_apatb_param_FFN1_output)[i] = __xlx_FFN1_output__tmp_vec[__xlx_offset_param_FFN1_output+i];
}
// print __xlx_apatb_param_RELU_input
for (size_t i = 0; i < __xlx_size_param_RELU_input; ++i) {
((Byte<2>*)__xlx_apatb_param_RELU_input)[i] = __xlx_RELU_input__tmp_vec[__xlx_offset_param_RELU_input+i];
}
// print __xlx_apatb_param_RELU_output
for (size_t i = 0; i < __xlx_size_param_RELU_output; ++i) {
((Byte<2>*)__xlx_apatb_param_RELU_output)[i] = __xlx_RELU_output__tmp_vec[__xlx_offset_param_RELU_output+i];
}
// print __xlx_apatb_param_FFN2_input
for (size_t i = 0; i < __xlx_size_param_FFN2_input; ++i) {
((Byte<2>*)__xlx_apatb_param_FFN2_input)[i] = __xlx_FFN2_input__tmp_vec[__xlx_offset_param_FFN2_input+i];
}
// print __xlx_apatb_param_FFN2_weights2
for (size_t i = 0; i < __xlx_size_param_FFN2_weights2; ++i) {
((Byte<1>*)__xlx_apatb_param_FFN2_weights2)[i] = __xlx_FFN2_weights2__tmp_vec[__xlx_offset_param_FFN2_weights2+i];
}
// print __xlx_apatb_param_FFN2_biases
for (size_t i = 0; i < __xlx_size_param_FFN2_biases; ++i) {
((Byte<1>*)__xlx_apatb_param_FFN2_biases)[i] = __xlx_FFN2_biases__tmp_vec[__xlx_offset_param_FFN2_biases+i];
}
// print __xlx_apatb_param_FFN2_scale
for (size_t i = 0; i < __xlx_size_param_FFN2_scale; ++i) {
((Byte<2>*)__xlx_apatb_param_FFN2_scale)[i] = __xlx_FFN2_scale__tmp_vec[__xlx_offset_param_FFN2_scale+i];
}
// print __xlx_apatb_param_FFN2_output
for (size_t i = 0; i < __xlx_size_param_FFN2_output; ++i) {
((Byte<4>*)__xlx_apatb_param_FFN2_output)[i] = __xlx_FFN2_output__tmp_vec[__xlx_offset_param_FFN2_output+i];
}
// print __xlx_apatb_param_requant_activation
for (size_t i = 0; i < __xlx_size_param_requant_activation; ++i) {
((Byte<4>*)__xlx_apatb_param_requant_activation)[i] = __xlx_requant_activation__tmp_vec[__xlx_offset_param_requant_activation+i];
}
// print __xlx_apatb_param_requant_output
for (size_t i = 0; i < __xlx_size_param_requant_output; ++i) {
((Byte<1>*)__xlx_apatb_param_requant_output)[i] = __xlx_requant_output__tmp_vec[__xlx_offset_param_requant_output+i];
}
// print __xlx_apatb_param_layerNorm_gamma
for (size_t i = 0; i < __xlx_size_param_layerNorm_gamma; ++i) {
((Byte<4>*)__xlx_apatb_param_layerNorm_gamma)[i] = __xlx_layerNorm_gamma__tmp_vec[__xlx_offset_param_layerNorm_gamma+i];
}
// print __xlx_apatb_param_layerNorm_beta
for (size_t i = 0; i < __xlx_size_param_layerNorm_beta; ++i) {
((Byte<4>*)__xlx_apatb_param_layerNorm_beta)[i] = __xlx_layerNorm_beta__tmp_vec[__xlx_offset_param_layerNorm_beta+i];
}
// print __xlx_apatb_param_layerNorm_out
for (size_t i = 0; i < __xlx_size_param_layerNorm_out; ++i) {
((Byte<4>*)__xlx_apatb_param_layerNorm_out)[i] = __xlx_layerNorm_out__tmp_vec[__xlx_offset_param_layerNorm_out+i];
}
// print __xlx_apatb_param_residualAdd_residual
for (size_t i = 0; i < __xlx_size_param_residualAdd_residual; ++i) {
((Byte<1>*)__xlx_apatb_param_residualAdd_residual)[i] = __xlx_residualAdd_residual__tmp_vec[__xlx_offset_param_residualAdd_residual+i];
}
// print __xlx_apatb_param_residualAdd_output
for (size_t i = 0; i < __xlx_size_param_residualAdd_output; ++i) {
((Byte<1>*)__xlx_apatb_param_residualAdd_output)[i] = __xlx_residualAdd_output__tmp_vec[__xlx_offset_param_residualAdd_output+i];
}
}
