/*
* @file latch_24bit.sv
* @brief 24-bit Latch for use in PIC
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/31/2022
*/

`timescale 1ns / 100ps

module latch_24bit
(
    input logic         en_i,
    
    input logic  [23:0] in_d,
    output logic [23:0] out_q
);

always_comb begin
    if (en_i) begin
        out_q = in_d;
    end
    else begin
        out_q = 24'hzzzzzz;
    end
end

endmodule