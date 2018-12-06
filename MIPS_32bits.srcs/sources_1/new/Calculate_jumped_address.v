`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/06 23:29:09
// Design Name: 
// Module Name: Calculate_jumped_address
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


module Calculate_jumped_address(
    output [31:0] jumped_address,
    input [25:0] value_from_instruction,
    input [3:0] PCadd4_header
    );
    
    assign jumped_address = {PCadd4_header, value_from_instruction, 2'b00};
    
    
endmodule
