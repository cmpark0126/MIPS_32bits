`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:00:00
// Design Name: 
// Module Name: Instruction_decode
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


module Instruction_decode(
    output [31:0] read_data1, read_data2,
    input [3:0] read_reg1, read_reg2, write_reg, 
    input [31:0] write_data,
    input [3:0] cs,
    input clk, rst 
    );
    
    parameter ID = 4'd1;
    parameter WB = 4'd4;
    reg [31:0] mips_register_set [0:31];
    reg [31:0] temp1, temp2;
    
    always @(posedge clk or posedge rst) begin
            if(rst) begin
                temp1 <= 32'd0;
                temp2 <= 32'd0;
                // we should not need reset register set.
                // previous value will be considered garbage value
            end
            else if(cs == ID) begin
            end
            else begin 
            end
        end
        
        always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
            if(rst) ;
            else if(cs == ID) ;
            else ;
        end
    
    
    
endmodule
