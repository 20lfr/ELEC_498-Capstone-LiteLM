#include "xcontroltest_top.h"
#include <stdio.h>

int main() {
    XControltest_top my_ip;
    int status;

    // 1. Initialize the IP
    // Replace "my_ip_uio_name" with the name found in /sys/class/uio
    status = XControltest_top_Initialize(&my_ip, "ControlTest_Top"); 
    if (status != XST_SUCCESS) {
        printf("Error: Could not initialize IP core.\n");
        return -1;
    }

    // 2. Prepare Configuration Data
    XControltest_top_Config_in my_config = {0};
    my_config.word_0 = 0x12345678; // Example data
    // ... set other words as needed ...

    // 3. Send data to Hardware
    XControltest_top_Set_config_in(&my_ip, my_config);

    // 4. Start the IP
    XControltest_top_Start(&my_ip);

    // 5. Poll for completion
    printf("Waiting for IP to finish...\n");
    while (!XControltest_top_IsDone(&my_ip));

    // 6. Read results
    XControltest_top_Status_out results = XControltest_top_Get_status_out(&my_ip);
    printf("Result Word 0: 0x%08x\n", results.word_0);

    // 7. Cleanup
    XControltest_top_Release(&my_ip);
    return 0;
}