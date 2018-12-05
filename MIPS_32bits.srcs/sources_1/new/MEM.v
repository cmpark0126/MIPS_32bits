`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 12:32:05
// Design Name: 
// Module Name: MEM
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


module MEM(
    output [31:0] read_data_from_memory,
    input [31:0] address_for_memory,
    input [31:0] write_data_for_memory,
    input MemRead, MemWrite,
    input [3:0] cs,
    input clk, rst 
    );
    
    Memory_access Memory_access0(
        .read_data_from_memory(read_data_from_memory),
        .address_for_memory(address_for_memory),
        .write_data_for_memory(write_data_for_memory),
        .cs(cs),
        .MemRead(MemRead), .MemWrite(MemWrite),
        .clk(clk), .rst(rst)
        );
        
endmodule
