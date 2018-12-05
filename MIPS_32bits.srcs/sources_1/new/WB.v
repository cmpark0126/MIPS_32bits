`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 12:46:55
// Design Name: 
// Module Name: WB
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


module WB(
    output [31:0] write_data,
    input [31:0] ALU_result,
    input [31:0] read_data_from_memory,
    input MemtoReg,
    input [3:0] cs, // not used
    input clk, rst // not used
    );
    
    Mux_32bits select_write_data(
        .out(write_data),
        .in0(ALU_result),.in1(read_data_from_memory),
        .sel(MemtoReg)
        );
    
endmodule
