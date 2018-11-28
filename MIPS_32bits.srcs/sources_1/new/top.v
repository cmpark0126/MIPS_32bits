`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:48:38
// Design Name: 
// Module Name: top
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


module top(
    output [6:0] sseg,
    output DP,
    output [7:0]AN,
    input clk, start_signal,
    input [3:0] mode
    );
    
    // for program execution
    wire rst = ~start_signal;
    
    // for clk division
    wire n_clk;
    
    // for state
    wire [3:0] cs, ns;
    
    // for instruction fetch
    reg [31:0] PC;
    always@(posedge n_clk or posedge rst) begin
        if(rst) PC <= 32'd0;
        else if(cs == 4'd0) PC <= (PC == 32'd4)? 0:PC+4;
        else PC <= PC;
    end // for debug
    wire [31:0] instruction;
    
    // for controller_for_debug
    wire [7:0] mask;
    wire [3:0] data7, data6, data5, data4, data3, data2, data1, data0;
    
    clk_div clk_div0(
       .en_out(n_clk),
       .clk(clk), .rst(rst),
       .divided_by(100000000)
       );
    
    controller_for_state controller_for_state0(
        .cs(cs), .ns(ns),
        .clk(n_clk), .rst(rst)
        );
        
    Instruction_fetch Instruction_fetch0(
        .instruction(instruction),
        .address(PC),
        .cs(cs),
        .clk(n_clk), .rst(rst) 
        );
        
    controller_for_debug controller_for_debug0(
        .mask(mask),
        .data7(data7), .data6(data6), .data5(data5), .data4(data4),
        .data3(data3), .data2(data2), .data1(data1), .data0(data0),
        .mode(mode),
        // state 
        .ns(ns), .cs(cs),
        // instruction_fetch
        .instruction(instruction),
        .clk(clk), .rst(rst)
        );

    ss_drive segment(
      .clk(clk), .rst(rst), .mask(mask),
      .data7(data7), .data6(data6), .data5(data5), .data4(data4),
      .data3(data3), .data2(data2), .data1(data1), .data0(data0),
      .ssA(sseg[0]), .ssB(sseg[1]), .ssC(sseg[2]), .ssD(sseg[3]),
      .ssE(sseg[4]), .ssF(sseg[5]), .ssG(sseg[6]), .ssDP(DP),
      .AN7(AN[7]), .AN6(AN[6]), .AN5(AN[5]), .AN4(AN[4]),
      .AN3(AN[3]), .AN2(AN[2]), .AN1(AN[1]), .AN0(AN[0])
      ); 
endmodule
