module text_rom
(
	input wire clk,
	input wire [1:0] ball,
	input wire [3:0] dig0, digl,
	input wire [9:0] pix_x, pix_y,
	input wire [11:0] font_background,
	output wire [1:0] text_on,
	output reg [11:0] text_rgb,
	// for register
    input [31:0] zero,
    input [31:0] at,
    input [31:0] v0, v1,
    input [31:0] a0, a1, a2, a3,
    input [31:0] t0, t1, t2, t3, t4, t5, t6, t7,
    input [31:0] s0, s1, s2, s3, s4, s5, s6, s7,
    input [31:0] t8, t9,
    input [31:0] k0, k1,
    input [31:0] gp, sp, fp, ra
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

reg [6:0] char_addr_s [0:31];
wire [3:0] row_addr_s [0:31];
wire [2:0] bit_addr_s [0:31];

wire font_bit; 
wire [31:0] score_on;

font_rom font_unit(
	.clk(clk), .addr(rom_addr), .data(font_word)
);

// line 0
assign score_on[0] = (pix_y[9:5] == 0) && (pix_x[9:4] < 16);
assign row_addr_s[0] = pix_y [4:1]; 
assign bit_addr_s[0] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[0] = 7'h24; // $ 
		4'h1: char_addr_s[0] = 7'h30; // 
		4'h2: char_addr_s[0] = 7'h00; // 
		4'h3: char_addr_s[0] = 7'h3a; // :
		4'h4: char_addr_s[0] = 7'h00; // 
		4'h5: char_addr_s[0] = 7'h30; // 0
		4'h6: char_addr_s[0] = 7'h58; // x
		4'h7: char_addr_s[0] = 7'h30; // var
		4'h8: char_addr_s[0] = 7'h30; // var
		4'h9: char_addr_s[0] = 7'h30; // var
		4'ha: char_addr_s[0] = 7'h30; // var
		4'hb: char_addr_s[0] = 7'h30; // var
		4'hc: char_addr_s[0] = 7'h30; // var
		4'hd: char_addr_s[0] = 7'h30; // var
		4'he: char_addr_s[0] = 7'h30; // var
		4'hf : char_addr_s[0] = 7'h00; // 
	endcase
end

// line 1
assign score_on[1] = (pix_y[9:5] == 1) && (pix_x[9:4] < 16);
assign row_addr_s[1] = pix_y [4:1]; 
assign bit_addr_s[1] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[1] = 7'h24; // $ 
		4'h1: char_addr_s[1] = 7'h61; // 
		4'h2: char_addr_s[1] = 7'h74; // 
		4'h3: char_addr_s[1] = 7'h3a; // :
		4'h4: char_addr_s[1] = 7'h00; // 
		4'h5: char_addr_s[1] = 7'h30; // 0
		4'h6: char_addr_s[1] = 7'h58; // x
		4'h7: char_addr_s[1] = 7'h30; // var
		4'h8: char_addr_s[1] = 7'h30; // var
		4'h9: char_addr_s[1] = 7'h30; // var
		4'ha: char_addr_s[1] = 7'h30; // var
		4'hb: char_addr_s[1] = 7'h30; // var
		4'hc: char_addr_s[1] = 7'h30; // var
		4'hd: char_addr_s[1] = 7'h30; // var
		4'he: char_addr_s[1] = 7'h30; // var
		4'hf : char_addr_s[1] = 7'h00; // 
	endcase
end

// line 2
assign score_on[2] = (pix_y[9:5] == 2) && (pix_x[9:4] < 16);
assign row_addr_s[2] = pix_y [4:1]; 
assign bit_addr_s[2] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[2] = 7'h24; // $ 
		4'h1: char_addr_s[2] = 7'h76; // 
		4'h2: char_addr_s[2] = 7'h30; // 
		4'h3: char_addr_s[2] = 7'h3a; // :
		4'h4: char_addr_s[2] = 7'h00; // 
		4'h5: char_addr_s[2] = 7'h30; // 0
		4'h6: char_addr_s[2] = 7'h58; // x
		4'h7: char_addr_s[2] = 7'h30; // var
		4'h8: char_addr_s[2] = 7'h30; // var
		4'h9: char_addr_s[2] = 7'h30; // var
		4'ha: char_addr_s[2] = 7'h30; // var
		4'hb: char_addr_s[2] = 7'h30; // var
		4'hc: char_addr_s[2] = 7'h30; // var
		4'hd: char_addr_s[2] = 7'h30; // var
		4'he: char_addr_s[2] = 7'h30; // var
		4'hf : char_addr_s[2] = 7'h00; // 
	endcase
end

// line 3
assign score_on[3] = (pix_y[9:5] == 3) && (pix_x[9:4] < 16);
assign row_addr_s[3] = pix_y [4:1]; 
assign bit_addr_s[3] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[3] = 7'h24; // $ 
		4'h1: char_addr_s[3] = 7'h76; // 
		4'h2: char_addr_s[3] = 7'h31; // 
		4'h3: char_addr_s[3] = 7'h3a; // :
		4'h4: char_addr_s[3] = 7'h00; // 
		4'h5: char_addr_s[3] = 7'h30; // 0
		4'h6: char_addr_s[3] = 7'h58; // x
		4'h7: char_addr_s[3] = 7'h30; // var
		4'h8: char_addr_s[3] = 7'h30; // var
		4'h9: char_addr_s[3] = 7'h30; // var
		4'ha: char_addr_s[3] = 7'h30; // var
		4'hb: char_addr_s[3] = 7'h30; // var
		4'hc: char_addr_s[3] = 7'h30; // var
		4'hd: char_addr_s[3] = 7'h30; // var
		4'he: char_addr_s[3] = 7'h30; // var
		4'hf : char_addr_s[3] = 7'h00; // 
	endcase
end

// line 4
assign score_on[4] = (pix_y[9:5] == 4) && (pix_x[9:4] < 16);
assign row_addr_s[4] = pix_y [4:1]; 
assign bit_addr_s[4] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[4] = 7'h24; // $ 
		4'h1: char_addr_s[4] = 7'h61; // 
		4'h2: char_addr_s[4] = 7'h30; // 
		4'h3: char_addr_s[4] = 7'h3a; // :
		4'h4: char_addr_s[4] = 7'h00; // 
		4'h5: char_addr_s[4] = 7'h30; // 0
		4'h6: char_addr_s[4] = 7'h58; // x
		4'h7: char_addr_s[4] = 7'h30; // var
		4'h8: char_addr_s[4] = 7'h30; // var
		4'h9: char_addr_s[4] = 7'h30; // var
		4'ha: char_addr_s[4] = 7'h30; // var
		4'hb: char_addr_s[4] = 7'h30; // var
		4'hc: char_addr_s[4] = 7'h30; // var
		4'hd: char_addr_s[4] = 7'h30; // var
		4'he: char_addr_s[4] = 7'h30; // var
		4'hf : char_addr_s[4] = 7'h00; // 
	endcase
end

// line 5
assign score_on[5] = (pix_y[9:5] == 5) && (pix_x[9:4] < 16);
assign row_addr_s[5] = pix_y [4:1]; 
assign bit_addr_s[5] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[5] = 7'h24; // $ 
		4'h1: char_addr_s[5] = 7'h61; // 
		4'h2: char_addr_s[5] = 7'h31; // 
		4'h3: char_addr_s[5] = 7'h3a; // :
		4'h4: char_addr_s[5] = 7'h00; // 
		4'h5: char_addr_s[5] = 7'h30; // 0
		4'h6: char_addr_s[5] = 7'h58; // x
		4'h7: char_addr_s[5] = 7'h30; // var
		4'h8: char_addr_s[5] = 7'h30; // var
		4'h9: char_addr_s[5] = 7'h30; // var
		4'ha: char_addr_s[5] = 7'h30; // var
		4'hb: char_addr_s[5] = 7'h30; // var
		4'hc: char_addr_s[5] = 7'h30; // var
		4'hd: char_addr_s[5] = 7'h30; // var
		4'he: char_addr_s[5] = 7'h30; // var
		4'hf : char_addr_s[5] = 7'h00; // 
	endcase
end

// line 6
assign score_on[6] = (pix_y[9:5] == 6) && (pix_x[9:4] < 16);
assign row_addr_s[6] = pix_y [4:1]; 
assign bit_addr_s[6] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[6] = 7'h24; // $ 
		4'h1: char_addr_s[6] = 7'h61; // 
		4'h2: char_addr_s[6] = 7'h32; // 
		4'h3: char_addr_s[6] = 7'h3a; // :
		4'h4: char_addr_s[6] = 7'h00; // 
		4'h5: char_addr_s[6] = 7'h30; // 0
		4'h6: char_addr_s[6] = 7'h58; // x
		4'h7: char_addr_s[6] = 7'h30; // var
		4'h8: char_addr_s[6] = 7'h30; // var
		4'h9: char_addr_s[6] = 7'h30; // var
		4'ha: char_addr_s[6] = 7'h30; // var
		4'hb: char_addr_s[6] = 7'h30; // var
		4'hc: char_addr_s[6] = 7'h30; // var
		4'hd: char_addr_s[6] = 7'h30; // var
		4'he: char_addr_s[6] = 7'h30; // var
		4'hf : char_addr_s[6] = 7'h00; // 
	endcase
end

// line 7
assign score_on[7] = (pix_y[9:5] == 7) && (pix_x[9:4] < 16);
assign row_addr_s[7] = pix_y [4:1]; 
assign bit_addr_s[7] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[7] = 7'h24; // $ 
		4'h1: char_addr_s[7] = 7'h61; // 
		4'h2: char_addr_s[7] = 7'h33; // 
		4'h3: char_addr_s[7] = 7'h3a; // :
		4'h4: char_addr_s[7] = 7'h00; // 
		4'h5: char_addr_s[7] = 7'h30; // 0
		4'h6: char_addr_s[7] = 7'h58; // x
		4'h7: char_addr_s[7] = 7'h30; // var
		4'h8: char_addr_s[7] = 7'h30; // var
		4'h9: char_addr_s[7] = 7'h30; // var
		4'ha: char_addr_s[7] = 7'h30; // var
		4'hb: char_addr_s[7] = 7'h30; // var
		4'hc: char_addr_s[7] = 7'h30; // var
		4'hd: char_addr_s[7] = 7'h30; // var
		4'he: char_addr_s[7] = 7'h30; // var
		4'hf : char_addr_s[7] = 7'h00; // 
	endcase
end

// line 8
assign score_on[8] = (pix_y[9:5] == 8) && (pix_x[9:4] < 16);
assign row_addr_s[8] = pix_y [4:1]; 
assign bit_addr_s[8] = pix_x [3:1]; 

always @* begin
	case (pix_x [7:4])
		4'h0: char_addr_s[8] = 7'h24; // $ 
		4'h1: char_addr_s[8] = 7'h74; // 
		4'h2: char_addr_s[8] = 7'h30; // 
		4'h3: char_addr_s[8] = 7'h3a; // :
		4'h4: char_addr_s[8] = 7'h00; // 
		4'h5: char_addr_s[8] = 7'h30; // 0
		4'h6: char_addr_s[8] = 7'h58; // x
		4'h7: char_addr_s[8] = (t0[31:28] < 10)? t0[31:28] + 7'h30 : t0[31:28] + 7'h57; // var
		4'h8: char_addr_s[8] = (t0[27:24] < 10)? t0[27:24] + 7'h30 : t0[27:24] + 7'h57;// var
		4'h9: char_addr_s[8] = (t0[23:20] < 10)? t0[23:20] + 7'h30 : t0[23:20] + 7'h57;// var
		4'ha: char_addr_s[8] = (t0[19:16] < 10)? t0[19:16] + 7'h30 : t0[19:16] + 7'h57;// var
		4'hb: char_addr_s[8] = (t0[15:12] < 10)? t0[15:12] + 7'h30 : t0[15:12] + 7'h57;// var
		4'hc: char_addr_s[8] = (t0[11:8] < 10)? t0[11:8] + 7'h30 : t0[11:8] + 7'h57;// var
		4'hd: char_addr_s[8] = (t0[7:4] < 10)? t0[7:4] + 7'h30 : t0[7:4] + 7'h57;// var
		4'he: char_addr_s[8] = (t0[3:0] < 10)? t0[3:0] + 7'h30 : t0[3:0] + 7'h57;// var
		4'hf : char_addr_s[8] = 7'h00; // 
	endcase
end

// line 9
assign score_on[9] = (pix_y[9:5] == 9) && (pix_x[9:4] < 16);
assign row_addr_s[9] = pix_y [4:1]; 
assign bit_addr_s[9] = pix_x [3:1] ; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[9] = 7'h24; // 
      4'h1: char_addr_s[9] = 7'h74; // 
      4'h2: char_addr_s[9] = 7'h31; // 
      4'h3: char_addr_s[9] = 7'h3a; // 
      4'h4: char_addr_s[9] = 7'h00; // 
      4'h5: char_addr_s[9] = 7'h30; // 
      4'h6: char_addr_s[9] = 7'h58; // 
      4'h7: char_addr_s[9] = 7'h30; // 
      4'h8: char_addr_s[9] = 7'h30; //
      4'h9: char_addr_s[9] = 7'h30; //
      4'ha: char_addr_s[9] = 7'h30; // 
      4'hb: char_addr_s[9] = 7'h30; // 
      4'hc: char_addr_s[9] = 7'h30; // 
      4'hd: char_addr_s[9] = 7'h30; // 
      4'he: char_addr_s[9] = 7'h30; // 
      4'hf : char_addr_s[9] = {5'b01100, ball}; // 
   endcase
