`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:06:49
// Design Name: 
// Module Name: Data_access
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


module Memory_access(
    output reg [31:0] read_data_from_memory,
    input [31:0] address_for_memory,
    input [31:0] write_data_for_memory,
    input [3:0] cs,
    input MemRead, MemWrite,
    input clk, rst 
    );
    
    parameter MEM = 4'd3;
    
    reg [7:0] BRAM [0:511];
    reg [31:0] temp;
    reg [9:0] ii;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            temp <= 32'd0;
        end
        else if(cs == MEM && MemRead == 1'b1) begin
            temp <= {BRAM[address_for_memory], 
                     BRAM[address_for_memory + 1], 
                     BRAM[address_for_memory + 2], 
                     BRAM[address_for_memory + 3]};
        end
        else if(cs == MEM && MemWrite == 1'b1) begin
            temp <= write_data_for_memory;
        end
        else begin 
            temp <= temp;
        end
    end
    
    always @(negedge clk or posedge rst) begin
        if(rst) begin
            read_data_from_memory <= 32'd0;
            {BRAM[0], BRAM[1], BRAM[2], BRAM[3]} <= 32'h00000001;
            {BRAM[4], BRAM[5], BRAM[6], BRAM[7]} <= 32'h00000003;
            {BRAM[8], BRAM[9], BRAM[10], BRAM[11]} <= 32'h00000005;
            {BRAM[12], BRAM[13], BRAM[14], BRAM[15]} <= 32'h00000007;
            {BRAM[16], BRAM[17], BRAM[18], BRAM[19]} <= 32'h00000009;
            {BRAM[20], BRAM[21], BRAM[22], BRAM[23]} <= 32'h00000005;
            for(ii = 10'd24; ii < 10'd512; ii = ii + 10'd1) BRAM[ii] <= 8'd0;
//            for(ii = 32'd0; ii < 32'd32; ii = ii + 32'd1) BRAM[ii] <= 32'd0;
        end
        else if(cs == MEM && MemRead == 1'b1) begin
            read_data_from_memory <= temp;
            for(ii = 10'd0; ii < 10'd512; ii = ii + 10'd1) BRAM[ii] <= BRAM[ii];
        end
        else if(cs == MEM && MemWrite == 1'b1) begin
            read_data_from_memory <= read_data_from_memory;
            for(ii = 10'd0; ii < address_for_memory; ii = ii + 10'd1) BRAM[ii] <= BRAM[ii];
            {BRAM[address_for_memory], 
             BRAM[address_for_memory + 1], 
             BRAM[address_for_memory + 2], 
             BRAM[address_for_memory + 3]} <= temp;
             for(ii = address_for_memory + 4; ii < 10'd512; ii = ii + 10'd1) BRAM[ii] <= BRAM[ii];
        end
        else begin 
            read_data_from_memory <= read_data_from_memory;
            for(ii = 10'd0; ii < 10'd512; ii = ii + 10'd1) BRAM[ii] <= BRAM[ii];
        end
    end
    
    
endmodule