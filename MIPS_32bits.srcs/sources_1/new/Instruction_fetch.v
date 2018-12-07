`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:59:40
// Design Name: 
// Module Name: Instruction_fetch
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


module Instruction_fetch(
    output reg [31:0] instruction,
    input [31:0] address,
    input [3:0] cs,
    input clk, rst 
    );
    
    parameter IF = 4'd0;
    
    /*
    * purpose : Fetch instruction from BRAM(instruction memory)  // instruction <= {BRAM[PC], BRAM[PC + 1], BRAM[PC + 2], BRAM[PC + 3]};
    * psuedo code :
        if posedge clk : fetch value from BRAM and target_address (PC)
        if negedge clk : read fetched value and save to instruction value (output port) 
    */
    
    // for debug
    wire [7:0] BRAM [0:512];
    assign {BRAM[0], BRAM[1], BRAM[2], BRAM[3]}     = 32'h20100000; // addi s0 zero 0x0 
    assign {BRAM[4], BRAM[5], BRAM[6], BRAM[7]}     = 32'h20110014; // addi s1 zero 0x14 
    assign {BRAM[8], BRAM[9], BRAM[10], BRAM[11]}   = 32'h8e280000; // lw $t0, 0($s1)
    assign {BRAM[12], BRAM[13], BRAM[14], BRAM[15]} = 32'h20090001; // addi t1 zero 0x1
    assign {BRAM[16], BRAM[17], BRAM[18], BRAM[19]} = 32'h8e0a0000; // lw $t2, 0($s0)
    assign {BRAM[20], BRAM[21], BRAM[22], BRAM[23]} = 32'h0128682a; // slt $t5, $t1, $t0
    assign {BRAM[24], BRAM[25], BRAM[26], BRAM[27]} = 32'h11A00005; // beq t5 zero EXIT
    assign {BRAM[28], BRAM[29], BRAM[30], BRAM[31]} = 32'h21290001; // addi $t1, $t1, 1 
    assign {BRAM[32], BRAM[33], BRAM[34], BRAM[35]} = 32'h22100004; // addi $s0, $s0, 4
    assign {BRAM[36], BRAM[37], BRAM[38], BRAM[39]} = 32'h8e0e0000; // lw $t6, 0($s0) 
    assign {BRAM[40], BRAM[41], BRAM[42], BRAM[43]} = 32'h014e5020; // add $t2, $t2, $t6 
    assign {BRAM[44], BRAM[45], BRAM[46], BRAM[47]} = 32'h08000005; // j loop
    assign {BRAM[48], BRAM[49], BRAM[50], BRAM[51]} = 32'h00000000; // EXIT
    assign {BRAM[52], BRAM[53], BRAM[54], BRAM[55]} = 32'h2002000A; // addi v0 zero 0xa 
    assign {BRAM[56], BRAM[57], BRAM[58], BRAM[59]} = 32'h0000000c; // SYSCALL
    
    reg [7:0] fetched_value [0:3];
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            fetched_value[0] <= BRAM[address];
            fetched_value[1] <= BRAM[address + 1];
            fetched_value[2] <= BRAM[address + 2];
            fetched_value[3] <= BRAM[address + 3];
        end
        else if(cs == IF) begin
            fetched_value[0] <= BRAM[address];
            fetched_value[1] <= BRAM[address + 1];
            fetched_value[2] <= BRAM[address + 2];
            fetched_value[3] <= BRAM[address + 3];
        end
        else begin 
            fetched_value[0] <= fetched_value[0];
            fetched_value[1] <= fetched_value[1];
            fetched_value[2] <= fetched_value[2];
            fetched_value[3] <= fetched_value[3];
        end
    end
    
    always @(negedge clk or posedge rst) begin // do we need only this part? can we squiz?
        if(rst) instruction <= 32'd0;
        else if(cs == IF) instruction <= {fetched_value[0], fetched_value[1], fetched_value[2], fetched_value[3]};
        else instruction <= instruction;
    end
    
endmodule