end

// line 10
assign score_on[10] = (pix_y[9:5] == 'd10) && (pix_x[9:4] < 16);
assign row_addr_s[10] = pix_y [4:1]; 
assign bit_addr_s[10] = pix_x [3:1] ; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[10] = 7'h24; // 
      4'h1: char_addr_s[10] = 7'h74; // 
      4'h2: char_addr_s[10] = 7'h32; // 
      4'h3: char_addr_s[10] = 7'h3a; // 
      4'h4: char_addr_s[10] = 7'h00; // 
      4'h5: char_addr_s[10] = 7'h30; // 
      4'h6: char_addr_s[10] = 7'h58; // 
      4'h7: char_addr_s[10] = 7'h30; // 
      4'h8: char_addr_s[10] = 7'h30; //
      4'h9: char_addr_s[10] = 7'h30; //
      4'ha: char_addr_s[10] = 7'h30; // 
      4'hb: char_addr_s[10] = 7'h30; // 
      4'hc: char_addr_s[10] = 7'h30; // 
      4'hd: char_addr_s[10] = 7'h30; // 
      4'he: char_addr_s[10] = 7'h30; // 
      4'hf : char_addr_s[10] = {5'b01100, ball}; // 
   endcase
end

// line 11
assign score_on[11] = (pix_y[9:5] == 'd11) && (pix_x[9:4] < 16);
assign row_addr_s[11] = pix_y [4:1]; 
assign bit_addr_s[11] = pix_x [3:1] ; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[11] = 7'h24; // 
      4'h1: char_addr_s[11] = 7'h74; // 
      4'h2: char_addr_s[11] = 7'h33; // 
      4'h3: char_addr_s[11] = 7'h3a; // 
      4'h4: char_addr_s[11] = 7'h00; // 
      4'h5: char_addr_s[11] = 7'h30; // 
      4'h6: char_addr_s[11] = 7'h58; // 
      4'h7: char_addr_s[11] = 7'h30; // 
      4'h8: char_addr_s[11] = 7'h30; //
      4'h9: char_addr_s[11] = 7'h30; //
      4'ha: char_addr_s[11] = 7'h30; // 
      4'hb: char_addr_s[11] = 7'h30; // 
      4'hc: char_addr_s[11] = 7'h30; // 
      4'hd: char_addr_s[11] = 7'h30; // 
      4'he: char_addr_s[11] = 7'h30; // 
      4'hf : char_addr_s[11] = {5'b01100, ball}; // 
   endcase
