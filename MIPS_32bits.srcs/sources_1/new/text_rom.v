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
    input [31:0] gp, sp, fp, ra,
    input [3:0] cs,
    input start, resume, mode, debug_mode 
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
		4'h1: char_addr_s[0] = 7'h30; // 0
		4'h2: char_addr_s[0] = 7'h00; // 
		4'h3: char_addr_s[0] = 7'h3a; // :
		4'h4: char_addr_s[0] = 7'h00; // 
		4'h5: char_addr_s[0] = 7'h30; // 0
		4'h6: char_addr_s[0] = 7'h58; // x
		4'h7: char_addr_s[0] = (zero[31:28] < 10)? zero[31:28] + 7'h30 : zero[31:28] + 7'h57; // var
		4'h8: char_addr_s[0] = (zero[27:24] < 10)? zero[27:24] + 7'h30 : zero[27:24] + 7'h57;// var
		4'h9: char_addr_s[0] = (zero[23:20] < 10)? zero[23:20] + 7'h30 : zero[23:20] + 7'h57;// var
		4'ha: char_addr_s[0] = (zero[19:16] < 10)? zero[19:16] + 7'h30 : zero[19:16] + 7'h57;// var
		4'hb: char_addr_s[0] = (zero[15:12] < 10)? zero[15:12] + 7'h30 : zero[15:12] + 7'h57;// var
		4'hc: char_addr_s[0] = (zero[11:8] < 10)? zero[11:8] + 7'h30 : zero[11:8] + 7'h57;// var
		4'hd: char_addr_s[0] = (zero[7:4] < 10)? zero[7:4] + 7'h30 : zero[7:4] + 7'h57;// var
		4'he: char_addr_s[0] = (zero[3:0] < 10)? zero[3:0] + 7'h30 : zero[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[1] = 7'h61; // a
		4'h2: char_addr_s[1] = 7'h74; // t
		4'h3: char_addr_s[1] = 7'h3a; // :
		4'h4: char_addr_s[1] = 7'h00; // 
		4'h5: char_addr_s[1] = 7'h30; // 0
		4'h6: char_addr_s[1] = 7'h58; // x
		4'h7: char_addr_s[1] = (at[31:28] < 10)? at[31:28] + 7'h30 : at[31:28] + 7'h57; // var
		4'h8: char_addr_s[1] = (at[27:24] < 10)? at[27:24] + 7'h30 : at[27:24] + 7'h57;// var
		4'h9: char_addr_s[1] = (at[23:20] < 10)? at[23:20] + 7'h30 : at[23:20] + 7'h57;// var
		4'ha: char_addr_s[1] = (at[19:16] < 10)? at[19:16] + 7'h30 : at[19:16] + 7'h57;// var
		4'hb: char_addr_s[1] = (at[15:12] < 10)? at[15:12] + 7'h30 : at[15:12] + 7'h57;// var
		4'hc: char_addr_s[1] = (at[11:8] < 10)? at[11:8] + 7'h30 : at[11:8] + 7'h57;// var
		4'hd: char_addr_s[1] = (at[7:4] < 10)? at[7:4] + 7'h30 : at[7:4] + 7'h57;// var
		4'he: char_addr_s[1] = (at[3:0] < 10)? at[3:0] + 7'h30 : at[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[2] = 7'h76; // v
		4'h2: char_addr_s[2] = 7'h30; // 0
		4'h3: char_addr_s[2] = 7'h3a; // :
		4'h4: char_addr_s[2] = 7'h00; // 
		4'h5: char_addr_s[2] = 7'h30; // 0
		4'h6: char_addr_s[2] = 7'h58; // x
		4'h7: char_addr_s[2] = (v0[31:28] < 10)? v0[31:28] + 7'h30 : v0[31:28] + 7'h57; // var
		4'h8: char_addr_s[2] = (v0[27:24] < 10)? v0[27:24] + 7'h30 : v0[27:24] + 7'h57;// var
		4'h9: char_addr_s[2] = (v0[23:20] < 10)? v0[23:20] + 7'h30 : v0[23:20] + 7'h57;// var
		4'ha: char_addr_s[2] = (v0[19:16] < 10)? v0[19:16] + 7'h30 : v0[19:16] + 7'h57;// var
		4'hb: char_addr_s[2] = (v0[15:12] < 10)? v0[15:12] + 7'h30 : v0[15:12] + 7'h57;// var
		4'hc: char_addr_s[2] = (v0[11:8] < 10)? v0[11:8] + 7'h30 : v0[11:8] + 7'h57;// var
		4'hd: char_addr_s[2] = (v0[7:4] < 10)? v0[7:4] + 7'h30 : v0[7:4] + 7'h57;// var
		4'he: char_addr_s[2] = (v0[3:0] < 10)? v0[3:0] + 7'h30 : v0[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[3] = 7'h76; // v
		4'h2: char_addr_s[3] = 7'h31; // 1
		4'h3: char_addr_s[3] = 7'h3a; // :
		4'h4: char_addr_s[3] = 7'h00; // 
		4'h5: char_addr_s[3] = 7'h30; // 0
		4'h6: char_addr_s[3] = 7'h58; // x
		4'h7: char_addr_s[3] = (v1[31:28] < 10)? v1[31:28] + 7'h30 : v1[31:28] + 7'h57; // var
		4'h8: char_addr_s[3] = (v1[27:24] < 10)? v1[27:24] + 7'h30 : v1[27:24] + 7'h57;// var
		4'h9: char_addr_s[3] = (v1[23:20] < 10)? v1[23:20] + 7'h30 : v1[23:20] + 7'h57;// var
		4'ha: char_addr_s[3] = (v1[19:16] < 10)? v1[19:16] + 7'h30 : v1[19:16] + 7'h57;// var
		4'hb: char_addr_s[3] = (v1[15:12] < 10)? v1[15:12] + 7'h30 : v1[15:12] + 7'h57;// var
		4'hc: char_addr_s[3] = (v1[11:8] < 10)? v1[11:8] + 7'h30 : v1[11:8] + 7'h57;// var
		4'hd: char_addr_s[3] = (v1[7:4] < 10)? v1[7:4] + 7'h30 : v1[7:4] + 7'h57;// var
		4'he: char_addr_s[3] = (v1[3:0] < 10)? v1[3:0] + 7'h30 : v1[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[4] = 7'h61; // a
		4'h2: char_addr_s[4] = 7'h30; // 0
		4'h3: char_addr_s[4] = 7'h3a; // :
		4'h4: char_addr_s[4] = 7'h00; // 
		4'h5: char_addr_s[4] = 7'h30; // 0
		4'h6: char_addr_s[4] = 7'h58; // x
		4'h7: char_addr_s[4] = (a0[31:28] < 10)? a0[31:28] + 7'h30 : a0[31:28] + 7'h57; // var
		4'h8: char_addr_s[4] = (a0[27:24] < 10)? a0[27:24] + 7'h30 : a0[27:24] + 7'h57;// var
		4'h9: char_addr_s[4] = (a0[23:20] < 10)? a0[23:20] + 7'h30 : a0[23:20] + 7'h57;// var
		4'ha: char_addr_s[4] = (a0[19:16] < 10)? a0[19:16] + 7'h30 : a0[19:16] + 7'h57;// var
		4'hb: char_addr_s[4] = (a0[15:12] < 10)? a0[15:12] + 7'h30 : a0[15:12] + 7'h57;// var
		4'hc: char_addr_s[4] = (a0[11:8] < 10)? a0[11:8] + 7'h30 : a0[11:8] + 7'h57;// var
		4'hd: char_addr_s[4] = (a0[7:4] < 10)? a0[7:4] + 7'h30 : a0[7:4] + 7'h57;// var
		4'he: char_addr_s[4] = (a0[3:0] < 10)? a0[3:0] + 7'h30 : a0[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[5] = 7'h61; // a
		4'h2: char_addr_s[5] = 7'h31; // 1
		4'h3: char_addr_s[5] = 7'h3a; // :
		4'h4: char_addr_s[5] = 7'h00; // 
		4'h5: char_addr_s[5] = 7'h30; // 0
		4'h6: char_addr_s[5] = 7'h58; // x
		4'h7: char_addr_s[5] = (a1[31:28] < 10)? a1[31:28] + 7'h30 : a1[31:28] + 7'h57; // var
		4'h8: char_addr_s[5] = (a1[27:24] < 10)? a1[27:24] + 7'h30 : a1[27:24] + 7'h57;// var
		4'h9: char_addr_s[5] = (a1[23:20] < 10)? a1[23:20] + 7'h30 : a1[23:20] + 7'h57;// var
		4'ha: char_addr_s[5] = (a1[19:16] < 10)? a1[19:16] + 7'h30 : a1[19:16] + 7'h57;// var
		4'hb: char_addr_s[5] = (a1[15:12] < 10)? a1[15:12] + 7'h30 : a1[15:12] + 7'h57;// var
		4'hc: char_addr_s[5] = (a1[11:8] < 10)? a1[11:8] + 7'h30 : a1[11:8] + 7'h57;// var
		4'hd: char_addr_s[5] = (a1[7:4] < 10)? a1[7:4] + 7'h30 : a1[7:4] + 7'h57;// var
		4'he: char_addr_s[5] = (a1[3:0] < 10)? a1[3:0] + 7'h30 : a1[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[6] = 7'h61; // a
		4'h2: char_addr_s[6] = 7'h32; // 2
		4'h3: char_addr_s[6] = 7'h3a; // :
		4'h4: char_addr_s[6] = 7'h00; // 
		4'h5: char_addr_s[6] = 7'h30; // 0
		4'h6: char_addr_s[6] = 7'h58; // x
		4'h7: char_addr_s[6] = (a2[31:28] < 10)? a2[31:28] + 7'h30 : a2[31:28] + 7'h57; // var
		4'h8: char_addr_s[6] = (a2[27:24] < 10)? a2[27:24] + 7'h30 : a2[27:24] + 7'h57;// var
		4'h9: char_addr_s[6] = (a2[23:20] < 10)? a2[23:20] + 7'h30 : a2[23:20] + 7'h57;// var
		4'ha: char_addr_s[6] = (a2[19:16] < 10)? a2[19:16] + 7'h30 : a2[19:16] + 7'h57;// var
		4'hb: char_addr_s[6] = (a2[15:12] < 10)? a2[15:12] + 7'h30 : a2[15:12] + 7'h57;// var
		4'hc: char_addr_s[6] = (a2[11:8] < 10)? a2[11:8] + 7'h30 : a2[11:8] + 7'h57;// var
		4'hd: char_addr_s[6] = (a2[7:4] < 10)? a2[7:4] + 7'h30 : a2[7:4] + 7'h57;// var
		4'he: char_addr_s[6] = (a2[3:0] < 10)? a2[3:0] + 7'h30 : a2[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[7] = 7'h61; // a
		4'h2: char_addr_s[7] = 7'h33; // 3
		4'h3: char_addr_s[7] = 7'h3a; // :
		4'h4: char_addr_s[7] = 7'h00; // 
		4'h5: char_addr_s[7] = 7'h30; // 0
		4'h6: char_addr_s[7] = 7'h58; // x
		4'h7: char_addr_s[7] = (a3[31:28] < 10)? a3[31:28] + 7'h30 : a3[31:28] + 7'h57; // var
		4'h8: char_addr_s[7] = (a3[27:24] < 10)? a3[27:24] + 7'h30 : a3[27:24] + 7'h57;// var
		4'h9: char_addr_s[7] = (a3[23:20] < 10)? a3[23:20] + 7'h30 : a3[23:20] + 7'h57;// var
		4'ha: char_addr_s[7] = (a3[19:16] < 10)? a3[19:16] + 7'h30 : a3[19:16] + 7'h57;// var
		4'hb: char_addr_s[7] = (a3[15:12] < 10)? a3[15:12] + 7'h30 : a3[15:12] + 7'h57;// var
		4'hc: char_addr_s[7] = (a3[11:8] < 10)? a3[11:8] + 7'h30 : a3[11:8] + 7'h57;// var
		4'hd: char_addr_s[7] = (a3[7:4] < 10)? a3[7:4] + 7'h30 : a3[7:4] + 7'h57;// var
		4'he: char_addr_s[7] = (a3[3:0] < 10)? a3[3:0] + 7'h30 : a3[3:0] + 7'h57;// var
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
		4'h1: char_addr_s[8] = 7'h74; // t
		4'h2: char_addr_s[8] = 7'h30; // 0
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
assign bit_addr_s[9] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[9] = 7'h24; // $ 
      4'h1: char_addr_s[9] = 7'h74; // t
      4'h2: char_addr_s[9] = 7'h31; // 1
      4'h3: char_addr_s[9] = 7'h3a; // :
      4'h4: char_addr_s[9] = 7'h00; // 
      4'h5: char_addr_s[9] = 7'h30; // 0
      4'h6: char_addr_s[9] = 7'h58; // x
      4'h7: char_addr_s[9] = (t1[31:28] < 10)? t1[31:28] + 7'h30 : t1[31:28] + 7'h57; // var
      4'h8: char_addr_s[9] = (t1[27:24] < 10)? t1[27:24] + 7'h30 : t1[27:24] + 7'h57;// var
      4'h9: char_addr_s[9] = (t1[23:20] < 10)? t1[23:20] + 7'h30 : t1[23:20] + 7'h57;// var
      4'ha: char_addr_s[9] = (t1[19:16] < 10)? t1[19:16] + 7'h30 : t1[19:16] + 7'h57;// var
      4'hb: char_addr_s[9] = (t1[15:12] < 10)? t1[15:12] + 7'h30 : t1[15:12] + 7'h57;// var
      4'hc: char_addr_s[9] = (t1[11:8] < 10)? t1[11:8] + 7'h30 : t1[11:8] + 7'h57;// var
      4'hd: char_addr_s[9] = (t1[7:4] < 10)? t1[7:4] + 7'h30 : t1[7:4] + 7'h57;// var
      4'he: char_addr_s[9] = (t1[3:0] < 10)? t1[3:0] + 7'h30 : t1[3:0] + 7'h57;// var
      4'hf : char_addr_s[9] = 7'h00; // 
   endcase
end

// line 10
assign score_on[10] = (pix_y[9:5] == 10) && (pix_x[9:4] < 16);
assign row_addr_s[10] = pix_y [4:1]; 
assign bit_addr_s[10] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[10] = 7'h24; // $ 
      4'h1: char_addr_s[10] = 7'h74; // t
      4'h2: char_addr_s[10] = 7'h32; // 2
      4'h3: char_addr_s[10] = 7'h3a; // :
      4'h4: char_addr_s[10] = 7'h00; // 
      4'h5: char_addr_s[10] = 7'h30; // 0
      4'h6: char_addr_s[10] = 7'h58; // x
      4'h7: char_addr_s[10] = (t2[31:28] < 10)? t2[31:28] + 7'h30 : t2[31:28] + 7'h57; // var
      4'h8: char_addr_s[10] = (t2[27:24] < 10)? t2[27:24] + 7'h30 : t2[27:24] + 7'h57;// var
      4'h9: char_addr_s[10] = (t2[23:20] < 10)? t2[23:20] + 7'h30 : t2[23:20] + 7'h57;// var
      4'ha: char_addr_s[10] = (t2[19:16] < 10)? t2[19:16] + 7'h30 : t2[19:16] + 7'h57;// var
      4'hb: char_addr_s[10] = (t2[15:12] < 10)? t2[15:12] + 7'h30 : t2[15:12] + 7'h57;// var
      4'hc: char_addr_s[10] = (t2[11:8] < 10)? t2[11:8] + 7'h30 : t2[11:8] + 7'h57;// var
      4'hd: char_addr_s[10] = (t2[7:4] < 10)? t2[7:4] + 7'h30 : t2[7:4] + 7'h57;// var
      4'he: char_addr_s[10] = (t2[3:0] < 10)? t2[3:0] + 7'h30 : t2[3:0] + 7'h57;// var
      4'hf : char_addr_s[10] = 7'h00; // 
   endcase
end

// line 11
assign score_on[11] = (pix_y[9:5] == 11) && (pix_x[9:4] < 16);
assign row_addr_s[11] = pix_y [4:1]; 
assign bit_addr_s[11] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[11] = 7'h24; // $ 
      4'h1: char_addr_s[11] = 7'h74; // t
      4'h2: char_addr_s[11] = 7'h33; // 3
      4'h3: char_addr_s[11] = 7'h3a; // :
      4'h4: char_addr_s[11] = 7'h00; // 
      4'h5: char_addr_s[11] = 7'h30; // 0
      4'h6: char_addr_s[11] = 7'h58; // x
      4'h7: char_addr_s[11] = (t3[31:28] < 10)? t3[31:28] + 7'h30 : t3[31:28] + 7'h57; // var
      4'h8: char_addr_s[11] = (t3[27:24] < 10)? t3[27:24] + 7'h30 : t3[27:24] + 7'h57;// var
      4'h9: char_addr_s[11] = (t3[23:20] < 10)? t3[23:20] + 7'h30 : t3[23:20] + 7'h57;// var
      4'ha: char_addr_s[11] = (t3[19:16] < 10)? t3[19:16] + 7'h30 : t3[19:16] + 7'h57;// var
      4'hb: char_addr_s[11] = (t3[15:12] < 10)? t3[15:12] + 7'h30 : t3[15:12] + 7'h57;// var
      4'hc: char_addr_s[11] = (t3[11:8] < 10)? t3[11:8] + 7'h30 : t3[11:8] + 7'h57;// var
      4'hd: char_addr_s[11] = (t3[7:4] < 10)? t3[7:4] + 7'h30 : t3[7:4] + 7'h57;// var
      4'he: char_addr_s[11] = (t3[3:0] < 10)? t3[3:0] + 7'h30 : t3[3:0] + 7'h57;// var
      4'hf : char_addr_s[11] = 7'h00; // 
   endcase
end

// line 12
assign score_on[12] = (pix_y[9:5] == 12) && (pix_x[9:4] < 16);
assign row_addr_s[12] = pix_y [4:1]; 
assign bit_addr_s[12] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[12] = 7'h24; // $ 
      4'h1: char_addr_s[12] = 7'h74; // t
      4'h2: char_addr_s[12] = 7'h34; // 4
      4'h3: char_addr_s[12] = 7'h3a; // :
      4'h4: char_addr_s[12] = 7'h00; // 
      4'h5: char_addr_s[12] = 7'h30; // 0
      4'h6: char_addr_s[12] = 7'h58; // x
      4'h7: char_addr_s[12] = (t4[31:28] < 10)? t4[31:28] + 7'h30 : t4[31:28] + 7'h57; // var
      4'h8: char_addr_s[12] = (t4[27:24] < 10)? t4[27:24] + 7'h30 : t4[27:24] + 7'h57;// var
      4'h9: char_addr_s[12] = (t4[23:20] < 10)? t4[23:20] + 7'h30 : t4[23:20] + 7'h57;// var
      4'ha: char_addr_s[12] = (t4[19:16] < 10)? t4[19:16] + 7'h30 : t4[19:16] + 7'h57;// var
      4'hb: char_addr_s[12] = (t4[15:12] < 10)? t4[15:12] + 7'h30 : t4[15:12] + 7'h57;// var
      4'hc: char_addr_s[12] = (t4[11:8] < 10)? t4[11:8] + 7'h30 : t4[11:8] + 7'h57;// var
      4'hd: char_addr_s[12] = (t4[7:4] < 10)? t4[7:4] + 7'h30 : t4[7:4] + 7'h57;// var
      4'he: char_addr_s[12] = (t4[3:0] < 10)? t4[3:0] + 7'h30 : t4[3:0] + 7'h57;// var
      4'hf : char_addr_s[12] = 7'h00; // 
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
      4'h7: char_addr_s[16] = (t5[31:28] < 10)? t5[31:28] + 7'h30 : t5[31:28] + 7'h57; // var
      4'h8: char_addr_s[16] = (t5[27:24] < 10)? t5[27:24] + 7'h30 : t5[27:24] + 7'h57;// var
      4'h9: char_addr_s[16] = (t5[23:20] < 10)? t5[23:20] + 7'h30 : t5[23:20] + 7'h57;// var
      4'ha: char_addr_s[16] = (t5[19:16] < 10)? t5[19:16] + 7'h30 : t5[19:16] + 7'h57;// var
      4'hb: char_addr_s[16] = (t5[15:12] < 10)? t5[15:12] + 7'h30 : t5[15:12] + 7'h57;// var
      4'hc: char_addr_s[16] = (t5[11:8] < 10)? t5[11:8] + 7'h30 : t5[11:8] + 7'h57;// var
      4'hd: char_addr_s[16] = (t5[7:4] < 10)? t5[7:4] + 7'h30 : t5[7:4] + 7'h57;// var
      4'he: char_addr_s[16] = (t5[3:0] < 10)? t5[3:0] + 7'h30 : t5[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[17] = (t6[31:28] < 10)? t6[31:28] + 7'h30 : t6[31:28] + 7'h57; // var
      4'h8: char_addr_s[17] = (t6[27:24] < 10)? t6[27:24] + 7'h30 : t6[27:24] + 7'h57;// var
      4'h9: char_addr_s[17] = (t6[23:20] < 10)? t6[23:20] + 7'h30 : t6[23:20] + 7'h57;// var
      4'ha: char_addr_s[17] = (t6[19:16] < 10)? t6[19:16] + 7'h30 : t6[19:16] + 7'h57;// var
      4'hb: char_addr_s[17] = (t6[15:12] < 10)? t6[15:12] + 7'h30 : t6[15:12] + 7'h57;// var
      4'hc: char_addr_s[17] = (t6[11:8] < 10)? t6[11:8] + 7'h30 : t6[11:8] + 7'h57;// var
      4'hd: char_addr_s[17] = (t6[7:4] < 10)? t6[7:4] + 7'h30 : t6[7:4] + 7'h57;// var
      4'he: char_addr_s[17] = (t6[3:0] < 10)? t6[3:0] + 7'h30 : t6[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[18] = (t7[31:28] < 10)? t7[31:28] + 7'h30 : t7[31:28] + 7'h57; // var
      4'h8: char_addr_s[18] = (t7[27:24] < 10)? t7[27:24] + 7'h30 : t7[27:24] + 7'h57;// var
      4'h9: char_addr_s[18] = (t7[23:20] < 10)? t7[23:20] + 7'h30 : t7[23:20] + 7'h57;// var
      4'ha: char_addr_s[18] = (t7[19:16] < 10)? t7[19:16] + 7'h30 : t7[19:16] + 7'h57;// var
      4'hb: char_addr_s[18] = (t7[15:12] < 10)? t7[15:12] + 7'h30 : t7[15:12] + 7'h57;// var
      4'hc: char_addr_s[18] = (t7[11:8] < 10)? t7[11:8] + 7'h30 : t7[11:8] + 7'h57;// var
      4'hd: char_addr_s[18] = (t7[7:4] < 10)? t7[7:4] + 7'h30 : t7[7:4] + 7'h57;// var
      4'he: char_addr_s[18] = (t7[3:0] < 10)? t7[3:0] + 7'h30 : t7[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[19] = (s0[31:28] < 10)? s0[31:28] + 7'h30 : s0[31:28] + 7'h57; // var
      4'h8: char_addr_s[19] = (s0[27:24] < 10)? s0[27:24] + 7'h30 : s0[27:24] + 7'h57;// var
      4'h9: char_addr_s[19] = (s0[23:20] < 10)? s0[23:20] + 7'h30 : s0[23:20] + 7'h57;// var
      4'ha: char_addr_s[19] = (s0[19:16] < 10)? s0[19:16] + 7'h30 : s0[19:16] + 7'h57;// var
      4'hb: char_addr_s[19] = (s0[15:12] < 10)? s0[15:12] + 7'h30 : s0[15:12] + 7'h57;// var
      4'hc: char_addr_s[19] = (s0[11:8] < 10)? s0[11:8] + 7'h30 : s0[11:8] + 7'h57;// var
      4'hd: char_addr_s[19] = (s0[7:4] < 10)? s0[7:4] + 7'h30 : s0[7:4] + 7'h57;// var
      4'he: char_addr_s[19] = (s0[3:0] < 10)? s0[3:0] + 7'h30 : s0[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[20] = (s1[31:28] < 10)? s1[31:28] + 7'h30 : s1[31:28] + 7'h57; // var
      4'h8: char_addr_s[20] = (s1[27:24] < 10)? s1[27:24] + 7'h30 : s1[27:24] + 7'h57;// var
      4'h9: char_addr_s[20] = (s1[23:20] < 10)? s1[23:20] + 7'h30 : s1[23:20] + 7'h57;// var
      4'ha: char_addr_s[20] = (s1[19:16] < 10)? s1[19:16] + 7'h30 : s1[19:16] + 7'h57;// var
      4'hb: char_addr_s[20] = (s1[15:12] < 10)? s1[15:12] + 7'h30 : s1[15:12] + 7'h57;// var
      4'hc: char_addr_s[20] = (s1[11:8] < 10)? s1[11:8] + 7'h30 : s1[11:8] + 7'h57;// var
      4'hd: char_addr_s[20] = (s1[7:4] < 10)? s1[7:4] + 7'h30 : s1[7:4] + 7'h57;// var
      4'he: char_addr_s[20] = (s1[3:0] < 10)? s1[3:0] + 7'h30 : s1[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[21] = (s2[31:28] < 10)? s2[31:28] + 7'h30 : s2[31:28] + 7'h57; // var
      4'h8: char_addr_s[21] = (s2[27:24] < 10)? s2[27:24] + 7'h30 : s2[27:24] + 7'h57;// var
      4'h9: char_addr_s[21] = (s2[23:20] < 10)? s2[23:20] + 7'h30 : s2[23:20] + 7'h57;// var
      4'ha: char_addr_s[21] = (s2[19:16] < 10)? s2[19:16] + 7'h30 : s2[19:16] + 7'h57;// var
      4'hb: char_addr_s[21] = (s2[15:12] < 10)? s2[15:12] + 7'h30 : s2[15:12] + 7'h57;// var
      4'hc: char_addr_s[21] = (s2[11:8] < 10)? s2[11:8] + 7'h30 : s2[11:8] + 7'h57;// var
      4'hd: char_addr_s[21] = (s2[7:4] < 10)? s2[7:4] + 7'h30 : s2[7:4] + 7'h57;// var
      4'he: char_addr_s[21] = (s2[3:0] < 10)? s2[3:0] + 7'h30 : s2[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[22] = (s3[31:28] < 10)? s3[31:28] + 7'h30 : s3[31:28] + 7'h57; // var
      4'h8: char_addr_s[22] = (s3[27:24] < 10)? s3[27:24] + 7'h30 : s3[27:24] + 7'h57;// var
      4'h9: char_addr_s[22] = (s3[23:20] < 10)? s3[23:20] + 7'h30 : s3[23:20] + 7'h57;// var
      4'ha: char_addr_s[22] = (s3[19:16] < 10)? s3[19:16] + 7'h30 : s3[19:16] + 7'h57;// var
      4'hb: char_addr_s[22] = (s3[15:12] < 10)? s3[15:12] + 7'h30 : s3[15:12] + 7'h57;// var
      4'hc: char_addr_s[22] = (s3[11:8] < 10)? s3[11:8] + 7'h30 : s3[11:8] + 7'h57;// var
      4'hd: char_addr_s[22] = (s3[7:4] < 10)? s3[7:4] + 7'h30 : s3[7:4] + 7'h57;// var
      4'he: char_addr_s[22] = (s3[3:0] < 10)? s3[3:0] + 7'h30 : s3[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[23] = (s4[31:28] < 10)? s4[31:28] + 7'h30 : s4[31:28] + 7'h57; // var
      4'h8: char_addr_s[23] = (s4[27:24] < 10)? s4[27:24] + 7'h30 : s4[27:24] + 7'h57;// var
      4'h9: char_addr_s[23] = (s4[23:20] < 10)? s4[23:20] + 7'h30 : s4[23:20] + 7'h57;// var
      4'ha: char_addr_s[23] = (s4[19:16] < 10)? s4[19:16] + 7'h30 : s4[19:16] + 7'h57;// var
      4'hb: char_addr_s[23] = (s4[15:12] < 10)? s4[15:12] + 7'h30 : s4[15:12] + 7'h57;// var
      4'hc: char_addr_s[23] = (s4[11:8] < 10)? s4[11:8] + 7'h30 : s4[11:8] + 7'h57;// var
      4'hd: char_addr_s[23] = (s4[7:4] < 10)? s4[7:4] + 7'h30 : s4[7:4] + 7'h57;// var
      4'he: char_addr_s[23] = (s4[3:0] < 10)? s4[3:0] + 7'h30 : s4[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[24] = (s5[31:28] < 10)? s5[31:28] + 7'h30 : s5[31:28] + 7'h57; // var
      4'h8: char_addr_s[24] = (s5[27:24] < 10)? s5[27:24] + 7'h30 : s5[27:24] + 7'h57;// var
      4'h9: char_addr_s[24] = (s5[23:20] < 10)? s5[23:20] + 7'h30 : s5[23:20] + 7'h57;// var
      4'ha: char_addr_s[24] = (s5[19:16] < 10)? s5[19:16] + 7'h30 : s5[19:16] + 7'h57;// var
      4'hb: char_addr_s[24] = (s5[15:12] < 10)? s5[15:12] + 7'h30 : s5[15:12] + 7'h57;// var
      4'hc: char_addr_s[24] = (s5[11:8] < 10)? s5[11:8] + 7'h30 : s5[11:8] + 7'h57;// var
      4'hd: char_addr_s[24] = (s5[7:4] < 10)? s5[7:4] + 7'h30 : s5[7:4] + 7'h57;// var
      4'he: char_addr_s[24] = (s5[3:0] < 10)? s5[3:0] + 7'h30 : s5[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[25] = (s6[31:28] < 10)? s6[31:28] + 7'h30 : s6[31:28] + 7'h57; // var
      4'h8: char_addr_s[25] = (s6[27:24] < 10)? s6[27:24] + 7'h30 : s6[27:24] + 7'h57;// var
      4'h9: char_addr_s[25] = (s6[23:20] < 10)? s6[23:20] + 7'h30 : s6[23:20] + 7'h57;// var
      4'ha: char_addr_s[25] = (s6[19:16] < 10)? s6[19:16] + 7'h30 : s6[19:16] + 7'h57;// var
      4'hb: char_addr_s[25] = (s6[15:12] < 10)? s6[15:12] + 7'h30 : s6[15:12] + 7'h57;// var
      4'hc: char_addr_s[25] = (s6[11:8] < 10)? s6[11:8] + 7'h30 : s6[11:8] + 7'h57;// var
      4'hd: char_addr_s[25] = (s6[7:4] < 10)? s6[7:4] + 7'h30 : s6[7:4] + 7'h57;// var
      4'he: char_addr_s[25] = (s6[3:0] < 10)? s6[3:0] + 7'h30 : s6[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[26] = (s7[31:28] < 10)? s7[31:28] + 7'h30 : s7[31:28] + 7'h57; // var
      4'h8: char_addr_s[26] = (s7[27:24] < 10)? s7[27:24] + 7'h30 : s7[27:24] + 7'h57;// var
      4'h9: char_addr_s[26] = (s7[23:20] < 10)? s7[23:20] + 7'h30 : s7[23:20] + 7'h57;// var
      4'ha: char_addr_s[26] = (s7[19:16] < 10)? s7[19:16] + 7'h30 : s7[19:16] + 7'h57;// var
      4'hb: char_addr_s[26] = (s7[15:12] < 10)? s7[15:12] + 7'h30 : s7[15:12] + 7'h57;// var
      4'hc: char_addr_s[26] = (s7[11:8] < 10)? s7[11:8] + 7'h30 : s7[11:8] + 7'h57;// var
      4'hd: char_addr_s[26] = (s7[7:4] < 10)? s7[7:4] + 7'h30 : s7[7:4] + 7'h57;// var
      4'he: char_addr_s[26] = (s7[3:0] < 10)? s7[3:0] + 7'h30 : s7[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[27] = (t8[31:28] < 10)? t8[31:28] + 7'h30 : t8[31:28] + 7'h57; // var
      4'h8: char_addr_s[27] = (t8[27:24] < 10)? t8[27:24] + 7'h30 : t8[27:24] + 7'h57;// var
      4'h9: char_addr_s[27] = (t8[23:20] < 10)? t8[23:20] + 7'h30 : t8[23:20] + 7'h57;// var
      4'ha: char_addr_s[27] = (t8[19:16] < 10)? t8[19:16] + 7'h30 : t8[19:16] + 7'h57;// var
      4'hb: char_addr_s[27] = (t8[15:12] < 10)? t8[15:12] + 7'h30 : t8[15:12] + 7'h57;// var
      4'hc: char_addr_s[27] = (t8[11:8] < 10)? t8[11:8] + 7'h30 : t8[11:8] + 7'h57;// var
      4'hd: char_addr_s[27] = (t8[7:4] < 10)? t8[7:4] + 7'h30 : t8[7:4] + 7'h57;// var
      4'he: char_addr_s[27] = (t8[3:0] < 10)? t8[3:0] + 7'h30 : t8[3:0] + 7'h57;// var
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
      4'h7: char_addr_s[28] = (t9[31:28] < 10)? t9[31:28] + 7'h30 : t9[31:28] + 7'h57; // var
      4'h8: char_addr_s[28] = (t9[27:24] < 10)? t9[27:24] + 7'h30 : t9[27:24] + 7'h57;// var
      4'h9: char_addr_s[28] = (t9[23:20] < 10)? t9[23:20] + 7'h30 : t9[23:20] + 7'h57;// var
      4'ha: char_addr_s[28] = (t9[19:16] < 10)? t9[19:16] + 7'h30 : t9[19:16] + 7'h57;// var
      4'hb: char_addr_s[28] = (t9[15:12] < 10)? t9[15:12] + 7'h30 : t9[15:12] + 7'h57;// var
      4'hc: char_addr_s[28] = (t9[11:8] < 10)? t9[11:8] + 7'h30 : t9[11:8] + 7'h57;// var
      4'hd: char_addr_s[28] = (t9[7:4] < 10)? t9[7:4] + 7'h30 : t9[7:4] + 7'h57;// var
      4'he: char_addr_s[28] = (t9[3:0] < 10)? t9[3:0] + 7'h30 : t9[3:0] + 7'h57;// var
      4'hf : char_addr_s[28] = 7'h00; // 
   endcase
end

// bottom
assign score_on[13] = (pix_y[9:5] == 14) && (pix_x[9:4] < 16);
assign row_addr_s[13] = pix_y [4:1]; 
assign bit_addr_s[13] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[13] = 7'h73; // s 
      4'h1: char_addr_s[13] = 7'h3a; // :
      4'h2: char_addr_s[13] = 7'h30 + start; // var
      4'h3: char_addr_s[13] = 7'h00; // 
      4'h4: char_addr_s[13] = 7'h72; // r
      4'h5: char_addr_s[13] = 7'h3a; // :
      4'h6: char_addr_s[13] = 7'h30 + resume; // var
      4'h7: char_addr_s[13] = 7'h00; // 
      4'h8: char_addr_s[13] = 7'h63; // c
      4'h9: char_addr_s[13] = 7'h73; // s 
      4'ha: char_addr_s[13] = 7'h3a; // :
      4'hb: char_addr_s[13] = (cs < 10)? cs + 7'h30 : cs + 7'h57;
      4'hc: char_addr_s[13] = 7'h00; // 
      4'hd: char_addr_s[13] = 7'h00; // 
      4'he: char_addr_s[13] = 7'h00; // 
      4'hf : char_addr_s[13] = 7'h00; // 
   endcase
end

assign score_on[29] = (pix_y[9:5] == 14) && (pix_x[9:4] >= 16) && (pix_x[9:4] < 32);
assign row_addr_s[29] = pix_y [4:1]; 
assign bit_addr_s[29] = pix_x [3:1]; 

always @* begin
   case (pix_x [7:4])
      4'h0: char_addr_s[29] = 7'h4d; // M 
      4'h1: char_addr_s[29] = 7'h4f; // O
      4'h2: char_addr_s[29] = 7'h44; // D
      4'h3: char_addr_s[29] = 7'h45; // E
      4'h4: char_addr_s[29] = 7'h3a; // :
      4'h5: char_addr_s[29] = 7'h30 + mode; // var
      4'h6: char_addr_s[29] = 7'h00; // 
      4'h7: char_addr_s[29] = 7'h44; // D
      4'h8: char_addr_s[29] = 7'h4d; // M 
      4'h9: char_addr_s[29] = 7'h44; // D
      4'ha: char_addr_s[29] = 7'h45; // E
      4'hb: char_addr_s[29] = 7'h3a; // :
      4'hc: char_addr_s[29] = 7'h30 + debug_mode; // var
      4'hd: char_addr_s[29] = 7'h00; // 
      4'he: char_addr_s[29] = 7'h00; // 
      4'hf : char_addr_s[29] = 7'h00; // 
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
    else if(score_on[9]) begin
            char_addr = char_addr_s[9];
            row_addr = row_addr_s[9];
            bit_addr = bit_addr_s[9];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    
    else if(score_on[10]) begin
            char_addr = char_addr_s[10];
            row_addr = row_addr_s[10];
            bit_addr = bit_addr_s[10];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[11]) begin
            char_addr = char_addr_s[11];
            row_addr = row_addr_s[11];
            bit_addr = bit_addr_s[11];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[12]) begin
            char_addr = char_addr_s[12];
            row_addr = row_addr_s[12];
            bit_addr = bit_addr_s[12];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[13]) begin
            char_addr = char_addr_s[13];
            row_addr = row_addr_s[13];
            bit_addr = bit_addr_s[13];
            if(font_bit)
                text_rgb = LOG_COLOR;
        end
    else if(score_on[16]) begin
            char_addr = char_addr_s[16];
            row_addr = row_addr_s[16];
            bit_addr = bit_addr_s[16];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[17]) begin
            char_addr = char_addr_s[17];
            row_addr = row_addr_s[17];
            bit_addr = bit_addr_s[17];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[18]) begin
            char_addr = char_addr_s[18];
            row_addr = row_addr_s[18];
            bit_addr = bit_addr_s[18];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[19]) begin
            char_addr = char_addr_s[19];
            row_addr = row_addr_s[19];
            bit_addr = bit_addr_s[19];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[20]) begin
            char_addr = char_addr_s[20];
            row_addr = row_addr_s[20];
            bit_addr = bit_addr_s[20];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[21]) begin
            char_addr = char_addr_s[21];
            row_addr = row_addr_s[21];
            bit_addr = bit_addr_s[21];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[22]) begin
            char_addr = char_addr_s[22];
            row_addr = row_addr_s[22];
            bit_addr = bit_addr_s[22];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[23]) begin
            char_addr = char_addr_s[23];
            row_addr = row_addr_s[23];
            bit_addr = bit_addr_s[23];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[24]) begin
            char_addr = char_addr_s[24];
            row_addr = row_addr_s[24];
            bit_addr = bit_addr_s[24];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[25]) begin
            char_addr = char_addr_s[25];
            row_addr = row_addr_s[25];
            bit_addr = bit_addr_s[25];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[26]) begin
            char_addr = char_addr_s[26];
            row_addr = row_addr_s[26];
            bit_addr = bit_addr_s[26];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[27]) begin
            char_addr = char_addr_s[27];
            row_addr = row_addr_s[27];
            bit_addr = bit_addr_s[27];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[28]) begin
            char_addr = char_addr_s[28];
            row_addr = row_addr_s[28];
            bit_addr = bit_addr_s[28];
            if(font_bit)
                text_rgb = SCORE_COLOR;
        end
    else if(score_on[29]) begin
            char_addr = char_addr_s[29];
            row_addr = row_addr_s[29];
            bit_addr = bit_addr_s[29];
            if(font_bit)
                text_rgb = LOG_COLOR;
        end
end

assign text_on = 1;
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[7-bit_addr]; // MSB display first

endmodule
