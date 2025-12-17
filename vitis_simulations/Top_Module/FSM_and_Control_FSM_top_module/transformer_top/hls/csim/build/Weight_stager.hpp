#pragma once
#include <cstdint>
#include "../top_params.hpp"





uint32_t weight_stager(  
    bool        reset,    
    bool        wl_start,       
    DmaSel      wl_addr_sel, 
    int         wl_layer,     
    int         wl_head,        
    int         wl_tile, 
    ControlMemSpace ctrl_mem,

    bool        &wl_ready,
    bool        &memory_request,
    bool        &error
);
