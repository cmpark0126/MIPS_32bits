`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/29 00:18:59
// Design Name: 
// Module Name: controller_for_mips_opcode
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


module controller_for_mips_opcode( // combinational logic circuit. so do not need clk
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg [1:0] ALUOp,
    input [5:0] opcode
    );
    
    // temparary parameter
    parameter [5:0] R_format    = 6'b000000;
    parameter [5:0] lw          = 6'b100011;
    parameter [5:0] sw          = 6'b101011;
    parameter [5:0] beq         = 6'b000100;
    
    always @ * begin
        case(opcode)
            R_format: begin
                RegDst   = 1'b1;
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp[1] = 1'b1; 
                ALUOp[0] = 1'b0; end
            lw: begin
                RegDst   = 1'b0;
                ALUSrc   = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp[1] = 1'b0; 
                ALUOp[0] = 1'b0; end
            sw: begin
                RegDst   = RegDst;
                ALUSrc   = 1'b1;
                MemtoReg = MemtoReg;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b1;
                Branch   = 1'b0;
                ALUOp[1] = 1'b0; 
                ALUOp[0] = 1'b0; end
            beq: begin       
                RegDst   = RegDst;
                ALUSrc   = 1'b0;
                MemtoReg = MemtoReg;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b1;
                ALUOp[1] = 1'b0; 
                ALUOp[0] = 1'b1; end
            default: begin       
                RegDst   = 1'b0;
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp[1] = 1'b0; 
                ALUOp[0] = 1'b0; end
        endcase
    end
    
endmodule
