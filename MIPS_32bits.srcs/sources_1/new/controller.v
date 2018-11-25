`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 19:27:01
// Design Name: 
// Module Name: controller
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
`define S0 4'd0
`define S1 4'd1
`define S2 4'd2
`define S3 4'd3
`define S4 4'd4
`define S5 4'd5

module controller(
    output reg [3:0] cs, ns,
    input clk, rst
    );
    
    always @ (posedge clk or posedge rst) begin
        if(rst)
            cs <= `S0;
        else
            cs <= ns;
    end
    
    always @ (*) begin
        case(cs)
            `S5 : ns = `S0;
            default : ns = (cs + 1); 
        endcase
    end
    
endmodule
