/*
* @file pic24_top.sv
* @brief top-level file for the PIC24
* Implements a Harvard Architecture with 16-bit data bus
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/29/2022
*/

`timescale 1ns / 100ps

module pic24_top
(
    input logic clk50M_i,
    input logic rst_ni
    
);

logic [15:0] pic_databus;

logic [23:0] pc_addr;
logic [23:0] latch_pc_addr;

logic [23:0] instr_dat;
logic [23:0] latch_instr_dat;

logic [23:0] latch_ir_dat;

//Control Signals
logic pc_load;
logic pc_inc;

logic address_latch_en;
logic data_latch_en;
logic rom_latch_en;

assign pic_databus = latch_instr_dat [15:0];

program_counter i_program_counter(
    .clk_i    (clk50M_i),
    .rst_ni   (rst_ni),
    .pcload_i (pc_load),
    .pcinc_i  (pc_inc),
    .databus_i(pic_databus),
    .pc_addr_o(pc_addr) 
);

latch_24bit address_latch(
    .en_i (address_latch_en),
    .in_d (pc_addr),
    .out_q(latch_pc_addr)
);

rom i_rom(
    .clk_i     (clk50M_i),
    .rst_ni    (rst_ni),
    .pc_addr_i (latch_pc_addr),
    .rom_instr_o(instr_dat)
);

latch_24bit data_latch(
    .en_i (data_latch_en),
    .in_d (instr_dat),
    .out_q(latch_instr_dat)
);

latch_24bit rom_latch(
    .en_i (rom_latch_en),
    .in_d (latch_instr_dat),
    .out_q(latch_ir_dat)
);

endmodule