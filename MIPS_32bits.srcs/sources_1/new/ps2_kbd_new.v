`timescale 1ns / 1ps
//`default_nettype none

`define TIMER_120U_BIT_SIZE 13
`define FRAME_BIT_NUM 11

`define ready_st 'b0
`define ready_ack_st 'b1

`define RELEASE_CODE	'b11110000   // F0
`define EXTENDED_CODE 'b11100000    // E0
`define TIMER_120U_TERMINAL_VAL 6000

module ps2_kbd_new(
    input wire clk,
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
	 input wire read,
    output reg [7:0] scancode,
    output wire data_ready,
    output reg released,
    output reg err_ind
    );
	 
localparam S_H = 2'b00, S_L = 2'b01, S_L2H = 2'b11, S_H2L = 2'b10;

reg [1:0] st,nx_st;
reg [1:0] nx_st2,st2;

reg ps2_clk_d, ps2_clk_s, ps2_data_d, ps2_data_s;
wire ps2_clk_rising_edge, ps2_clk_falling_edge;
wire rst_timer, shift_done;
reg [`FRAME_BIT_NUM - 1 : 0] q;
wire shift;
reg [3:0] bit_cnt;
wire reset_bit_cnt;
wire timer_timeout;
reg [`TIMER_120U_BIT_SIZE-1:0] timer_cnt;
wire got_release;
wire output_strobe;
reg hold_release;
wire extended;
reg hold_extended;
wire err;
reg parity_err,ss_bits_err;
reg p;
reg valid;
reg shift_flag;

// synchronizing asynchronous input signal from ps2 ports 
// ps2 port에서 오는 ps2clk과 ps2dataf 시스템 클락(clk)에 동기화 시켜주는단계
always  @(posedge rst,posedge clk) 
begin : sync_reg
	if(rst == 'b1)
		begin
			ps2_clk_d <= 'b1;
			ps2_data_d <= 'b1;
			ps2_clk_s<= 'b1;
			ps2_data_s <= 'b1;
		end
	else
		begin
			ps2_clk_d <= ps2_clk;
			ps2_data_d <= ps2_data;
			ps2_clk_s <= ps2_clk_d;
			ps2_data_s <= ps2_data_d;
		end
	end

// generate pulse signal of one clock period width that informs ps2clk is rising or falling
// ps2clk 의 rising_edge와 falling edge를 detect, falling edge 일 때 ps2data를 읽는다.
assign ps2_clk_rising_edge = !ps2_clk_s & ps2_clk_d;
assign ps2_clk_falling_edge = !ps2_clk_d & ps2_clk_s;

// 다음 두 always문은 ps2clk의 상태 변화 FSM이다.
// S_L은 ps2clk가 low, S_L2H는 ps2clk이 rising edge, S_H는 ps2clk이 high, S_H2L은 ps2clk이 falling edge인 상태이다.
// ps2clk는 평소에는 high에 있다가 키보드가 눌리면, ps2clk이 시작된다.
// ps2clk ----------------------___---___---___---___---___---___----___------------------
//                             * 키보드가 눌리는순간                       * 키보드를 놓는순간
always @(posedge clk) 
	begin : state_reg
		if(rst == 'b1)
			st <= S_H;
		else
			st <= nx_st;
	end
	
always @(*)
	begin
		(* FULL_CASE, PARALLEL_CASE *)
		case (st) 
			S_L : nx_st = (ps2_clk_rising_edge == 'b1) ? S_L2H : S_L;
			S_L2H : nx_st = S_H;
			S_H : nx_st = (ps2_clk_falling_edge == 'b1) ? S_H2L : S_H;
			S_H2L : nx_st = S_L;
			default : nx_st = S_H;						
		endcase
	end

// output signals for the state machine
assign shift = (st == S_H2L) ? 'b1 : 'b0;
assign rst_timer = (st == S_H2L || st == S_L2H ) ? 'b1 : 'b0;

// bit counter
always @(posedge clk)
	begin 
		if((rst == 'b1) || (shift_done == 'b1))
			bit_cnt <= 4'b0;
		else if(reset_bit_cnt == 'b1) 
			bit_cnt <= 4'b0;
		else if(shift == 'b1)
			bit_cnt <= bit_cnt + 'b1;
	end 


// timer_timeout : ps2clk이 정상적으로 동작하는 경우에는 timer_cnt가 S_H2L 또는 S_L2H 상태에서 reset 되기 때문에 timer_timeout이 의미없다.
// 하지만 ps2clk의 오동작에 의해 ps2clk의 상태를 나타내는 state(st)가 제대로 넘어가지 않으면 timer_cnt가 계속 증가한다.
// ps2clk는 최대 33kHZ로 동작하고 일반적으로는 10kHz~20kHZ로 동작하기 때문에 timer_cnt가 120u이상을 센다면 ps2clk가 오동작하고 있음을 의미한다.
// 이 때는 reset_bit_cnt에 의해 bit_cnt가 reset되어 데이터 수신을 취소한다.
assign timer_timeout = (timer_cnt == `TIMER_120U_TERMINAL_VAL) ? 'b1 : 'b0;
assign reset_bit_cnt = (timer_timeout == 'b1 && st == S_H && ps2_clk_s == 'b1) ? 'b1 : 'b0;

