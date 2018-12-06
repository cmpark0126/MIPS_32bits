`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:59:11
// Design Name: 
// Module Name: datapath
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


module datapath(
   // for debug
   output [7:0] mask,
   output [3:0] data7, data6, data5, data4, data3, data2, data1, data0,
   // for register
   output [31:0] zero,
   output [31:0] at,
   output [31:0] v0, v1,
   output [31:0] a0, a1, a2, a3,
   output [31:0] t0, t1, t2, t3, t4, t5, t6, t7,
   output [31:0] s0, s1, s2, s3, s4, s5, s6, s7,
   output [31:0] t8, t9,
   output [31:0] k0, k1,
   output [31:0] gp, sp, fp, ra,
   // instruction check
   output [31:0] instruction,
   // for state
   output syscall_inst,
   input [31:0] instruction_by_user,
   input [3:0] cs, ns,
   input mode,
   input clk, rst
    );
    
    // for instruction fetch (IF)
    wire [31:0] PCadd4;
    wire [31:0] instruction_by_program;
    
    // for controller_for_mips_opcode
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    wire [1:0] ALUOp;
    wire [31:0] jumped_address;
     
    //for Register (ID, WB)
    wire [31:0] read_data1, read_data2;
    wire [31:0] write_data;
    wire [31:0] extended;
    
    //for Execution
    wire [31:0] branched_address;
    wire [3:0] ALU_operation;
    wire [31:0] ALU_result;
    wire ALU_zero;
    
    // for memory read
    wire [31:0] read_data_from_memory;
    
    IF IF0(
    .instruction(instruction_by_program),
    .PCadd4(PCadd4),
    .ALU_zero(ALU_zero), .Branch(Branch), .Jump(Jump),
    .branched_address(branched_address),
    .jumped_address(jumped_address),
    .cs(cs),
    .clk(clk), .rst(rst)
    );
    
    // select instruction
    assign instruction = (mode == 'd0)? instruction_by_program : instruction_by_user;
        
    ID ID0(
        .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
        .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp), .Jump(Jump),
        .jumped_address(jumped_address),
        .read_data1(read_data1),.read_data2(read_data2),
        .extended(extended),
        .instruction(instruction),
        .write_data(write_data),
        .PCadd4_header(PCadd4[31:28]),
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
        .cs(cs),
        .clk(clk), .rst(rst)
    );
    
    EX EX0(
        .ALU_result(ALU_result),
        .ALU_zero(ALU_zero),
        .ALU_operation(ALU_operation),
        .branched_address(branched_address),
        .syscall_inst(syscall_inst),
        .instruction(instruction),
        .extended(extended),
        .PCadd4(PCadd4),
        .read_data1(read_data1),.read_data2(read_data2),
        .ALUSrc(ALUSrc), .ALUOp(ALUOp),
        .v0(v0),
        .cs(cs),
        .clk(clk), .rst(rst)
    );
        
    MEM MEM0(
        .read_data_from_memory(read_data_from_memory),
        .address_for_memory(ALU_result),
        .write_data_for_memory(read_data2),
        .MemRead(MemRead), .MemWrite(MemWrite),
        .cs(cs),
        .clk(clk), .rst(rst)
        );
    
    WB WB0(
        .write_data(write_data),
        .ALU_result(ALU_result),.read_data_from_memory(read_data_from_memory),
        .MemtoReg(MemtoReg),
        .cs(cs),
        .clk(clk), .rst(rst)
        );
        
endmodule
