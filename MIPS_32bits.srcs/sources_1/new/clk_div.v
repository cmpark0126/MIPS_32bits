`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 20:12:02
// Design Name: 
// Module Name: clk_div
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


module clk_div( 
    output reg en_out,
    input clk, rst,
    input [31:0] divided_by
    );
	 
    reg [31:0] cnt;

    always @(posedge clk or posedge rst)
        if(rst)
            begin
            cnt <= 4'd0;
            en_out <= 1'b0;
            end
        else if (cnt < divided_by)
            begin
            cnt <= cnt + 1;
            en_out <= en_out;
            end
        else 
            begin
            cnt <= 4'd0;
            en_out <= en_out + 1;
    end

endmodule
