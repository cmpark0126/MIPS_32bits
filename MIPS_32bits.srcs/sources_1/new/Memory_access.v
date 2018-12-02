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
    
    reg [7:0] mips_memory_set [0:127];
    reg [31:0] temp;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            temp <= 32'd0;
        end
        else if(cs == MEM && MemRead == 1'b1) begin
            temp <= {mips_memory_set[address_for_memory], 
                     mips_memory_set[address_for_memory + 1], 
                     mips_memory_set[address_for_memory + 2], 
                     mips_memory_set[address_for_memory + 3]};
        end
        else if(cs == MEM && MemWrite == 1'b1) begin
            temp <= write_data_for_memory;
        end
        else begin 
            temp <= temp;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            read_data_from_memory <= 32'd0;
        end
        else if(cs == MEM && MemRead == 1'b1) begin
            read_data_from_memory <= temp;
        end
        else if(cs == MEM && MemWrite == 1'b1) begin
            read_data_from_memory <= read_data_from_memory;
            {mips_memory_set[address_for_memory], 
             mips_memory_set[address_for_memory + 1], 
             mips_memory_set[address_for_memory + 2], 
             mips_memory_set[address_for_memory + 3]} <= temp;
        end
        else begin 
            read_data_from_memory <= read_data_from_memory;
        end
    end
    
    
endmodule
