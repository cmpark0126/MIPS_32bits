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
    // state 
    input [3:0] ns, cs,
    // instruction_fetch
    input [31:0] instruction,
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
                default : begin
                    mask = 8'b1111_1111;
                    {data7, data6, data5, data4, data3, data2, data1, data0} = instruction;
    //                data7 = instruction[31:28];
    //                data6 = instruction[27:24];
    //                data5 = instruction[23:20];
    //                data4 = instruction[19:16];
    //                data3 = instruction[15:12];
    //                data2 = instruction[11:8];
    //                data1 = instruction[7:4];
    //                data0 = instruction[3:0];
                    end
            endcase
        end
    end
    
endmodule
