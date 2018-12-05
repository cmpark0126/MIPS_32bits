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
    output [7:0] AN,
    output Released,
    input ps2clk,
    input ps2data,
    input mode,
    input clk, rst
    );
    
    // for clk division
    wire clk_50;
    wire clk_100;
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
    reg [31:0] instruction_by_user;
    
    // for controller_for_debug
    wire [7:0] mask;
    wire [3:0] data7, data6, data5, data4, data3, data2, data1, data0;
    
    // for keyboard input
    wire [7:0] scancode;
    wire err_ind;
    wire shift_done;
    
    clk_wiz_0 clk_core(
      // Clock in ports
       .clk_in1(clk),      // input clk_in1
       // Clock out ports
       .clk_out1(clk_100),     // output clk_out1
       .clk_out2(clk_50),     // output clk_out2
       // Status and control signals
       .reset(rst), // input reset
       .locked()
       );      // output locked
    
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
    
    // keyboard input
    ps2_kbd_top ps2_kbd (
        .clk(clk_50), 
        .rst(rst), 
        .ps2clk(ps2clk), 
        .ps2data(ps2data), 
        .scancode(scancode), 
        .Released(Released), 
        .err_ind(err_ind)
        );
    
    
    always@(negedge Released) begin
        if(scancode == 'h41 || scancode == 'h61) // 'A' or 'a'
            instruction_by_user <= {instruction_by_user[27:0], 4'hA};
        else if(scancode == 'h42 || scancode == 'h62) // 'B' or 'b'
            instruction_by_user <= {instruction_by_user[27:0], 4'hB};
        else if(scancode == 'h43 || scancode == 'h63) // 'C' or 'c'
            instruction_by_user <= {instruction_by_user[27:0], 4'hC};
        else if(scancode == 'h44 || scancode == 'h64) // 'D' or 'd'
            instruction_by_user <= {instruction_by_user[27:0], 4'hD};
        else if(scancode == 'h45 || scancode == 'h65) // 'E' or 'e'
            instruction_by_user <= {instruction_by_user[27:0], 4'hE};
        else if(scancode == 'h46 || scancode == 'h66) // 'F' or 'f'
            instruction_by_user <= {instruction_by_user[27:0], 4'hF};
        else if(scancode == 'h08) // BACKSPACE
            instruction_by_user <= {4'b0000, instruction_by_user[31:4]};
        else
            instruction_by_user <= instruction_by_user;
    end
    
    // sseg for Debug
    controller_for_debug controller_for_debug0(
        .mask(mask),
        .data7(data7), .data6(data6), .data5(data5), .data4(data4),
        .data3(data3), .data2(data2), .data1(data1), .data0(data0),
        .mode(mode),
        // instruction_fetch (0)
        .instruction(instruction),
        // interpreter input (1)
        .instruction_by_user(instruction_by_user),
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