end

// line 12
assign score_on[12] = (pix_y[9:5] == 'd12) && (pix_x[9:4] < 16);
assign row_addr_s[12] = pix_y [4:1]; 
assign bit_addr_s[12] = pix_x [3:1] ; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[12] = 7'h24; // 
      4'h1: char_addr_s[12] = 7'h74; // 
      4'h2: char_addr_s[12] = 7'h34; // 
      4'h3: char_addr_s[12] = 7'h3a; // 
      4'h4: char_addr_s[12] = 7'h00; // 
      4'h5: char_addr_s[12] = 7'h30; // 
      4'h6: char_addr_s[12] = 7'h58; // 
      4'h7: char_addr_s[12] = 7'h30; // 
      4'h8: char_addr_s[12] = 7'h30; //
      4'h9: char_addr_s[12] = 7'h30; //
      4'ha: char_addr_s[12] = 7'h30; // 
      4'hb: char_addr_s[12] = 7'h30; // 
      4'hc: char_addr_s[12] = 7'h30; // 
      4'hd: char_addr_s[12] = 7'h30; // 
      4'he: char_addr_s[12] = 7'h30; // 
      4'hf : char_addr_s[12] = {5'b01100, ball}; // 
   endcase
end

// line 16
assign score_on[16] = (pix_y[9:5] == 0) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[16] = pix_y [4:1]; 
assign bit_addr_s[16] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[16] = 7'h24; // $ 
      4'h1: char_addr_s[16] = 7'h74; // t
      4'h2: char_addr_s[16] = 7'h35; // 5
      4'h3: char_addr_s[16] = 7'h3a; // :
      4'h4: char_addr_s[16] = 7'h00; // 
      4'h5: char_addr_s[16] = 7'h30; // 0
      4'h6: char_addr_s[16] = 7'h58; // x
      4'h7: char_addr_s[16] = 7'h30; // var
      4'h8: char_addr_s[16] = 7'h30; // var
      4'h9: char_addr_s[16] = 7'h30; // var
      4'ha: char_addr_s[16] = 7'h30; // var
      4'hb: char_addr_s[16] = 7'h30; // var
      4'hc: char_addr_s[16] = 7'h30; // var
      4'hd: char_addr_s[16] = 7'h30; // var
      4'he: char_addr_s[16] = 7'h30; // var
      4'hf : char_addr_s[16] = 7'h00; // 
   endcase
