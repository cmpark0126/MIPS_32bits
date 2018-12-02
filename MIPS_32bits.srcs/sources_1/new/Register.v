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
    input [4:0] read_reg1, read_reg2, write_reg, 
    input [31:0] write_data,
    input [3:0] cs,
    input RegWrite,
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
            else if(cs == WB && RegWrite == 1'b1) begin
                temp1 <= write_data;
                temp2 <= 32'd0;
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
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
                mips_register_set[0] <= 32'd0;
                mips_register_set[1] <= 32'd0;
                mips_register_set[2] <= 32'd0;
                mips_register_set[3] <= 32'd0;
                mips_register_set[4] <= 32'd0;
                mips_register_set[5] <= 32'd0;
                mips_register_set[6] <= 32'd0;
                mips_register_set[7] <= 32'd0;
                mips_register_set[8] <= 32'd0;
                mips_register_set[9] <= 32'd0;
                mips_register_set[10] <= 32'd0;
                mips_register_set[11] <= 32'd0;
                mips_register_set[12] <= 32'd0;
                mips_register_set[13] <= 32'd0;
                mips_register_set[14] <= 32'd0;
                mips_register_set[15] <= 32'd0;
                mips_register_set[16] <= 32'd0;
                mips_register_set[17] <= 32'd1; // for debuging
                mips_register_set[18] <= 32'd2; // for debuging
                mips_register_set[19] <= 32'd3; // for debuging
                mips_register_set[20] <= 32'd0;
                mips_register_set[21] <= 32'd0;
                mips_register_set[22] <= 32'd0;
                mips_register_set[23] <= 32'd0;
                mips_register_set[24] <= 32'd0;
                mips_register_set[25] <= 32'd0;
                mips_register_set[26] <= 32'd0;
                mips_register_set[27] <= 32'd0;
                mips_register_set[28] <= 32'd0;
                mips_register_set[29] <= 32'd0;
                mips_register_set[30] <= 32'd0;
                mips_register_set[31] <= 32'd0;
            end
            else if(cs == ID) begin
                read_data1 <= temp1;
                read_data2 <= temp2;
                mips_register_set[0] <= 32'd0;
                mips_register_set[1] <= mips_register_set[1];
                mips_register_set[2] <= mips_register_set[2];
                mips_register_set[3] <= mips_register_set[3];
                mips_register_set[4] <= mips_register_set[4];
                mips_register_set[5] <= mips_register_set[5];
                mips_register_set[6] <= mips_register_set[6];
                mips_register_set[7] <= mips_register_set[7];
                mips_register_set[8] <= mips_register_set[8];
                mips_register_set[9] <= mips_register_set[9];
                mips_register_set[10] <= mips_register_set[10];
                mips_register_set[11] <= mips_register_set[11];
                mips_register_set[12] <= mips_register_set[12];
                mips_register_set[13] <= mips_register_set[13];
                mips_register_set[14] <= mips_register_set[14];
                mips_register_set[15] <= mips_register_set[15];
                mips_register_set[16] <= mips_register_set[16];
                mips_register_set[17] <= mips_register_set[17];
                mips_register_set[18] <= mips_register_set[18];
                mips_register_set[19] <= mips_register_set[19];
                mips_register_set[20] <= mips_register_set[20];
                mips_register_set[21] <= mips_register_set[21];
                mips_register_set[22] <= mips_register_set[22];
                mips_register_set[23] <= mips_register_set[23];
                mips_register_set[24] <= mips_register_set[24];
                mips_register_set[25] <= mips_register_set[25];
                mips_register_set[26] <= mips_register_set[26];
                mips_register_set[27] <= mips_register_set[27];
                mips_register_set[28] <= mips_register_set[28];
                mips_register_set[29] <= mips_register_set[29];
                mips_register_set[30] <= mips_register_set[30];
                mips_register_set[31] <= mips_register_set[31];
            end 
            else if(cs == WB && RegWrite == 1'b1) begin
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
                mips_register_set[0] <= 32'd0;
                mips_register_set[1] <= (write_reg == 5'd1)? write_data : mips_register_set[1];
                mips_register_set[2] <= (write_reg == 5'd2)? write_data : mips_register_set[2];
                mips_register_set[3] <= (write_reg == 5'd3)? write_data : mips_register_set[3];
                mips_register_set[4] <= (write_reg == 5'd4)? write_data : mips_register_set[4];
                mips_register_set[5] <= (write_reg == 5'd5)? write_data : mips_register_set[5];
                mips_register_set[6] <= (write_reg == 5'd6)? write_data : mips_register_set[6];
                mips_register_set[7] <= (write_reg == 5'd7)? write_data : mips_register_set[7];
                mips_register_set[8] <= (write_reg == 5'd8)? write_data : mips_register_set[8];
                mips_register_set[9] <= (write_reg == 5'd9)? write_data : mips_register_set[9];
                mips_register_set[10] <= (write_reg == 5'd10)? write_data : mips_register_set[10];
                mips_register_set[11] <= (write_reg == 5'd11)? write_data : mips_register_set[11];
                mips_register_set[12] <= (write_reg == 5'd12)? write_data : mips_register_set[12];
                mips_register_set[13] <= (write_reg == 5'd13)? write_data : mips_register_set[13];
                mips_register_set[14] <= (write_reg == 5'd14)? write_data : mips_register_set[14];
                mips_register_set[15] <= (write_reg == 5'd15)? write_data : mips_register_set[15];
                mips_register_set[16] <= (write_reg == 5'd16)? write_data : mips_register_set[16];
                mips_register_set[17] <= (write_reg == 5'd17)? write_data : mips_register_set[17];
                mips_register_set[18] <= (write_reg == 5'd18)? write_data : mips_register_set[18];
                mips_register_set[19] <= (write_reg == 5'd19)? write_data : mips_register_set[19];
                mips_register_set[20] <= (write_reg == 5'd20)? write_data : mips_register_set[20];
                mips_register_set[21] <= (write_reg == 5'd21)? write_data : mips_register_set[21];
                mips_register_set[22] <= (write_reg == 5'd22)? write_data : mips_register_set[22];
                mips_register_set[23] <= (write_reg == 5'd23)? write_data : mips_register_set[23];
                mips_register_set[24] <= (write_reg == 5'd24)? write_data : mips_register_set[24];
                mips_register_set[25] <= (write_reg == 5'd25)? write_data : mips_register_set[25];
                mips_register_set[26] <= (write_reg == 5'd26)? write_data : mips_register_set[26];
                mips_register_set[27] <= (write_reg == 5'd27)? write_data : mips_register_set[27];
                mips_register_set[28] <= (write_reg == 5'd28)? write_data : mips_register_set[28];
                mips_register_set[29] <= (write_reg == 5'd29)? write_data : mips_register_set[29];
                mips_register_set[30] <= (write_reg == 5'd30)? write_data : mips_register_set[30];
                mips_register_set[31] <= (write_reg == 5'd31)? write_data : mips_register_set[31];
//                mips_register_set[write_reg] <= #0 (write_reg != 4'd0)? 32'd0 : write_data; // when write_reg is 0, illegal access, so maintain zero
            end
            else begin
                read_data1 <= 32'd0;
                read_data2 <= 32'd0;
                mips_register_set[0] <= 32'd0;
                mips_register_set[1] <= mips_register_set[1];
                mips_register_set[2] <= mips_register_set[2];
                mips_register_set[3] <= mips_register_set[3];
                mips_register_set[4] <= mips_register_set[4];
                mips_register_set[5] <= mips_register_set[5];
                mips_register_set[6] <= mips_register_set[6];
                mips_register_set[7] <= mips_register_set[7];
                mips_register_set[8] <= mips_register_set[8];
                mips_register_set[9] <= mips_register_set[9];
                mips_register_set[10] <= mips_register_set[10];
                mips_register_set[11] <= mips_register_set[11];
                mips_register_set[12] <= mips_register_set[12];
                mips_register_set[13] <= mips_register_set[13];
                mips_register_set[14] <= mips_register_set[14];
                mips_register_set[15] <= mips_register_set[15];
                mips_register_set[16] <= mips_register_set[16];
                mips_register_set[17] <= mips_register_set[17];
                mips_register_set[18] <= mips_register_set[18];
                mips_register_set[19] <= mips_register_set[19];
                mips_register_set[20] <= mips_register_set[20];
                mips_register_set[21] <= mips_register_set[21];
                mips_register_set[22] <= mips_register_set[22];
                mips_register_set[23] <= mips_register_set[23];
                mips_register_set[24] <= mips_register_set[24];
                mips_register_set[25] <= mips_register_set[25];
                mips_register_set[26] <= mips_register_set[26];
                mips_register_set[27] <= mips_register_set[27];
                mips_register_set[28] <= mips_register_set[28];
                mips_register_set[29] <= mips_register_set[29];
                mips_register_set[30] <= mips_register_set[30];
                mips_register_set[31] <= mips_register_set[31];
            end
            
        end
    
    
    
endmodule