// 120 us timer
always @(posedge clk)
	begin : timer 
		if(rst_timer == 'b1)
			timer_cnt <= 'b0;
		else if(timer_timeout == 'b0)
			timer_cnt <= timer_cnt + 'b1;	
	end

// shift register for SIPO operation (11-bit length)
// ps2clk의 falling edge 때마다 ps2data를 한 bit씩 shift하여 q(11bit: start_bit(1), data_bit(8), parity_bit(1), stop_bit(1))에 채워넣는다.
always @(posedge clk)
	begin : shift_R 
		if(rst == 'b1) 
			q <= 'b0;
		else if(shift == 'b1 ) 
			q <= { ps2_data_s, q[`FRAME_BIT_NUM-1 : 1] };
	end

// shift done: 11bit의 데이터를 모두 전송했을 때, shift_done이 한 클락동안 assert 된다.
assign shift_done = (bit_cnt == `FRAME_BIT_NUM) ? 'b1 : 'b0;
// got_release: 키보드를 놓았으면 release code(F0)이 전송된다. 이를 detect하는 신호이다.
assign got_release = (q[8:1] == `RELEASE_CODE) && (shift_done == 'b1) ? 'b1 : 'b0;
assign extended = (q[8:1] == `EXTENDED_CODE) && (shift_done == 'b1) ? 'b1 : 'b0;
// output_strobe: 키보드를 계속 누르고 있는 상태이다. 키보드를 계속 누르고 있으면 주기적으로 ps2clk가 뛰면서 keyboard로부터 데이터를 받아온다.
assign output_strobe = ((shift_done == 'b1) && (got_release == 'b0) && (extended == 'b0)) ? 'b1 : 'b0;

always @(posedge clk)
	begin : latch_released 
		if( rst == 'b1 || output_strobe == 'b1)
			hold_release <= 'b0;
		else if(got_release == 'b1)
			hold_release <= 'b1;
	end
	
always @(posedge clk)
	begin : latch_extended
		if( rst == 'b1 || output_strobe == 'b1)
			hold_extended <= 'b0;
		else if(extended == 'b1)
			hold_extended <= 'b1;
	end

// state register 
// 다음 두 always문은 data ready에 관한 FSM이다. 
// 키보드가 눌리고 데이터를 읽어오면(output_strobe=1) 데이터가 준비되었다고 알려준다.(ready_st)
// ready_st 상태에서 데이터를 읽었다는 read 신호가 들어오면 다시 ready_ack_st로 간다.
always  @(posedge clk)
	begin : comm_state_reg
		if(rst == 'b1) 
			st2 <= `ready_ack_st;
		else
			st2 <= nx_st2;
	end 
	
always @(st2, output_strobe, read)
	begin 
		(* FULL_CASE, PARALLEL_CASE *)
		case (st2) 
			`ready_ack_st : 
				nx_st2 = (output_strobe == 'b1) ? `ready_st : `ready_ack_st;
			`ready_st :
				nx_st2 = (read == 'b1) ?  `ready_ack_st : `ready_st;
			default : 
				nx_st2 = `ready_ack_st;						
		endcase
	end
	
assign data_ready = (st2 == `ready_st) ? 'b1 : 'b0;

	
// latch the output signals (scan code data)
// keyboard에서 각 키에 해당하는 8bit의 데이터를 보내주면 scancode에 각 키에 해당하는 ascii code를 넣어준다.
always @(posedge clk)
	begin : send_output
		if(rst == 'b1) 
			begin
				scancode = 'b0;
				shift_flag = 'b0;
				released = 'b1;
				err_ind = 'b0;
			end 
		else if(output_strobe == 'b1) // keyborad가 눌려있음
			begin
				scancode = q[8:1];
				released = hold_release;
				err_ind = err;
				if(shift_flag == 'b1) // shift + key
					begin
						valid = 'b1;
						case (q[8:1])
							'h1C : scancode = 'h41; // A
							'h32 : scancode = 'h42; // B
							'h21 : scancode = 'h43; // C
							'h23 : scancode = 'h44; // D
							'h24 : scancode = 'h45; // E
							'h2B : scancode = 'h46; // F
							'h34 : scancode = 'h47; // G
							'h33 : scancode = 'h48; // H
							'h43 : scancode = 'h49; // I
							'h3B : scancode = 'h4A; // J
							'h42 : scancode = 'h4B; // K
							'h4B : scancode = 'h4C; // L
							'h3A : scancode = 'h4D; // M
							'h31 : scancode = 'h4E; // N
							'h44 : scancode = 'h4F; // O
							'h4D : scancode = 'h50; // P
							'h15 : scancode = 'h51; // Q
							'h2D : scancode = 'h52; // R
							'h1B : scancode = 'h53; // S
							'h2C : scancode = 'h54; // T
							'h3C : scancode = 'h55; // U
							'h2A : scancode = 'h56; // V
							'h1D : scancode = 'h57; // W
							'h22 : scancode = 'h58; // X
							'h35 : scancode = 'h59; // Y
							'h1A : scancode = 'h5A; // Z
							
							'h16 : scancode = 'h21; // !
							'h1E : scancode = 'h40; // @
							'h26 : scancode = 'h23; // #
							'h25 : scancode = 'h24; // $
							'h2E : scancode = 'h25; // %
							'h36 : scancode = 'h5E; // ^
							'h3D : scancode = 'h26; // &
							'h3E : scancode = 'h2A; // *
							'h46 : scancode = 'h28; // (
							'h45 : scancode = 'h29; // )
							
							'h0E : scancode = 'h7E; // ~
							'h4E : scancode = 'h5F; // _
							'h55 : scancode = 'h2B; // +
							'h5D : scancode = 'h7C; // |
							'h54 : scancode = 'h7B; // {
							'h5B : scancode = 'h7D; // }
							'h4C : scancode = 'h7A; // :
							'h52 : scancode = 'h22; // "
							'h41 : scancode = 'h3C; // <
							'h49 : scancode = 'h3E; // >
							'h4A : scancode = 'h3F; // ?
							default : 
								begin
									scancode = scancode;
									valid = 'b0;
								end
						endcase
									
						if(hold_release == 'b1) // keyboard에서 손을 뗄 때, shift가 눌려있다면 scancode를 바꾸지 않는다.
							begin
								valid = 'b1;
								case (q[8:1])
									'h12 :
										begin
											shift_flag = 'b0;
											scancode = scancode; 
										end											
									'h59 : 
										begin
											shift_flag = 'b0;
											scancode = scancode;
										end
									default : 
										begin
											scancode = scancode;
											valid = 'b0;
										end
								endcase
							end
					end
				
				/* shift flag == 0 */			
				else if (hold_extended == 'b1)
					begin
						valid = 'b1;
						case (q[8:1])
							'h74 : scancode = 'h90; // right arrow
							'h6B : scancode = 'h91; // left arrow
							'h75 : scancode = 'h92; // up arrow
							'h72 : scancode = 'h93; // down arrow
							
							'h70 : scancode = 'h84; // ins
							'h71 : scancode = 'h85; // del
							'h6C : scancode = 'h86; // home
							'h69 : scancode = 'h87; // end
							'h7D : scancode = 'h88; // page up
							'h7A : scancode = 'h89; // page down
							
							'h4A : scancode = 'h2F; // /
							'h14 : scancode = 'h80; // r_control
							'h11 : scancode = 'h81; // r_alt
							'h5A : scancode = 'h0D; // num_pad ENTER
							
							'h12 : scancode = 'h8A; // print screen
							default : 
								begin
									scancode = scancode;
									valid = 'b0;
								end
						endcase
					end
							
				else
					begin
						valid = 'b1;
						case (q[8:1])
							'h1C : scancode = 'h61; // a
							'h32 : scancode = 'h62; // b
							'h21 : scancode = 'h63; // c
							'h23 : scancode = 'h64; // d
							'h24 : scancode = 'h65; // e
							'h2B : scancode = 'h66; // f
							'h34 : scancode = 'h67; // g
							'h33 : scancode = 'h68; // h
							'h43 : scancode = 'h69; // i
							'h3B : scancode = 'h6A; // j
							'h42 : scancode = 'h6B; // k
							'h4B : scancode = 'h6C; // l
							'h3A : scancode = 'h6D; // m
							'h31 : scancode = 'h6E; // n
							'h44 : scancode = 'h6F; // o
							'h4D : scancode = 'h70; // p
							'h15 : scancode = 'h71; // q
							'h2D : scancode = 'h72; // r
							'h1B : scancode = 'h73; // s
							'h2C : scancode = 'h74; // t
							'h3C : scancode = 'h75; // u
							'h2A : scancode = 'h76; // v
							'h1D : scancode = 'h77; // w
							'h22 : scancode = 'h78; // x
							'h35 : scancode = 'h79; // y
							'h1A : scancode = 'h7A; // z
							
							'h16 : scancode = 'h31; // 1
							'h1E : scancode = 'h32; // 2
							'h26 : scancode = 'h33; // 3
							'h25 : scancode = 'h34; // 4
							'h2E : scancode = 'h35; // 5
							'h36 : scancode = 'h36; // 6
							'h3D : scancode = 'h37; // 7
							'h3E : scancode = 'h38; // 8
							'h46 : scancode = 'h39; // 9
							'h45 : scancode = 'h30; // 0
							
							'h69 : scancode = 'h31; // 1
							'h72 : scancode = 'h32; // 2
							'h7A : scancode = 'h33; // 3
							'h6B : scancode = 'h34; // 4
							'h73 : scancode = 'h35; // 5
							'h74 : scancode = 'h36; // 6
							'h6C : scancode = 'h37; // 7
							'h75 : scancode = 'h38; // 8
							'h7D : scancode = 'h39; // 9
							'h70 : scancode = 'h30; // 0
							
							'h76 : scancode = 'h1B; // ESC
							'h0E : scancode = 'h60; // `
							'h4E : scancode = 'h2D; // -
							'h55 : scancode = 'h3D; // =
							'h5D : scancode = 'h5C; // \
							'h66 : scancode = 'h08; // BACKSPACE
							'h0D : scancode = 'h09; // TAB
							'h5A : scancode = 'h0D; // ENTER
							'h54 : scancode = 'h5B; // [
							'h5B : scancode = 'h5D; // ]
							'h4C : scancode = 'h3B; // ;
							'h52 : scancode = 'h27; // '
							'h41 : scancode = 'h2C; // ,
							'h49 : scancode = 'h2E; // .
							'h4A : scancode = 'h2F; // /
							'h29 : scancode = 'h20; // SPACE
							
							'h14 : scancode = 'h80; // control
							'h11 : scancode = 'h81; // alt
							'h77 : scancode = 'h82; // Num Lock
							'h58 : scancode = 'h83; // Caps
							'h7E : scancode = 'h8B; // scroll lock
							
							// sign in numer pad on right side
							'h71 : scancode = 'h2E; // .
							'h79 : scancode = 'h2B; // +
							'h7C : scancode = 'h2A; // *
							'h7B : scancode = 'h2D; // -
							'hE1 : scancode = 'h8C; // puase/break
							'h12 :						 // shift_on
								begin
									scancode = scancode;
									shift_flag = 'b1;
								end 
							'h59 :						 // shift_on 
								begin
									scancode = scancode;
									shift_flag = 'b1;
								end 
							default : 
								begin
									scancode = scancode;
									valid = 'b0;
								end
						endcase
					end				
			end
		else
			begin
				scancode = scancode;
				err_ind = err_ind;
				released = released;
			end
	end
	
// error cheking part
// keyboard로 부터 전송받은 11bit의 데이터에 error가 있는지를 체크하는 부분
// parity_err(odd parity): keyboard에서는 odd_parity check를 할수 있게 11bit중 1의 개수가 홀수개가 되도록 parity bit을 설정해준다.
// 이때, 전송된 11bit의 데이터에 홀수개의 1이 있으면 error가 없다고 판단한다.
// ss_bits_err: start bit이 '0'인지 stop bitdl '1'인지 check한다.
always @(q)
	begin : err_chk 
		p = q[0] ^ q[1] ^ q[2] ^ q[3] ^ q[4] ^ q[5] ^ q[6] ^ q[7] ^ q[8] ^ q[9] ^ q[10];	
		parity_err = ( p == 'b1) ? 1'b0 : 1'b1;
		ss_bits_err = ( q[0] == 'b1 || q[10] == 'b0) ? 1'b1 : 1'b0;
	end
	
assign err = parity_err || ss_bits_err;

endmodule
