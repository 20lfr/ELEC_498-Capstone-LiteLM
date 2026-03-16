1. Dont make stream out chunked. Just make the out_buffer LARGE enough to fit the MAX output value
2. Expand axi-full transfer size from 32 bits (axi_gmem_word_t) to 512 bits
3. Expand the axi-stream transfer size from 8 bits (hls::stream<axis8_t>) to 1024 bits