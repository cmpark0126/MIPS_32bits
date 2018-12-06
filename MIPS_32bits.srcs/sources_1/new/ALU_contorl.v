`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/02 16:08:13
// Design Name: 
// Module Name: ALU_contorl
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


module ALU_contorl(
    output reg [3:0] ALU_operation,
    output reg syscall_inst,
    input [5:0] Function_field,
    input [1:0] ALUOp,
    input [31:0] v0
    );
    
    parameter AND = 4'b0000;
    parameter OR = 4'b0001;
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter SET_ON_LESS_THAN = 4'b0111;
    parameter NOR = 4'b1100;
    parameter UNKNOWN = 4'b1111;
    
    always @ * begin
        ALU_operation = UNKNOWN;
        syscall_inst = 'b0;
        
        casex(ALUOp)
            2'b00: ALU_operation = ADD;
            2'bx1: ALU_operation = SUB;
            2'b1x: begin
                casex(Function_field)
                   6'bxx0000: ALU_operation = ADD;
                   6'bxx0010: ALU_operation = SUB;
                   6'bxx0100: ALU_operation = AND;
                   6'bxx0101: ALU_operation = OR;
                   6'bxx1010: ALU_operation = SET_ON_LESS_THAN;
                   6'b001100: begin syscall_inst = (v0 == 'd10)? 'b1 : 'b0; end
                   default: ALU_operation = UNKNOWN;
                endcase
            end
            default: ALU_operation = UNKNOWN;
        endcase
    end
    
endmodule
