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

`define DIVISOR 10000000

module top(
    output [6:0] sseg,
    output DP,
    output [7:0]AN,
    input clk, rst,
    input mode
    );
    
    // for clk division
    wire n_clk;
    
    // for state
    wire [3:0] cs, ns;
    
    // for register name
    wire [31:0] zero;
    wire [31:0] at;
    wire [31:0] v0, v1;
    wire [31:0] a0, a1, a2, a3;
    wire [31:0] t0, t1, t2, t3, t4, t5, t6, t7;
    wire [31:0] s0, s1, s2, s3, s4, s5, s6, s7;
    wire [31:0] t8, t9;
    wire [31:0] k0, k1;
    wire [31:0] gp, sp, fp, ra;
    
    // for instruction
    wire [31:0] instruction;
    wire [31:0] instruction_by_user;
    
    // for controller_for_debug
    wire [7:0] mask;
    wire [3:0] data7, data6, data5, data4, data3, data2, data1, data0;
    
    clk_div clk_div0(
       .en_out(n_clk),
       .clk(clk), .rst(rst),
       .divided_by(`DIVISOR)
       );
    
    controller_for_state controller_for_state0(
        .cs(cs), .ns(ns),
        .clk(n_clk), .rst(rst)
        );
        
    datapath datapath0(
      .mask(mask),
      .data7(data7), .data6(data6), .data5(data5), .data4(data4),
      .data3(data3), .data2(data2), .data1(data1), .data0(data0),
      .zero(zero),
      .at(at),
      .v0(v0), .v1(v1), 
      .a0(a0), .a1(a1), .a2(a2), .a3(a3),
      .t0(t0), .t1(t1), .t2(t2), .t3(t3),
      .t4(t4), .t5(t5), .t6(t6), .t7(t7),
      .s0(s0), .s1(s1), .s2(s2), .s3(s3),
      .s4(s4), .s5(s5), .s6(s6), .s7(s7),
      .t8(t8), .t9(t9), 
      .k0(k0), .k1(k1), 
      .gp(gp), .sp(sp), .fp(fp), .ra(ra),
      .instruction(instruction),
      .instruction_by_user(instruction_by_user),
      .cs(cs), .ns(ns),
      .mode(mode),
      .clk(n_clk), .rst(rst)
    );
    
    // sseg for Debug
    controller_for_debug controller_for_debug0(
        .mask(mask),
        .data7(data7), .data6(data6), .data5(data5), .data4(data4),
        .data3(data3), .data2(data2), .data1(data1), .data0(data0),
        .mode(mode),
        // instruction_fetch (0)
        .instruction(instruction),
        // clk and rst
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
