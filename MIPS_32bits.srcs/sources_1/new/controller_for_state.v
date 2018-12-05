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


module controller_for_state(
    output reg [3:0] cs, ns,
    input clk, rst
    );
    
    parameter IF  = 4'd0;
    parameter ID  = 4'd1;
    parameter EX  = 4'd2;
    parameter MEM = 4'd3;
    parameter WB  = 4'd4;
    
    always @ (negedge clk or posedge rst) begin
        if(rst)
            cs <= IF;
            // Do we need to reset 'ns' also?
        else
            cs <= ns;
    end
    
    always @ (*) begin
        case(cs)
            WB : ns = IF;
            default : ns = (cs + 1); 
        endcase
    end
    
endmodule