end

// line 17
assign score_on[17] = (pix_y[9:5] == 1) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[17] = pix_y [4:1]; 
assign bit_addr_s[17] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[17] = 7'h24; // $ 
      4'h1: char_addr_s[17] = 7'h74; // t
      4'h2: char_addr_s[17] = 7'h36; // 6
      4'h3: char_addr_s[17] = 7'h3a; // :
      4'h4: char_addr_s[17] = 7'h00; // 
      4'h5: char_addr_s[17] = 7'h30; // 0
      4'h6: char_addr_s[17] = 7'h58; // x
      4'h7: char_addr_s[17] = 7'h30; // var
      4'h8: char_addr_s[17] = 7'h30; // var
      4'h9: char_addr_s[17] = 7'h30; // var
      4'ha: char_addr_s[17] = 7'h30; // var
      4'hb: char_addr_s[17] = 7'h30; // var
      4'hc: char_addr_s[17] = 7'h30; // var
      4'hd: char_addr_s[17] = 7'h30; // var
      4'he: char_addr_s[17] = 7'h30; // var
      4'hf : char_addr_s[17] = 7'h00; // 
   endcase
end

// line 18
assign score_on[18] = (pix_y[9:5] == 2) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[18] = pix_y [4:1]; 
assign bit_addr_s[18] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[18] = 7'h24; // $ 
      4'h1: char_addr_s[18] = 7'h74; // t
      4'h2: char_addr_s[18] = 7'h37; // 7
      4'h3: char_addr_s[18] = 7'h3a; // :
      4'h4: char_addr_s[18] = 7'h00; // 
      4'h5: char_addr_s[18] = 7'h30; // 0
      4'h6: char_addr_s[18] = 7'h58; // x
      4'h7: char_addr_s[18] = 7'h30; // var
      4'h8: char_addr_s[18] = 7'h30; // var
      4'h9: char_addr_s[18] = 7'h30; // var
      4'ha: char_addr_s[18] = 7'h30; // var
      4'hb: char_addr_s[18] = 7'h30; // var
      4'hc: char_addr_s[18] = 7'h30; // var
      4'hd: char_addr_s[18] = 7'h30; // var
      4'he: char_addr_s[18] = 7'h30; // var
      4'hf : char_addr_s[18] = 7'h00; // 
   endcase
