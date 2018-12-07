`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/17 16:50:48
// Design Name: 
// Module Name: VGA_controller
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

module VGA_controller (
    input wire clk, reset, // clk = 100 MHz
    output wire hsync, vsync,
    output wire video_on, pixel_clk,
    output wire [9:0] pixel_x, pixel_y
);
// 640x480 VGA
localparam HD = 640; //horizontal display area
localparam HF = 16; //horizontal front porch
localparam HB = 48; //horizontal back porch
localparam HR = 96; //Hsync width
localparam HTOTAL = HD + HF + HB + HR; //800
localparam VD = 480; //vertical display area
localparam VF = 10; //vertical front porch
localparam VB = 33; //vertical back porch
localparam VR = 2; //Vsync width
localparam VTOTAL = VD + VF + VB + VR; //525

// mod-4 counter
wire [1:0] mod4_next;
reg [1:0] mod4_reg;
always @(posedge clk)
    if(reset)
        mod4_reg <= 1'b0;
    else
        mod4_reg <= mod4_next;

assign mod4_next = mod4_reg + 1 ;
//assign mod4_next = (mod4_reg == 3) ? 0 : mod4_reg +1;

assign pixel_clk = (mod4_reg == 2'b11) ? 1 : 0; // output signal of pixel clock

// Hsync controoler
reg [9:0] h_count_next;
reg [9:0] h_count_reg;
wire h_end;
reg hsync_reg;
wire hsync_next;
always @(posedge clk, posedge reset)
    if(reset) begin
        h_count_reg<= 0;
        hsync_reg <= 0;
    end
    else begin
        h_count_reg <= h_count_next;
        hsync_reg <= hsync_next;
    end

// next state
always @*
    if (pixel_clk)
        if (h_end)
            h_count_next = 0;
        else
            h_count_next = h_count_reg + 1;
    else
        h_count_next = h_count_reg;

assign h_end = (h_count_reg == HTOTAL-1);
assign hsync_next = (h_count_reg >= (HD+HF)) && (h_count_reg <= (HD+HF+HR-1));
assign pixel_x = h_count_reg;
assign hsync = ~hsync_reg;

// Vsync controoler
reg [9:0] v_count_next;
reg [9:0] v_count_reg;
wire v_end;
reg vsync_reg;
wire vsync_next;
reg video_on_reg;
wire video_on_next;

always @(posedge clk, posedge reset)
    if (reset) begin
        v_count_reg <= 0;
        vsync_reg <= 0;
        video_on_reg <= 0;
    end
    else begin
        v_count_reg <= v_count_next;
        vsync_reg <= vsync_next;
        video_on_reg <= video_on_next;
    end

// next state
always @*
    if (pixel_clk && h_end)
        if (v_end)
            v_count_next = 0;
        else
            v_count_next = v_count_reg + 1;
    else
        v_count_next = v_count_reg;

assign v_end = (v_count_reg == VTOTAL-1);
assign vsync_next = (v_count_reg >=(VD+VF) && v_count_reg <=(VD+VF+VR-1) );
assign video_on_next = (h_count_reg < HD) && (v_count_reg < VD);

//assign video_on = (h_count_reg < HD) &&(v_count_reg < VD);
assign pixel_y = v_count_reg;
assign vsync = ~vsync_reg;
assign video_on = video_on_reg;


endmodule
