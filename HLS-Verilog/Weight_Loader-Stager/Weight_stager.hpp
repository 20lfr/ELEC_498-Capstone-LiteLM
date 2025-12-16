#pragma once
#include <cstdint>
#include "../../top.hpp"





uint32_t weight_stager(
    bool wl_ready,      
    bool wl_start,       
    DmaSel wl_addr_sel, 
    int  wl_layer,     
    int  wl_head,        
    int  wl_tile        
);