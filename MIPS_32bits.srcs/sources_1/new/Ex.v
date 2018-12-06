`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:06:19
// Design Name: 
// Module Name: Execution
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


module EX(
    output [31:0] ALU_result,
    output ALU_zero,
    output [3:0] ALU_operation,
    output [31:0] branched_address,
    output syscall_inst,
    input [31:0] instruction,
    input [31:0] extended,
    input [31:0] PCadd4,
    input [31:0] read_data1, read_data2,
    input ALUSrc, 
    input [1:0] ALUOp,
    input [31:0] v0,
    input [3:0] cs,
    input clk, rst 
    );
    
    wire [31:0] shifted;
    wire [31:0] selected_data;

    Shift_register_left_2bits Shift_register_left_2bits0(
        .out(shifted),
        .in(extended)
    );
    
    Mux_32bits select_data(
        .out(selected_data),
        .in0(read_data2),.in1(extended),
        .sel(ALUSrc)
        );
    
    Add_32bits add_pc_and_shifted(
        .out(branched_address),
        .in0(PCadd4),.in1(shifted),
        .cs(cs),
        .clk(clk), .rst(rst)
        );
    
    ALU_contorl ALU_contorl0(
        .ALU_operation(ALU_operation),
        .syscall_inst(syscall_inst),
        .Function_field(instruction[5:0]),
        .ALUOp(ALUOp),
        .v0(v0)
        );
    
    ALU ALU0(
        .ALU_result(ALU_result),
        .ALU_zero(ALU_zero),
        .in0(read_data1),.in1(selected_data),
        .ALU_operation(ALU_operation),
        .cs(cs),
        .clk(clk), .rst(rst)
        );

endmodule