end

// line 19
assign score_on[19] = (pix_y[9:5] == 3) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[19] = pix_y [4:1]; 
assign bit_addr_s[19] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[19] = 7'h24; // $ 
      4'h1: char_addr_s[19] = 7'h73; // s
      4'h2: char_addr_s[19] = 7'h30; // 0
      4'h3: char_addr_s[19] = 7'h3a; // :
      4'h4: char_addr_s[19] = 7'h00; // 
      4'h5: char_addr_s[19] = 7'h30; // 0
      4'h6: char_addr_s[19] = 7'h58; // x
      4'h7: char_addr_s[19] = 7'h30; // var
      4'h8: char_addr_s[19] = 7'h30; // var
      4'h9: char_addr_s[19] = 7'h30; // var
      4'ha: char_addr_s[19] = 7'h30; // var
      4'hb: char_addr_s[19] = 7'h30; // var
      4'hc: char_addr_s[19] = 7'h30; // var
      4'hd: char_addr_s[19] = 7'h30; // var
      4'he: char_addr_s[19] = 7'h30; // var
      4'hf : char_addr_s[19] = 7'h00; // 
   endcase
end


// line 20
assign score_on[20] = (pix_y[9:5] == 4) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[20] = pix_y [4:1]; 
assign bit_addr_s[20] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[20] = 7'h24; // $ 
      4'h1: char_addr_s[20] = 7'h73; // s
      4'h2: char_addr_s[20] = 7'h31; // 1
      4'h3: char_addr_s[20] = 7'h3a; // :
      4'h4: char_addr_s[20] = 7'h00; // 
      4'h5: char_addr_s[20] = 7'h30; // 0
      4'h6: char_addr_s[20] = 7'h58; // x
      4'h7: char_addr_s[20] = 7'h30; // var
      4'h8: char_addr_s[20] = 7'h30; // var
      4'h9: char_addr_s[20] = 7'h30; // var
      4'ha: char_addr_s[20] = 7'h30; // var
      4'hb: char_addr_s[20] = 7'h30; // var
      4'hc: char_addr_s[20] = 7'h30; // var
      4'hd: char_addr_s[20] = 7'h30; // var
      4'he: char_addr_s[20] = 7'h30; // var
      4'hf : char_addr_s[20] = 7'h00; // 
   endcase
