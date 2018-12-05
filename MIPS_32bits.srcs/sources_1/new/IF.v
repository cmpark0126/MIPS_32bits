`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 11:14:03
// Design Name: 
// Module Name: IF
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


module IF(
    output [31:0] instruction,
    output [31:0] PCadd4,
    input ALU_zero, Branch,
    input [31:0] branched_address,
    input [3:0] cs,
    input clk, rst 
    );
    
    wire [31:0] PC; 
    wire PC_selector;
    
    assign PC_selector = ALU_zero & Branch;

    Mux_32bits select_next_pc(
        .out(PC),
        .in0(PCadd4),.in1(branched_address),
        .sel(PC_selector) // it will be branch, ALU-zero (and gate)
        );
    
    Instruction_fetch Instruction_fetch0(
        .instruction(instruction),
        .address(PC),
        .cs(cs),
        .clk(clk), .rst(rst)
        );
    
    Add4toPC Add4toPC0(
        .outPC(PCadd4),
        .inPC(PC),
        .cs(cs),
        .clk(clk), .rst(rst)
        );
    
endmodule
