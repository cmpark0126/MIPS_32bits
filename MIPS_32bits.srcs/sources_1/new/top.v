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
    input clk, rst
    );
    
    wire [3:0] st;
    
    assign st = 4'd5;
    
    ss_drive segment (
      .clk(clk), .rst(rst), .mask(8'b0000_0001), 
      .data7(), .data6(), .data5(), .data4(),
      .data3(), .data2(), .data1(), .data0(st),
      .ssA(sseg[0]), .ssB(sseg[1]), .ssC(sseg[2]), .ssD(sseg[3]), 
      .ssE(sseg[4]), .ssF(sseg[5]), .ssG(sseg[6]), .ssDP(DP),
      .AN7(AN[7]), .AN6(AN[6]), .AN5(AN[5]), .AN4(AN[4]),
      .AN3(AN[3]), .AN2(AN[2]), .AN1(AN[1]), .AN0(AN[0])
      ); 
endmodule
