`timescale 1ns / 1ps

module ss_drive(
    input clk, rst,
    input [3:0] data7, data6, data5, data4,
    input [3:0] data3, data2, data1, data0,
	input [7:0] mask,
    output ssA, ssB, ssC, ssD,
    output ssE, ssF, ssG, ssDP,
    output reg AN7, AN6, AN5, AN4,
    output reg AN3, AN2, AN1, AN0
    );	
	reg [2:0] sel;
	reg [3:0] data;
	integer cnt;
	
	always @(posedge clk or posedge rst)
		if(rst)
            begin
            cnt <= 0;
            sel <= 3'b000;
            end
		else if (cnt < 20000)
			begin
			cnt <= cnt + 1;
			sel <= sel;
			end
		else 
			begin
			cnt <= 0;
			sel <= sel + 1;
			end

	always @(data7,data6,data5,data4,data3, data2, data1, data0, sel, mask) 
	begin
        { AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0 } = 8'b1111_1111;
		case(sel)
			3'b000 : begin   data = data0;   AN0 = 0 | (~mask[0]);   end
			3'b001 : begin   data = data1;   AN1 = 0 | (~mask[1]);   end
            3'b010 : begin   data = data2;   AN2 = 0 | (~mask[2]);   end
            3'b011 : begin   data = data3;   AN3 = 0 | (~mask[3]);   end      
        	3'b100 : begin   data = data4;   AN4 = 0 | (~mask[4]);   end   
            3'b101 : begin   data = data5;   AN5 = 0 | (~mask[5]);   end
            3'b110 : begin   data = data6;   AN6 = 0 | (~mask[6]);   end
            default: begin   data = data7;   AN7 = 0 | (~mask[7]);   end
		endcase
    end
    
	
	ss_decoder data_decode (
    .Din(data), .a(ssA), .b(ssB), .c(ssC), .d(ssD), .e(ssE), .f(ssF), .g(ssG), .dp(ssDP)
    );
endmodule
