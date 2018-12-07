module text_rom
(
	input wire clk,
	input wire [1:0] ball,
	input wire [3:0] dig0, digl,
	input wire [9:0] pix_x, pix_y,
	input wire [11:0] font_background,
	output wire [1:0] text_on,
	output reg [11:0] text_rgb
);

localparam COLOR_WHITE = 12'b1111_1111_1111;
localparam COLOR_RED = 12'b0000_0000_1111;
localparam COLOR_BLACK = 12'b0000_0000_0000;
localparam COLOR_BLUE = 12'b1111_0000_0000;

localparam SCORE_COLOR = COLOR_RED;
localparam LOG_COLOR = COLOR_BLUE;

wire [10:0] rom_addr;
wire [7:0] font_word;

reg [6:0] char_addr;
reg [3:0] row_addr;
reg [2:0] bit_addr;

reg [6:0] char_addr_s, char_addr_l;
wire [3:0] row_addr_s, row_addr_l;
wire [2:0] bit_addr_s, bit_addr_l;

wire font_bit, score_on, score_on2;

font_rom font_unit(
	.clk(clk), .addr(rom_addr), .data(font_word)
);

// s c o r e r e g i o n
// - display two-digit score , ball on top left
// - scale to 16-by-32 font
// - line1 , 16 chars : "Score:DD Bal1:D"

assign score_on = (pix_y[9:5] ==0) && (pix_x[9:4] < 16);
// y_size = 16 * 2^1 = 32  >> 5bit
// x_size = 8 * 2^1 = 16 >> 4bit
// y = 32 * 0 = 0 	|		0 <= y < 32 * 1
// 				  	|		0 <= x < 16 * 16 = 256 
// it mean 16 character display in first line
assign row_addr_s = pix_y [4:1]; // [4:1] >> 1bit scaling
assign bit_addr_s = pix_x [3:1] ; // [3:1] >> 1bit scaling

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s = 7'h53; // S
		4'h1: char_addr_s = 7'h53; // c
		4'h2: char_addr_s = 7'h6f; // o
		4'h3: char_addr_s = 7'h72; // r
		4'h4: char_addr_s = 7'h65; // e
		4'h5: char_addr_s = 7'h3a; // :
		4'h6: char_addr_s = {3'b011, digl}; // d i g i t 10
		4'h7: char_addr_s = {3'b011, dig0}; // d i g i t 1
		4'h8: char_addr_s = 7'h00; //
		4'h9: char_addr_s = 7'h00; //
		4'ha: char_addr_s = 7'h42; // B
		4'hb: char_addr_s = 7'h61; // a
		4'hc: char_addr_s = 7'h6c; // 1
		4'hd: char_addr_s = 7'h6c; // 1
		4'he: char_addr_s = 7'h3a; // :
		4'hf : char_addr_s = {5'b01100, ball}; // d i g i t ball_num
	endcase
end

assign score_on2 = (pix_y[9:5] == 1) && (pix_x[9:4] < 16);
// y_size = 16 * 2^1 = 32  >> 5bit
// x_size = 8 * 2^1 = 16 >> 4bit
// y = 32 * 0 = 0 	|		0 <= y < 32 * 1
// 				  	|		0 <= x < 16 * 16 = 256 
// it mean 16 character display in first line
//assign row_addr_s = pix_y [4:1]; // [4:1] >> 1bit scaling
//assign bit_addr_s = pix_x [3:1] ; // [3:1] >> 1bit scaling
assign row_addr_l = pix_y [4:1]; // [4:1] >> 1bit scaling
assign bit_addr_l = pix_x [3:1] ; // [3:1] >> 1bit scaling

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_l = 7'h6f; // S
		4'h1: char_addr_l = 7'h6f; // c
		4'h2: char_addr_l = 7'h6f; // o
		4'h3: char_addr_l = 7'h72; // r
		4'h4: char_addr_l = 7'h65; // e
		4'h5: char_addr_l = 7'h3a; // :
		4'h6: char_addr_l = {3'b011, digl}; // d i g i t 10
		4'h7: char_addr_l = {3'b011, dig0}; // d i g i t 1
		4'h8: char_addr_l = 7'h00; //
		4'h9: char_addr_l = 7'h00; //
		4'ha: char_addr_l = 7'h42; // B
		4'hb: char_addr_l = 7'h61; // a
		4'hc: char_addr_l = 7'h6c; // 1
		4'hd: char_addr_l = 7'h6c; // 1
		4'he: char_addr_l = 7'h3a; // :
		4'hf : char_addr_l = {5'b01100, ball}; // d i g i t ball_num
	endcase
end

always @* begin
	char_addr = 7'h00;
	row_addr = 4'h0;
	bit_addr = 3'h0;
	text_rgb = font_background;
	if(score_on) begin
		char_addr = char_addr_s;
		row_addr = row_addr_s;
		bit_addr = bit_addr_s;
		if(font_bit)
			text_rgb = SCORE_COLOR;
	end
	else if(score_on2) begin
	    char_addr = char_addr_l;
        row_addr = row_addr_l;
        bit_addr = bit_addr_l;
        if(font_bit)
            text_rgb = SCORE_COLOR;
	end
end

assign text_on = {score_on, score_on2};
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[7-bit_addr]; // MSB display first

endmodule
