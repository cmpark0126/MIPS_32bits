`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/02 14:54:47
// Design Name: 
// Module Name: Sign_extend_16to32bits
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


module Sign_extend_16to32bits(
    output [31:0] out,
    input [15:0] in
    );
    
    assign out = {16'd0, in};
    
endmodule
