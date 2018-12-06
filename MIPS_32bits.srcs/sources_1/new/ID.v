`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/05 11:45:01
// Design Name: 
// Module Name: ID
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


module ID(
    output RegDst,
    output ALUSrc,
    output MemtoReg,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output Branch,
    output [1:0] ALUOp,
    output Jump,
    output [31:0] jumped_address,
    output [31:0] read_data1, read_data2,
    output [31:0] extended,
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
    input [31:0] instruction,
    input [31:0] write_data,
    input [3:0] PCadd4_header,
    input [3:0] cs,
    input clk, rst 
    );
    
    wire [4:0] write_reg;
    
    controller_for_mips_opcode controller_for_mips_opcode0(
            .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
            .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp), .JUMP(Jump),
            .opcode(instruction[31:26])
            );
            
        Mux_5bits select_next_write_register(
            .out(write_reg),
            .in0(instruction[20:16]),.in1(instruction[15:11]),
            .sel(RegDst)
            );
            
        Register Register0( // ID & WB
            .read_data1(read_data1),.read_data2(read_data2),
            .read_reg1(instruction[25:21]),.read_reg2(instruction[20:16]), 
            .write_reg(write_reg), .write_data(write_data),
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
            .RegWrite(RegWrite),
            .clk(clk),.rst(rst)
            );
        
        Sign_extend_16to32bits Sign_extend_16to32bits0(
            .out(extended),
            .in(instruction[15:0])
            );
        
        Calculate_jumped_address Calculate_jumped_address0(
            .jumped_address(jumped_address),
            .value_from_instruction(instruction[25:0]),
            .PCadd4_header(PCadd4_header)
        );
       
endmodule
