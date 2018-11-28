`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 22:47:16
// Design Name: 
// Module Name: tb_top_after_IF
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


module tb_top_after_IF();
    wire [6:0] sseg;
    wire DP;
    wire [7:0]AN;
    reg clk, start_signal;
    wire [3:0] mode;
    
    assign mode = 4'd1;
    
    top t0(
        .sseg(sseg),
        .DP(DP),
        .AN(AN),
        .clk(clk), .start_signal(start_signal),
        .mode(mode)
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
