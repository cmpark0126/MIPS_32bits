`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:00:00
// Design Name: 
// Module Name: Instruction_decode
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


module Register(
    output reg [31:0] read_data1, read_data2,
    input [3:0] read_reg1, read_reg2, write_reg, 
    input [31:0] write_data,
    input [3:0] cs,
    input clk, rst 
    );
    
    parameter ID = 4'd1;
    parameter WB = 4'd4;
    reg [31:0] mips_register_set [0:31];
    reg [31:0] temp1, temp2;
    
    always @(posedge clk or posedge rst) begin
            if(rst) begin
                temp1 <= 32'd0;
                temp2 <= 32'd0;
            end
            else if(cs == ID) begin
                temp1 <= mips_register_set[read_reg1];
                temp2 <= mips_register_set[read_reg2];
            end
            else if(cs == WB) begin
                temp1 <= write_data;
            end
            else begin 
                temp1 <= temp1;
                temp2 <= temp2;
            end
        end
        
        always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
            // should we use rst to reset all register set
            // I think we should not need reset register set.
            // previous value will be considered garbage value
            if(rst) begin 
                mips_register_set[0] <= 32'd0; // for zero register
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
            end
            else if(cs == ID) begin
                read_data1 <= temp1;
                read_data2 <= temp2;
            end 
            else if(cs == WB) begin
                mips_register_set[write_reg] <= (write_reg != 4'd0)? 32'd0 : write_data; // when write_reg is 0, illegal access, so maintain zero
            end
            else ;
        end
    
    
    
endmodule
