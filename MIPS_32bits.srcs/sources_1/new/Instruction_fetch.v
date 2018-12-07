`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:59:40
// Design Name: 
// Module Name: Instruction_fetch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_fetch(
    output reg [31:0] instruction,
    input [31:0] address,
    input [3:0] cs,
    input clk, rst 
    );
    
    parameter IF = 4'd0;
    
    /*
    * purpose : Fetch instruction from BRAM(instruction memory)  // instruction <= {BRAM[PC], BRAM[PC + 1], BRAM[PC + 2], BRAM[PC + 3]};
    * psuedo code :
        if posedge clk : fetch value from BRAM and target_address (PC)
        if negedge clk : read fetched value and save to instruction value (output port) 
    */
    
    // for debug
    wire [7:0] BRAM [0:15];
    assign {BRAM[0], BRAM[1], BRAM[2], BRAM[3]} = 32'h2008000A; // addi t0 zero 0xa
    assign {BRAM[4], BRAM[5], BRAM[6], BRAM[7]} = 32'h2009000C; // addi t1 zero 0xc
    assign {BRAM[8], BRAM[9], BRAM[10], BRAM[11]} = 32'h00081025; // or v0 zero t0
    assign {BRAM[12], BRAM[13], BRAM[14], BRAM[15]} = 32'h0000000C; // syscall
    
    reg [7:0] fetched_value [0:3];
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            fetched_value[0] <= BRAM[address];
            fetched_value[1] <= BRAM[address + 1];
            fetched_value[2] <= BRAM[address + 2];
            fetched_value[3] <= BRAM[address + 3];
        end
        else if(cs == IF) begin
            fetched_value[0] <= BRAM[address];
            fetched_value[1] <= BRAM[address + 1];
            fetched_value[2] <= BRAM[address + 2];
            fetched_value[3] <= BRAM[address + 3];
        end
        else begin 
            fetched_value[0] <= fetched_value[0];
            fetched_value[1] <= fetched_value[1];
            fetched_value[2] <= fetched_value[2];
            fetched_value[3] <= fetched_value[3];
        end
    end
    
    always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
        if(rst) instruction <= 32'd0;
        else if(cs == IF) instruction <= {fetched_value[0], fetched_value[1], fetched_value[2], fetched_value[3]};
        else instruction <= instruction;
    end
    
endmodule
