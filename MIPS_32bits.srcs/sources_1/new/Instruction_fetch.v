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
    input [3:0] address,
    input cs,
    input clk, rst 
    );
    
    /*
    * purpose : Fetch instruction from BRAM  // instruction <= {BRAM[PC], BRAM[PC + 1], BRAM[PC + 2], BRAM[PC + 3]};
    * psuedo code :
        if posedge clk : fetch value from BRAM and target_address (PC)
        if negedge clk : read fetched value and save to instruction value (output port) 
    */
    
    // for debug
    wire [7:0] BRAM [0:15];
    assign {BRAM[0], BRAM[1], BRAM[2], BRAM[3]} = {6'd0, 5'd18, 5'd19, 5'd17, 5'd0, 6'd32};
    assign {BRAM[4], BRAM[5], BRAM[6], BRAM[7]} = {6'd35, 5'd18, 5'd17, 16'd100};
    assign {BRAM[8], BRAM[9], BRAM[10], BRAM[11]} = {6'd43, 5'd18, 5'd17, 16'd100};
    assign {BRAM[12], BRAM[13], BRAM[14], BRAM[15]} = {6'b000_100, 5'd8, 5'd21, 16'd100};
    
    reg [7:0] fetched_value [0:3];
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            fetched_value[0] <= 8'd0;
            fetched_value[1] <= 8'd0;
            fetched_value[2] <= 8'd0;
            fetched_value[3] <= 8'd0;
        end
        else if(cs == 4'd0) begin
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
        else if(cs == 4'd0) instruction <= {fetched_value[0], fetched_value[1], fetched_value[2], fetched_value[3]};
        else instruction <= instruction;
    end
    
endmodule
