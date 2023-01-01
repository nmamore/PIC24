/*
* @file rom_mem.svh
* @brief Contents of ROM for PIC24
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/31/2022
*/

localparam int MEMSIZE = (2^24) - 1;

localparam int GOTO             = 24'h000000;
localparam int RESET            = 24'h000002;
localparam int IVT_START        = 24'h000004;
localparam int IVT_END          = 24'h0001FE;
localparam int PROG_MEM_ST      = 24'h000200;
localparam int PROG_MEM_END     = 24'h0557EA;
localparam int FLASH_CONFIG_ST  = 24'h0557EC;
localparam int FLASH_CONFIG_END = 24'h055800;
localparam int UNIMP_ST         = 24'h055800;
localparam int UNIMP_END        = 24'h7FFFFE;

localparam logic [23:0] ROM_DATA [MEMSIZE] = {
    for (int i = 0, i < MEMSIZE; i++) begin
        if (i == GOTO) begin
            ROM_DATA[i] = 24'hFFFFFF;
        end
        else if (i == RESET) begin
            ROM_DATA[i] = 24'hFFFFFF;
        end
        else if (i >= IVT_START && i <= IVT_END) begin
            ROM_DATA[i] = 24'hFFFFFF;
        end
        else if (i >= PROG_MEM_ST && i <= PROG_MEM_END) begin
            ROM_DATA[i] = 24'hFFFFFF;
        end
        else if (i >= FLASH_CONFIG_ST && i <= FLASH_CONFIG_END) begin
            ROM_DATA[i] = 24'hFFFFFF;
        end
        else if (i >= UNIMP_ST && i <= UNIMP_END) begin
            ROM_DATA[i] = 24'h000000;
        end
    end
};