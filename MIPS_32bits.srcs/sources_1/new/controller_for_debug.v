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
    input [1:0] mode,
    // instruction_fetch (0)
    input [31:0] instruction,
    // interpreter input (1)
    input [31:0] instruction_by_user,
    // register set monitor(2)
    input [4:0] register_number,
    input [31:0] zero,
    input [31:0] at,
    input [31:0] v0, v1,
    input [31:0] a0, a1, a2, a3,
    input [31:0] t0, t1, t2, t3, t4, t5, t6, t7,
    input [31:0] s0, s1, s2, s3, s4, s5, s6, s7,
    input [31:0] t8, t9,
    input [31:0] k0, k1,
    input [31:0] gp, sp, fp, ra,
    // clk and rst
    input clk, rst
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            mask = 8'b1111_1111;
            {data7, data6, data5, data4, data3, data2, data1, data0} = 32'd0;
        end
        else begin
            case(mode)
                2'd0 : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction;
                    end
                2'd1 : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction_by_user;
                    end
                2'd2 : begin
                    case(register_number)
                        5'd0 : {data7, data6, data5, data4, data3, data2, data1, data0} = zero;
                        5'd1 : {data7, data6, data5, data4, data3, data2, data1, data0} = at;
                        5'd2 : {data7, data6, data5, data4, data3, data2, data1, data0} = v0;
                        5'd3 : {data7, data6, data5, data4, data3, data2, data1, data0} = v1;
                        5'd4 : {data7, data6, data5, data4, data3, data2, data1, data0} = a0;
                        5'd5 : {data7, data6, data5, data4, data3, data2, data1, data0} = a1;
                        5'd6 : {data7, data6, data5, data4, data3, data2, data1, data0} = a2;
                        5'd7 : {data7, data6, data5, data4, data3, data2, data1, data0} = a3;
                        5'd8 : {data7, data6, data5, data4, data3, data2, data1, data0} = t0;
                        5'd9 : {data7, data6, data5, data4, data3, data2, data1, data0} = t1;
                        5'd10 : {data7, data6, data5, data4, data3, data2, data1, data0} = t2;
                        5'd11 : {data7, data6, data5, data4, data3, data2, data1, data0} = t3;
                        5'd12 : {data7, data6, data5, data4, data3, data2, data1, data0} = t4;
                        5'd13 : {data7, data6, data5, data4, data3, data2, data1, data0} = t5;
                        5'd14 : {data7, data6, data5, data4, data3, data2, data1, data0} = t6;
                        5'd15 : {data7, data6, data5, data4, data3, data2, data1, data0} = t7;
                        5'd16 : {data7, data6, data5, data4, data3, data2, data1, data0} = s0;
                        5'd17 : {data7, data6, data5, data4, data3, data2, data1, data0} = s1; 
                        5'd18 : {data7, data6, data5, data4, data3, data2, data1, data0} = s2;
                        5'd19 : {data7, data6, data5, data4, data3, data2, data1, data0} = s3;
                        5'd20 : {data7, data6, data5, data4, data3, data2, data1, data0} = s4;
                        5'd21 : {data7, data6, data5, data4, data3, data2, data1, data0} = s5;
                        5'd22 : {data7, data6, data5, data4, data3, data2, data1, data0} = s6;
                        5'd23 : {data7, data6, data5, data4, data3, data2, data1, data0} = s7;
                        5'd24 : {data7, data6, data5, data4, data3, data2, data1, data0} = t8;
                        5'd25 : {data7, data6, data5, data4, data3, data2, data1, data0} = t9;
                        5'd26 : {data7, data6, data5, data4, data3, data2, data1, data0} = k0;
                        5'd27 : {data7, data6, data5, data4, data3, data2, data1, data0} = k1;
                        5'd28 : {data7, data6, data5, data4, data3, data2, data1, data0} = gp;
                        5'd29 : {data7, data6, data5, data4, data3, data2, data1, data0} = sp;                
                        5'd30 : {data7, data6, data5, data4, data3, data2, data1, data0} = fp;
                        5'd31 : {data7, data6, data5, data4, data3, data2, data1, data0} = ra;                                                                                                       
                    endcase
                    end
                default : begin
                    mask = 8'b0000_0000;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = 32'd0;
                    end
            endcase
        end
    end
    
endmodule
