	module VGA_top(
		input CLK100MHZ, reset,
		output VGA_HS, VGA_VS,
		output [11:0] vga
		);

		localparam COLOR_WHITE = 12'b1111_1111_1111;
		localparam COLOR_RED = 12'b0000_0000_1111;
		localparam COLOR_BLACK = 12'b0000_0000_0000;
		localparam COLOR_BLUE = 12'b1111_0000_0000;
		localparam FONT_BACKGROUND = 12'b0000_1111_1111;

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
			.text_on(text_on), .text_rgb(text_rgb)
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