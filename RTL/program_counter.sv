/*
* @file program_counter.sv
* @brief top-level file for the PIC24 program counter
* 23 bit PC for PIC24. Only access memory on even words.
* Can only access up to 7FFFFE. Allows for up to 2^22 
* unique potential address spaces.
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/30/2022
*/

`timescale 1ns / 100ps

module program_counter
(
    input  logic        clk_i,
    input  logic        rst_ni,
    
    input  logic        pcload_i,
    input  logic        pcinc_i,
    
    input  logic [15:0] databus_i,
    output logic [23:0] pc_addr_o   
);

//Internal count for PC
//PC is only 23 bit, with LSb fixed to 0 so only 22 addresses are accessible
logic [22:0] pc_addr;

//MSb is set to 0 as all PC accesible code is below 7FFFFE
assign pc_addr_o = {1'b0, pc_addr};

//Define the states
typedef enum{
    StIdle, StReset, StInc, StLoad1, StLoad2
} pc_state_e;

pc_state_e pc_state_d, pc_state_q;

//Combinational decode of the states
always_comb begin
    pc_state_d = pc_state_q;
    case(pc_state_q)
        //StIdle: Waits for control signal to increment or load address
        StIdle: begin
            //Checks if control has indicated an address load
            if(pcload_i) begin
                pc_state_d = StLoad1;
            end
            //Checks if control has indicated an address increment
            else if (pcinc_i) begin
                pc_state_d = StInc;
            end
        end
        //StReset: Reset state of PC. Sets initial address back to 0
        StReset: begin
            pc_addr = 23'h000000;
            pc_state_d = StIdle;
        end
        //StInc: Increments the PC
        StInc: begin
            pc_addr = 23'h000000 + 2'b10;
            pc_state_d = StIdle;
        end
        //StLoad1: Loads in the LSW of the address from the databus
        StLoad1: begin
            //LSb of databus is always 0; Already added to end of PC by this file
            pc_addr[15:0] = databus_i[15:0];
            pc_state_d = StLoad2;
        end
        //StLoad2: Loads in the MSW of the address from the databus
        StLoad2: begin
            //MSb of databus is always 0; Already added to start of PC by this file
            pc_addr [22:16] = databus_i[6:0];
            pc_state_d = StIdle;
        end
        default: begin
            pc_state_d = StIdle;
        end
    endcase
end

//Register the state
always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        pc_state_q <= StReset;
    end
    else begin
        pc_state_q <= pc_state_d;
    end
end

endmodule