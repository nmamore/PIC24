/*
* @file rom_mem.svh
* @brief Contents of ROM for PIC24
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/31/2022
*/

localparam int WIDTH = 4;
localparam int DEPTH = (2**WIDTH) - 1;

localparam logic [15:0] ROM_DATA[DEPTH] = {
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF,
    16'hFFFF
};