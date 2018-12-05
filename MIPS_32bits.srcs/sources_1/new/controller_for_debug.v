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
    input mode,
    // instruction_fetch (0)
    input [31:0] instruction,
    // interpreter input (1)
    input [31:0] instruction_by_user,
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
                4'd0 : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction;
                    end
                4'd1 : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction_by_user;
                    end
                default : begin
                    mask = 8'b0000_0000;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = 32'd0;
                    end
            endcase
        end
    end
    
endmodule