end


// line 21
assign score_on[21] = (pix_y[9:5] == 5) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[21] = pix_y [4:1]; 
assign bit_addr_s[21] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[21] = 7'h24; // $ 
      4'h1: char_addr_s[21] = 7'h73; // s
      4'h2: char_addr_s[21] = 7'h32; // 2
      4'h3: char_addr_s[21] = 7'h3a; // :
      4'h4: char_addr_s[21] = 7'h00; // 
      4'h5: char_addr_s[21] = 7'h30; // 0
      4'h6: char_addr_s[21] = 7'h58; // x
      4'h7: char_addr_s[21] = 7'h30; // var
      4'h8: char_addr_s[21] = 7'h30; // var
      4'h9: char_addr_s[21] = 7'h30; // var
      4'ha: char_addr_s[21] = 7'h30; // var
      4'hb: char_addr_s[21] = 7'h30; // var
      4'hc: char_addr_s[21] = 7'h30; // var
      4'hd: char_addr_s[21] = 7'h30; // var
      4'he: char_addr_s[21] = 7'h30; // var
      4'hf : char_addr_s[21] = 7'h00; // 
   endcase
end


// line 22
assign score_on[22] = (pix_y[9:5] == 6) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[22] = pix_y [4:1]; 
assign bit_addr_s[22] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[22] = 7'h24; // $ 
      4'h1: char_addr_s[22] = 7'h73; // s
      4'h2: char_addr_s[22] = 7'h33; // 3
      4'h3: char_addr_s[22] = 7'h3a; // :
      4'h4: char_addr_s[22] = 7'h00; // 
      4'h5: char_addr_s[22] = 7'h30; // 0
      4'h6: char_addr_s[22] = 7'h58; // x
      4'h7: char_addr_s[22] = 7'h30; // var
      4'h8: char_addr_s[22] = 7'h30; // var
      4'h9: char_addr_s[22] = 7'h30; // var
      4'ha: char_addr_s[22] = 7'h30; // var
      4'hb: char_addr_s[22] = 7'h30; // var
      4'hc: char_addr_s[22] = 7'h30; // var
      4'hd: char_addr_s[22] = 7'h30; // var
      4'he: char_addr_s[22] = 7'h30; // var
      4'hf : char_addr_s[22] = 7'h00; // 
   endcase
end


