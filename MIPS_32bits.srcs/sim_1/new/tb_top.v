`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 20:50:43
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    wire [6:0] sseg;
    wire DP;
    wire [7:0]AN;
    reg clk, start_signal;
    
    top t0(
        .sseg(sseg),
        .DP(DP),
        .AN(AN),
        .clk(clk), .start_signal(start_signal)
        );
        
   initial begin
        start_signal = 0;
        #10 start_signal = 1;
    end
    
    initial begin
        clk = 0;
        forever
            #1 clk = ~clk;
    end
    
    initial begin
        #200000 $stop;
    end

endmodule
