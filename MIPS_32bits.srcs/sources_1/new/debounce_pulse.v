`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:16 01/16/2011 
// Design Name: 
// Module Name:    debounce_pulse 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debounce_pulse(
    input wire clk,
    input wire rst,
    input wire Din,
    output wire Dout
    );
	 wire A;
	 reg B,C;
	 integer cnt;
	 
	 assign A = Din;
	 
	 always @(posedge clk)
		if(rst==1) begin
			B <= 0;
			C <= 0;
		end
		else begin
			B <= A;
			C <= B;
		end
		
		assign Dout = (~C & B);



endmodule
