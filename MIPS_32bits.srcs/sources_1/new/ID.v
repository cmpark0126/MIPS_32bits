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
    output [31:0] read_data1, read_data2,
    output [31:0] extended,
    input [31:0] instruction,
    input [31:0] write_data,
    input [3:0] cs,
    input clk, rst 
    );
    
    wire [4:0] write_reg;
    
    controller_for_mips_opcode controller_for_mips_opcode0(
            .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
            .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp),
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
            .cs(cs),
            .RegWrite(RegWrite),
            .clk(clk),.rst(rst)
            );
        
        Sign_extend_16to32bits Sign_extend_16to32bits0(
            .out(extended),
            .in(instruction[15:0])
        );
endmodule
