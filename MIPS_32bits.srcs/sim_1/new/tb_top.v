`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 20:50:43
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    wire [6:0] sseg;
    wire DP;
    wire [7:0]AN;
    reg [1:0] mode;
    reg clk, rst;
    wire TxD;
    reg PS2_CLK, PS2_DATA;
    wire Released;
    
    top t0(
        .sseg(sseg),
        .DP(DP),
        .AN(AN),
        .clk(clk), .rst(rst),
        .mode(mode[0]), .debug_mode(0), .sseg_mode(mode[1]), .register_number(),
        .Released(Released), .ps2clk(PS2_CLK), .ps2data(PS2_DATA),
        .RxD(), .TxD(TxD)
        );
        
   initial begin
        rst = 1;
        mode = 0;
        #10 rst = 0;
    end
    
    initial begin
        clk = 0;
        forever
            #1 clk = ~clk;
    end
    
    initial begin
        // Initialize Inputs
        PS2_CLK = 1;
        PS2_DATA = 1;

        // Wait 100 ns for global reset to finish
        #100;
        
      #45 PS2_DATA = 0; //START 0
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //1
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //2
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //3
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //4
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //5
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //6
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //7
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //8
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //PARITY 9
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1;// STOP 10
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        // Add stimulus here
        
        #45 PS2_DATA = 0; //START 0
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //1
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //2
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 0; //3
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //4
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //5
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //6
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //7
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //8
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //PARITY 9
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1;// STOP 10
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
    //BRAKE CODE
        #45 PS2_DATA = 0; //START 0
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //1
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //2
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //3
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //4
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //5
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;

        #45 PS2_DATA = 1; //6
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1; //7
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //8
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 0; //PARITY 9
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
        
        #45 PS2_DATA = 1;// STOP 10
        #5 PS2_CLK = 0;
        #50 PS2_CLK = 1;
    end
    
    initial begin
        #20000 $stop;
    end

endmodule
