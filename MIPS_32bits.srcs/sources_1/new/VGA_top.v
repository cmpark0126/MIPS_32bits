	module VGA_top(
		input CLK100MHZ, reset,
		output VGA_HS, VGA_VS,
		output [11:0] vga,
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
		localparam FONT_BACKGROUND = 12'b1111_1111_1111;

		localparam MONITOR_WIDTH = 640;
		localparam MONITOR_HEIGHT = 480;

		wire video_on;
		wire [1:0] text_on;
		wire pixel_clk;

		wire [9:0] pixel_x, pixel_y;
		reg [11:0] vga_next, vga_reg;
		wire [11:0] text_rgb;

		wire [9:0] bb_x, bb_y;
		reg [9:0] bb_x_reg, bb_x_next;
		reg [9:0] bb_y_reg, bb_y_next;

		assign bb_x = bb_x_reg;
		assign bb_y = bb_y_reg;

		VGA_controller VGA_controller_1(
			.clk(CLK100MHZ), .reset(reset),
			.hsync(VGA_HS), .vsync(VGA_VS),
			.video_on(video_on), .pixel_clk(pixel_clk),
			.pixel_x(pixel_x), .pixel_y(pixel_y)
		);

		text_rom text_rom_VGA(
			.clk(CLK100MHZ),
			.ball(2'd1), .dig0(4'd2), .digl(4'd3),
			.pix_x(pixel_x), .pix_y(pixel_y),
			.font_background(FONT_BACKGROUND),
			.text_on(text_on), .text_rgb(text_rgb),
            .zero(zero),
            .at(at),
            .v0(v0), .v1(v1), 
            .a0(a0), .a1(a1), .a2(a2), .a3(a3),
            .t0(t0), .t1(t1), .t2(t2), .t3(t3),
            .t4(t4), .t5(t5), .t6(t6), .t7(t7),
            .s0(s0), .s1(s1), .s2(s2), .s3(s3),
            .s4(s4), .s5(s5), .s6(s6), .s7(s7),
            .t8(t8), .t9(t9), 
            .k0(k0), .k1(k1), 
            .gp(gp), .sp(sp), .fp(fp), .ra(ra),
            .start(start), .resume(resume), .cs(cs), .mode(mode), .debug_mode(debug_mode) 
		);

		always @(posedge CLK100MHZ, posedge reset) begin
			if(reset)
				vga_reg <= 12'd0;
			else
				if(pixel_clk)
					vga_reg <= vga_next;
		end
	
		always @* begin
			vga_next = vga_reg;
			if(~video_on)
				vga_next = COLOR_BLACK;
			else begin
				if (text_on)
					vga_next = text_rgb;
				else
					vga_next = COLOR_WHITE;
			end
		end

	assign vga = vga_reg;

	endmodule