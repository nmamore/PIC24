/*
* @file rom.sv
* @brief Read-Only Memory for PIC24. 175K instructions.
* User memory space is restricted to 7FFFFE
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/30/2022
*/

`timescale 1ns / 100ps



module rom
(
    input  logic        clk_i,
    input  logic        rst_ni,
    
    input  logic [23:0] pc_addr_i,
    output logic [23:0] rom_instr_o
);

logic [15:0] rom_LSW;
logic [15:0] rom_MSW;

assign rom_instr_o = {rom_MSW[7:0], rom_LSW};

`include "rom_mem.svh"


always_ff @(posedge clk_i or negedge rst_ni) begin
    if(!rst_ni) begin
        rom_LSW <= 16'h0000;
        rom_MSW <= 16'h0000;
    end
    else begin
        rom_LSW <= ROM_DATA[pc_addr_i];
        rom_MSW <= ROM_DATA[pc_addr_i + 1'b1];
    end
end

endmodule