// line 23
assign score_on[23] = (pix_y[9:5] == 7) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[23] = pix_y [4:1]; 
assign bit_addr_s[23] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[23] = 7'h24; // $ 
      4'h1: char_addr_s[23] = 7'h73; // s
      4'h2: char_addr_s[23] = 7'h34; // 4
      4'h3: char_addr_s[23] = 7'h3a; // :
      4'h4: char_addr_s[23] = 7'h00; // 
      4'h5: char_addr_s[23] = 7'h30; // 0
      4'h6: char_addr_s[23] = 7'h58; // x
      4'h7: char_addr_s[23] = 7'h30; // var
      4'h8: char_addr_s[23] = 7'h30; // var
      4'h9: char_addr_s[23] = 7'h30; // var
      4'ha: char_addr_s[23] = 7'h30; // var
      4'hb: char_addr_s[23] = 7'h30; // var
      4'hc: char_addr_s[23] = 7'h30; // var
      4'hd: char_addr_s[23] = 7'h30; // var
      4'he: char_addr_s[23] = 7'h30; // var
      4'hf : char_addr_s[23] = 7'h00; // 
   endcase
end


// line 24
assign score_on[24] = (pix_y[9:5] == 8) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[24] = pix_y [4:1]; 
assign bit_addr_s[24] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[24] = 7'h24; // $ 
      4'h1: char_addr_s[24] = 7'h73; // s
      4'h2: char_addr_s[24] = 7'h35; // 5
      4'h3: char_addr_s[24] = 7'h3a; // :
      4'h4: char_addr_s[24] = 7'h00; // 
      4'h5: char_addr_s[24] = 7'h30; // 0
      4'h6: char_addr_s[24] = 7'h58; // x
      4'h7: char_addr_s[24] = 7'h30; // var
      4'h8: char_addr_s[24] = 7'h30; // var
      4'h9: char_addr_s[24] = 7'h30; // var
      4'ha: char_addr_s[24] = 7'h30; // var
      4'hb: char_addr_s[24] = 7'h30; // var
      4'hc: char_addr_s[24] = 7'h30; // var
      4'hd: char_addr_s[24] = 7'h30; // var
      4'he: char_addr_s[24] = 7'h30; // var
      4'hf : char_addr_s[24] = 7'h00; // 
   endcase
end


// line 25
assign score_on[25] = (pix_y[9:5] == 9) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[25] = pix_y [4:1]; 
assign bit_addr_s[25] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[25] = 7'h24; // $ 
      4'h1: char_addr_s[25] = 7'h73; // s
      4'h2: char_addr_s[25] = 7'h36; // 6
      4'h3: char_addr_s[25] = 7'h3a; // :
      4'h4: char_addr_s[25] = 7'h00; // 
      4'h5: char_addr_s[25] = 7'h30; // 0
      4'h6: char_addr_s[25] = 7'h58; // x
      4'h7: char_addr_s[25] = 7'h30; // var
      4'h8: char_addr_s[25] = 7'h30; // var
      4'h9: char_addr_s[25] = 7'h30; // var
      4'ha: char_addr_s[25] = 7'h30; // var
      4'hb: char_addr_s[25] = 7'h30; // var
      4'hc: char_addr_s[25] = 7'h30; // var
      4'hd: char_addr_s[25] = 7'h30; // var
      4'he: char_addr_s[25] = 7'h30; // var
      4'hf : char_addr_s[25] = 7'h00; // 
   endcase
end


// line 26
assign score_on[26] = (pix_y[9:5] == 10) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[26] = pix_y [4:1]; 
assign bit_addr_s[26] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[26] = 7'h24; // $ 
      4'h1: char_addr_s[26] = 7'h73; // s
      4'h2: char_addr_s[26] = 7'h37; // 7
      4'h3: char_addr_s[26] = 7'h3a; // :
      4'h4: char_addr_s[26] = 7'h00; // 
      4'h5: char_addr_s[26] = 7'h30; // 0
      4'h6: char_addr_s[26] = 7'h58; // x
      4'h7: char_addr_s[26] = 7'h30; // var
      4'h8: char_addr_s[26] = 7'h30; // var
      4'h9: char_addr_s[26] = 7'h30; // var
      4'ha: char_addr_s[26] = 7'h30; // var
      4'hb: char_addr_s[26] = 7'h30; // var
      4'hc: char_addr_s[26] = 7'h30; // var
      4'hd: char_addr_s[26] = 7'h30; // var
      4'he: char_addr_s[26] = 7'h30; // var
      4'hf : char_addr_s[26] = 7'h00; // 
   endcase
