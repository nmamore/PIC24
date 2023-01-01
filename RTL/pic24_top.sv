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

//Control Signals
logic pc_load;
logic pc_inc;


program_counter i_program_counter(
	.clk_i	  (clk50M_i),
	.rst_ni	  (rst_ni),
	.pcload_i (pc_load),
	.pcinc_i  (pc_inc),
	.databus_i(pic_databus),
	.pc_addr_o(pc_addr)	
);

endmodule