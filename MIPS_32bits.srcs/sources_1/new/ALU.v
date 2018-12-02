`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/02 16:59:59
// Design Name: 
// Module Name: ALU
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


module ALU(
    output reg [31:0] ALU_result,
    output reg ALU_zero,
    input [31:0] in0, in1,
    input [3:0] ALU_operation,
    input [3:0] cs,
    input clk, rst 
    );
    
    parameter EX  = 4'd2;
    
    parameter AND = 4'b0000;
    parameter OR = 4'b0001;
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter SET_ON_LESS_THAN = 4'b0111;
    parameter NOR = 4'b1100;
    parameter UNKNOWN = 4'b1111;
    
    reg [31:0] temp;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            temp <= 0;
        end
        else if(cs == EX)
            case(ALU_operation)
                ADD: temp <= (in0 + in1);
                SUB: temp <= (in0 - in1);
                default: temp <= 0;
            endcase
        else 
            temp <= temp;
    end
    
    always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
        if(rst) begin 
            ALU_result <= 0;
            ALU_zero <= 0; // it means ALU_zero is not zero
        end
        else if(cs == EX) 
            case(ALU_operation)
                ADD: begin 
                    ALU_result <= temp; 
                    ALU_zero <= 0; 
                    end
                SUB: begin 
                    ALU_result <= temp; 
                    ALU_zero <= (temp == 32'd0)? 1:0; 
                    end
                default: begin
                    ALU_result <= 0;
                    ALU_zero <= 0;
                end
            endcase
        else begin
            ALU_result <= ALU_result;
            ALU_zero <= ALU_zero;
        end
    end
    
endmodule
