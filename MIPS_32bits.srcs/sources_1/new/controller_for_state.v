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
    input mode,
    input start, resume,
    input clk, rst
    );
    
    parameter IF  = 4'd0;
    parameter ID  = 4'd1;
    parameter EX  = 4'd2;
    parameter MEM = 4'd3;
    parameter WB  = 4'd4;
    parameter INIT = 4'd5;
    parameter END  = 4'd6; 
    
    always @ (negedge clk or posedge rst) begin
        if(rst)
            cs <= INIT;
        else
            cs <= ns;
    end
    
    always @ (*) begin
        if(mode == 'd0) begin
            case(cs)
                INIT : ns = (start)? IF : INIT; // when interpreter in here
                END : ns = (resume)? INIT : END; // when program is end
                WB : ns = IF;
                default : ns = (cs + 1); 
            endcase
        end
        else begin
            case(cs)
                INIT : ns = (start)? IF : INIT; // when interpreter in here
                END : ns = (resume)? INIT : END; // when program is end
                WB : ns = INIT; // only one instruction going on
                default : ns = (cs + 1); 
            endcase
        end
    end
    
endmodule
