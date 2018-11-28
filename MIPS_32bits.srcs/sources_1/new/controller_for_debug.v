`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 22:19:42
// Design Name: 
// Module Name: controller_for_debug
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


module controller_for_debug(
    output reg [7:0] mask,
    output reg [3:0] data7, data6, data5, data4, data3, data2, data1, data0,
    input [3:0] mode,
    // state (0)
    input [3:0] ns, cs,
    // instruction_fetch (1)
    input [31:0] instruction,
    // controller_for_mips_opcode (2)
    input RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
    input [1:0] ALUOp,
    // Register1 (3)
    input [4:0] write_reg,
    // clk and rst
    input clk, rst
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            mask = 8'b0000_0000;
            {data7, data6, data5, data4, data3, data2, data1, data0} = 32'd0;
        end
        else begin
            case(mode)
                4'd0: begin
                    mask = 8'b0000_0011;
                    data1 = ns;
                    data0 = cs;
                    end
                4'd1 : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction;
                    end
                4'd2 : begin
                    mask = 8'b1111_1111;
                    data7 = {3'b000, RegDst};
                    data6 = {3'b000, ALUSrc};
                    data5 = {3'b000, MemtoReg};
                    data4 = {3'b000, RegWrite};
                    data3 = {3'b000, MemRead};
                    data2 = {3'b000, MemWrite};
                    data1 = {3'b000, Branch};
                    data0 = {2'b00, ALUOp};
                    end
                4'd3 : begin
                    mask = 8'b1111_1111;
                    {data7, data6} = {3'b000, instruction[25:21]};
                    {data5, data4} = {3'b000, instruction[20:16]};
                    {data3, data2} = {3'b000, instruction[15:11]};
                    {data1, data0} = {3'b000, write_reg};
                    end
                default : begin
                    mask = 8'b0000_0000;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = 32'd0;
                    end
            endcase
        end
    end
    
endmodule
