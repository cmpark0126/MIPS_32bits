`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:00:00
// Design Name: 
// Module Name: Instruction_decode
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


module Register(
    output reg [31:0] read_data1, read_data2,
    input [4:0] read_reg1, read_reg2, write_reg, 
    input [31:0] write_data,
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
    input [3:0] cs,
    input RegWrite,
    input clk, rst 
    );
    
    parameter ID = 4'd1;
    parameter WB = 4'd4;
    
    reg [31:0] mips_register_set [0:31];
    reg [31:0] temp1, temp2;
    reg [5:0] ii;
    
    always @(posedge clk or posedge rst) begin
            if(rst) begin
                temp1 <= 32'd0;
                temp2 <= 32'd0;
            end
            else if(cs == ID) begin
                temp1 <= mips_register_set[read_reg1];
                temp2 <= mips_register_set[read_reg2];
            end
            else if(cs == WB && RegWrite == 1'b1) begin
                temp1 <= write_data;
                temp2 <= 32'd0;
            end
            else begin 
                temp1 <= temp1;
                temp2 <= temp2;
            end
        end
        
        always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
            // should we use rst to reset all register set
            // I think we should not need reset register set.
            // previous value will be considered garbage value
            if(rst) begin 
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
                for(ii = 6'd0; ii < 6'd32; ii = ii + 6'd1) mips_register_set[ii] <= 32'd0;
            end
            else if(cs == ID) begin
                read_data1 <= temp1;
                read_data2 <= temp2;
                mips_register_set[0] <= 32'd0;
                for(ii = 6'd1; ii < 6'd32; ii = ii + 6'd1) mips_register_set[ii] <= mips_register_set[ii];
            end 
            else if(cs == WB && RegWrite == 1'b1) begin
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
                mips_register_set[0] <= 32'd0;
                for(ii = 6'd1; ii < 6'd32; ii = ii + 6'd1) mips_register_set[ii] <= (write_reg == ii[4:0])? write_data : mips_register_set[ii];
            end
            else begin
                read_data1 <= read_data1;
                read_data2 <= read_data2;
                mips_register_set[0] <= 32'd0;
                for(ii = 6'd1; ii < 6'd32; ii = ii + 6'd1) mips_register_set[ii] <= mips_register_set[ii];
            end
            
        end
    
        
        assign zero = mips_register_set[0];
        assign at = mips_register_set[1];
        assign v0 = mips_register_set[2];
        assign v1 = mips_register_set[3];
        assign a0 = mips_register_set[4];
        assign a1 = mips_register_set[5];
        assign a2 = mips_register_set[6];
        assign a3 = mips_register_set[7];
        assign t0 = mips_register_set[8];
        assign t1 = mips_register_set[9]; 
        assign t2 = mips_register_set[10];
        assign t3 = mips_register_set[11]; 
        assign t4 = mips_register_set[12]; 
        assign t5 = mips_register_set[13]; 
        assign t6 = mips_register_set[14]; 
        assign t7 = mips_register_set[15];
        assign s0 = mips_register_set[16]; 
        assign s1 = mips_register_set[17];
        assign s2 = mips_register_set[18]; 
        assign s3 = mips_register_set[19]; 
        assign s4 = mips_register_set[20]; 
        assign s5 = mips_register_set[21]; 
        assign s6 = mips_register_set[22]; 
        assign s7 = mips_register_set[23];
        assign t8 = mips_register_set[24]; 
        assign t9 = mips_register_set[25];
        assign k0 = mips_register_set[26]; 
        assign k1 = mips_register_set[27];
        assign gp = mips_register_set[28]; 
        assign sp = mips_register_set[29]; 
        assign fp = mips_register_set[30]; 
        assign ra = mips_register_set[31];
    
endmodule
