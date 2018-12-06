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
    input ALU_zero, Branch, Jump,
    input [31:0] branched_address,
    input [31:0] jumped_address,
    input [3:0] cs,
    input clk, rst 
    );
    
    wire [31:0] PC_Before, PC; 
    wire PC_selector;
    
    assign PC_selector = ALU_zero & Branch;

    Mux_32bits select_pc_before(
        .out(PC_Before),
        .in0(PCadd4),.in1(branched_address),
        .sel(PC_selector) // it will be branch, ALU-zero (and gate)
        );
        
    Mux_32bits select_next_pc(
        .out(PC),
        .in0(PC_Before),.in1(jumped_address),
        .sel(Jump) //
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
