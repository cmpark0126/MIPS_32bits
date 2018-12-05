`timescale 1ns / 1ps

module ps2_kbd_top(
    input clk,
    input rst,
    input ps2clk,
    input ps2data,
    output [7:0] scancode,
    output Released,
    output err_ind
    );

wire req, released_out;
reg ack;

ps2_kbd_new ps2 (
    .clk(clk), 
    .rst(rst), 
    .ps2_clk(ps2clk), 
    .ps2_data(ps2data), 
    .scancode(scancode), 
    .read(ack), 
    .data_ready(req), 
    .released(released_out), 
    .err_ind(err_ind)
    ); 
debounce_pulse pulse (
    .clk(clk), 
    .rst(rst), 
    .Din(released_out), 
    .Dout(Released)
    );

always @(posedge clk, posedge rst)
	begin
		if(rst == 1'b1)
			ack <= 1'b0;
		else if(req == 1'b1)
			ack <= 1'b1;
		else
			ack <= 1'b0;
	end
endmodule
