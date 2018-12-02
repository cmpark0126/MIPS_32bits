`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:48:38
// Design Name: 
// Module Name: top
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

`define DIVISIER 10000000

module top(
    output [6:0] sseg,
    output DP,
    output [7:0]AN,
    input clk, start_signal,
    input [3:0] mode
    );
    
    // for program execution
    wire rst = ~start_signal;
    
    // for clk division
    wire n_clk;
    
    // for state
    wire [3:0] cs, ns;
    
    // for instruction fetch (IF)
    wire [31:0] PC; // after debuging, we need to change reg to wire
//    always@(posedge n_clk or posedge rst) begin
//        if(rst) PC <= 32'd0;
//        else if(cs == 4'd0) PC <= (PC == 32'd12)? 0:PC+4;
//        else PC <= PC;
//    end // for debug
    wire [31:0] PCadd4;
    wire [31:0] instruction;
    wire PC_selector;
    
    // for controller_for_mips_opcode
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;
     
    //for Register (ID, WB)
    wire [31:0] read_data1, read_data2;
    wire [4:0] write_reg;
    wire [31:0] write_data;
    wire [31:0] extended;
    
    //for Execution
    wire [31:0] shifted;
    wire [31:0] selected_data;
    wire [31:0] branched_address;
    wire [3:0] ALU_operation;
    wire [31:0] ALU_result;
    wire ALU_zero;
    
    // for memory read
    wire [31:0] read_data_from_memory;
       
    // for controller_for_debug
    wire [7:0] mask;
    wire [3:0] data7, data6, data5, data4, data3, data2, data1, data0;
    
    clk_div clk_div0(
       .en_out(n_clk),
       .clk(clk), .rst(rst),
       .divided_by(`DIVISIER)
       );
    
    controller_for_state controller_for_state0(
        .cs(cs), .ns(ns),
        .clk(n_clk), .rst(rst)
        );
        
    // IF
    assign PC_selector = ALU_zero & Branch;
    
    Mux_32bits select_next_pc(
        .out(PC),
        .in0(PCadd4),.in1(branched_address),
        .sel(PC_selector) // it will be branch, ALU-zero (and gate)
        );
    
    Instruction_fetch Instruction_fetch0(
        .instruction(instruction),
        .address(PC),
        .cs(cs),
        .clk(n_clk), .rst(rst)
        );
    
    Add4toPC Add4toPC0(
        .outPC(PCadd4),
        .inPC(PC),
        .cs(cs),
        .clk(n_clk), .rst(rst)
        );
        
    // ID    
    controller_for_mips_opcode controller_for_mips_opcode0(
        .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
        .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp),
        .opcode(instruction[31:26])
        );
        
    Mux_5bits select_next_write_register(
        .out(write_reg),
        .in0(instruction[20:16]),.in1(instruction[15:11]),
        .sel(RegDst)
        );
        
    Register Register0( // ID & WB
        .read_data1(read_data1),.read_data2(read_data2),
        .read_reg1(instruction[25:21]),.read_reg2(instruction[20:16]), 
        .write_reg(write_reg), .write_data(write_data),
        .cs(cs),
        .RegWrite(RegWrite),
        .clk(n_clk),.rst(rst)
        );
    
    Sign_extend_16to32bits Sign_extend_16to32bits0(
        .out(extended),
        .in(instruction[15:0])
    );
    
    // EX
    Shift_register_left_2bits Shift_register_left_2bits0(
        .out(shifted),
        .in(extended)
    );
    
    Mux_32bits select_data(
        .out(selected_data),
        .in0(read_data2),.in1(extended),
        .sel(ALUSrc)
        );
    
    Add_32bits add_pc_and_shifted(
        .out(branched_address),
        .in0(PCadd4),.in1(shifted),
        .cs(cs),
        .clk(n_clk), .rst(rst)
        );
    
    ALU_contorl ALU_contorl0(
        .ALU_operation(ALU_operation),
        .Function_field(instruction[5:0]),
        .ALUOp(ALUOp)
        );
    
    ALU ALU0(
        .ALU_result(ALU_result),
        .ALU_zero(ALU_zero),
        .in0(read_data1),.in1(selected_data),
        .ALU_operation(ALU_operation),
        .cs(cs),
        .clk(n_clk), .rst(rst)
        );
        
    // Mem
    Memory_access Memory_access0(
        .read_data_from_memory(read_data_from_memory),
        .address_for_memory(ALU_result),
        .write_data_for_memory(read_data2),
        .cs(cs),
        .MemRead(MemRead), .MemWrite(MemWrite),
        .clk(n_clk), .rst(rst)
        );
    
    Mux_32bits select_write_data(
        .out(write_data),
        .in0(ALU_result),.in1(read_data_from_memory),
        .sel(MemtoReg)
        );
        
    // sseg for Debug
    controller_for_debug controller_for_debug0(
        .mask(mask),
        .data7(data7), .data6(data6), .data5(data5), .data4(data4),
        .data3(data3), .data2(data2), .data1(data1), .data0(data0),
        .mode(mode),
        // state (0)
        .ns(ns), .cs(cs),
        // instruction_fetch (1)
        .instruction(instruction),
        // controller_for_mips_opcode (2)
        .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
        .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp),
        // Register (3)
        .write_reg(write_reg), 
        // Execution1 (4)
        .ALU_operation(ALU_operation),
        // Execution2 (5)
        .ALU_result(ALU_result),
        // clk and rst
        .clk(clk), .rst(rst)
        );

    ss_drive segment(
      .clk(clk), .rst(rst), .mask(mask),
      .data7(data7), .data6(data6), .data5(data5), .data4(data4),
      .data3(data3), .data2(data2), .data1(data1), .data0(data0),
      .ssA(sseg[0]), .ssB(sseg[1]), .ssC(sseg[2]), .ssD(sseg[3]),
      .ssE(sseg[4]), .ssF(sseg[5]), .ssG(sseg[6]), .ssDP(DP),
      .AN7(AN[7]), .AN6(AN[6]), .AN5(AN[5]), .AN4(AN[4]),
      .AN3(AN[3]), .AN2(AN[2]), .AN1(AN[1]), .AN0(AN[0])
      ); 
endmodule
