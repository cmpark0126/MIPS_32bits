`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/02 13:27:49
// Design Name: 
// Module Name: Add
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


module Add4toPC(
    output reg [31:0] outPC,
    input [31:0] inPC,
    input [3:0] cs,
    input clk, rst
    );
    
    parameter IF = 4'd0;
    
    always @(negedge clk or posedge rst) begin // this time we use negedge, because write action in here
       if(rst) outPC <= 32'd0;
       else if(cs == IF) outPC <= inPC + 32'd4; // debuging
       else outPC <= outPC;
    end
    
endmodule

module Add_32bits(
    output reg [31:0] out,
    input [31:0] in0, in1,
    input [3:0] cs,
    input clk, rst
    );
    
    parameter EX  = 4'd2;
    
    always @(negedge clk or posedge rst) begin // this time we use negedge, because write action in here
       if(rst) out <= 32'd0;
       else if(cs == EX) out <= in0 + in1;
       else out <= out;
    end
    
//    assign out = in0 + in1;
    
endmodule