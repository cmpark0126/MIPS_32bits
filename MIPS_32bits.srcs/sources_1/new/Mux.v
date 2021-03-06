`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/29 03:41:06
// Design Name: 
// Module Name: Mux
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


module Mux_5bits( // combinational logic circuit. so do not need clk
    output [4:0] out,
    input [4:0] in0, in1,
    input sel 
    );
    
    assign out = (sel)? in1 : in0;
    
//    always @(sel) begin
//        if(!sel) out = in0;
//        else out = in1; 
//    end
    
endmodule


module Mux_32bits( // combinational logic circuit. so do not need clk
    output [31:0] out,
    input [31:0] in0, in1,
    input sel
    );
    
    assign out = (sel)? in1 : in0;
    
//    always @(sel) begin
//        if(!sel) out = in0;
//        else out = in1; 
//    end
    
endmodule