end


// line 27
assign score_on[27] = (pix_y[9:5] == 11) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[27] = pix_y [4:1]; 
assign bit_addr_s[27] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[27] = 7'h24; // $ 
      4'h1: char_addr_s[27] = 7'h74; // t 
      4'h2: char_addr_s[27] = 7'h38; // 8
      4'h3: char_addr_s[27] = 7'h3a; // :
      4'h4: char_addr_s[27] = 7'h00; // 
      4'h5: char_addr_s[27] = 7'h30; // 0
      4'h6: char_addr_s[27] = 7'h58; // x
      4'h7: char_addr_s[27] = 7'h30; // var
      4'h8: char_addr_s[27] = 7'h30; // var
      4'h9: char_addr_s[27] = 7'h30; // var
      4'ha: char_addr_s[27] = 7'h30; // var
      4'hb: char_addr_s[27] = 7'h30; // var
      4'hc: char_addr_s[27] = 7'h30; // var
      4'hd: char_addr_s[27] = 7'h30; // var
      4'he: char_addr_s[27] = 7'h30; // var
      4'hf : char_addr_s[27] = 7'h00; // 
   endcase
end


// line 28
assign score_on[28] = (pix_y[9:5] == 12) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[28] = pix_y [4:1]; 
assign bit_addr_s[28] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[28] = 7'h24; // $ 
      4'h1: char_addr_s[28] = 7'h74; // t
      4'h2: char_addr_s[28] = 7'h39; // 9
      4'h3: char_addr_s[28] = 7'h3a; // :
      4'h4: char_addr_s[28] = 7'h00; // 
      4'h5: char_addr_s[28] = 7'h30; // 0
      4'h6: char_addr_s[28] = 7'h58; // x
      4'h7: char_addr_s[28] = 7'h30; // var
      4'h8: char_addr_s[28] = 7'h30; // var
      4'h9: char_addr_s[28] = 7'h30; // var
      4'ha: char_addr_s[28] = 7'h30; // var
      4'hb: char_addr_s[28] = 7'h30; // var
      4'hc: char_addr_s[28] = 7'h30; // var
      4'hd: char_addr_s[28] = 7'h30; // var
      4'he: char_addr_s[28] = 7'h30; // var
      4'hf : char_addr_s[28] = 7'h00; // 
   endcase
end

always @* begin
	char_addr = 7'h00;
	row_addr = 4'h0;
	bit_addr = 3'h0;
	text_rgb = font_background;
	if(score_on[0]) begin
		char_addr = char_addr_s[0];
		row_addr = row_addr_s[0];
		bit_addr = bit_addr_s[0];
		if(font_bit)
			text_rgb = SCORE_COLOR;
	end
	else if(score_on[1]) begin
        char_addr = char_addr_s[1];
        row_addr = row_addr_s[1];
        bit_addr = bit_addr_s[1];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[2]) begin
        char_addr = char_addr_s[2];
        row_addr = row_addr_s[2];
        bit_addr = bit_addr_s[2];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[3]) begin
        char_addr = char_addr_s[3];
        row_addr = row_addr_s[3];
        bit_addr = bit_addr_s[3];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[4]) begin
        char_addr = char_addr_s[4];
        row_addr = row_addr_s[4];
        bit_addr = bit_addr_s[4];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[5]) begin
        char_addr = char_addr_s[5];
        row_addr = row_addr_s[5];
        bit_addr = bit_addr_s[5];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[6]) begin
        char_addr = char_addr_s[6];
        row_addr = row_addr_s[6];
        bit_addr = bit_addr_s[6];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[7]) begin
        char_addr = char_addr_s[7];
        row_addr = row_addr_s[7];
        bit_addr = bit_addr_s[7];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
    else if(score_on[8]) begin
        char_addr = char_addr_s[8];
        row_addr = row_addr_s[8];
        bit_addr = bit_addr_s[8];
        if(font_bit)
            text_rgb = SCORE_COLOR;
    end
end

assign text_on = 1;
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[7-bit_addr]; // MSB display first

endmodule
