/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module mojo_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input cclk,
    output reg spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output reg [3:0] spi_channel,
    input avr_tx,
    output reg avr_rx,
    input avr_rx_busy,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [16-1:0] M_myAlu_out;
  wire [1-1:0] M_myAlu_z;
  wire [1-1:0] M_myAlu_v;
  wire [1-1:0] M_myAlu_n;
  reg [6-1:0] M_myAlu_alufn;
  reg [16-1:0] M_myAlu_a;
  reg [16-1:0] M_myAlu_b;
  alu_1 myAlu (
    .alufn(M_myAlu_alufn),
    .a(M_myAlu_a),
    .b(M_myAlu_b),
    .out(M_myAlu_out),
    .z(M_myAlu_z),
    .v(M_myAlu_v),
    .n(M_myAlu_n)
  );
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_2 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  localparam IDLE_states = 6'd0;
  localparam INPUTA_states = 6'd1;
  localparam INPUTB_states = 6'd2;
  localparam INPUTALUFN_states = 6'd3;
  localparam CALCULATE_states = 6'd4;
  localparam AUTO_states = 6'd5;
  localparam ADD1_states = 6'd6;
  localparam ADD2_states = 6'd7;
  localparam ADD3_states = 6'd8;
  localparam SUB1_states = 6'd9;
  localparam SUB2_states = 6'd10;
  localparam SUB3_states = 6'd11;
  localparam MULT1_states = 6'd12;
  localparam MULT2_states = 6'd13;
  localparam MULT3_states = 6'd14;
  localparam AND1_states = 6'd15;
  localparam AND2_states = 6'd16;
  localparam AND3_states = 6'd17;
  localparam OR1_states = 6'd18;
  localparam OR2_states = 6'd19;
  localparam OR3_states = 6'd20;
  localparam XOR1_states = 6'd21;
  localparam XOR2_states = 6'd22;
  localparam XOR3_states = 6'd23;
  localparam A1_states = 6'd24;
  localparam SHL1_states = 6'd25;
  localparam SHL2_states = 6'd26;
  localparam SHL3_states = 6'd27;
  localparam SHR1_states = 6'd28;
  localparam SHR2_states = 6'd29;
  localparam SHR3_states = 6'd30;
  localparam SHA1_states = 6'd31;
  localparam SHA2_states = 6'd32;
  localparam SHA3_states = 6'd33;
  localparam CPEQ1_states = 6'd34;
  localparam CPEQ2_states = 6'd35;
  localparam CPEQ3_states = 6'd36;
  localparam CPLT1_states = 6'd37;
  localparam CPLT2_states = 6'd38;
  localparam CPLT3_states = 6'd39;
  localparam CPLE1_states = 6'd40;
  localparam CPLE2_states = 6'd41;
  localparam CPLE3_states = 6'd42;
  localparam ROTR_states = 6'd43;
  localparam ROTL_states = 6'd44;
  localparam P_states = 6'd45;
  localparam F_states = 6'd46;
  
  reg [5:0] M_states_d, M_states_q = IDLE_states;
  reg [15:0] M_input_a_d, M_input_a_q = 1'h0;
  reg [15:0] M_input_b_d, M_input_b_q = 1'h0;
  reg [5:0] M_input_alufn_d, M_input_alufn_q = 1'h0;
  reg [26:0] M_counter_d, M_counter_q = 1'h0;
  wire [7-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [16-1:0] M_seg_values;
  multi_seven_seg_3 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  
  always @* begin
    M_states_d = M_states_q;
    M_input_b_d = M_input_b_q;
    M_input_a_d = M_input_a_q;
    M_counter_d = M_counter_q;
    M_input_alufn_d = M_input_alufn_q;
    
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    led = 8'h00;
    io_led = 24'h000000;
    spi_miso = 1'bz;
    spi_channel = 4'bzzzz;
    avr_rx = 1'bz;
    io_seg = 8'hff;
    io_sel = 4'hf;
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
    M_myAlu_a = 1'h0;
    M_myAlu_b = 1'h0;
    M_myAlu_alufn = 1'h0;
    M_seg_values = 16'h0000;
    
    case (M_states_q)
      IDLE_states: begin
        M_seg_values = 16'h0000;
        if (io_button[2+0-:1] == 1'h1) begin
          M_states_d = INPUTA_states;
        end
      end
      CALCULATE_states: begin
        M_seg_values = 16'h000d;
        M_myAlu_a = M_input_a_q;
        M_myAlu_b = M_input_b_q;
        M_myAlu_alufn = M_input_alufn_q;
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
        if (io_button[1+0-:1] == 1'h1) begin
          M_states_d = IDLE_states;
        end
      end
      INPUTA_states: begin
        M_seg_values = 16'h000a;
        io_led[8+0+7-:8] = io_dip[8+7-:8];
        io_led[0+0+7-:8] = io_dip[0+7-:8];
        M_input_a_d = {io_dip[8+0+7-:8], io_dip[0+0+7-:8]};
        if (io_button[4+0-:1] == 1'h1) begin
          M_states_d = INPUTB_states;
        end else begin
          if (io_button[3+0-:1] == 1'h1) begin
            M_states_d = IDLE_states;
          end
        end
      end
      INPUTB_states: begin
        M_seg_values = 16'h000b;
        io_led[8+0+7-:8] = io_dip[8+7-:8];
        io_led[0+0+7-:8] = io_dip[0+7-:8];
        M_input_b_d = {io_dip[8+0+7-:8], io_dip[0+0+7-:8]};
        if (io_button[1+0-:1] == 1'h1) begin
          M_states_d = INPUTALUFN_states;
        end else begin
          if (io_button[3+0-:1] == 1'h1) begin
            M_states_d = IDLE_states;
          end
        end
      end
      INPUTALUFN_states: begin
        M_seg_values = 16'h000c;
        io_led[0+0+5-:6] = io_dip[0+0+5-:6];
        M_input_alufn_d = {io_dip[0+0+5-:6]};
        if (io_button[4+0-:1] == 1'h1) begin
          M_states_d = CALCULATE_states;
        end else begin
          if (io_button[3+0-:1] == 1'h1) begin
            M_states_d = IDLE_states;
          end
        end
      end
      P_states: begin
        M_seg_values = 16'h000e;
      end
      F_states: begin
        M_seg_values = 16'h000f;
      end
      AUTO_states: begin
        M_seg_values = 16'haaaa;
      end
      ADD1_states: begin
        M_seg_values = 16'ha101;
        M_myAlu_alufn = 6'h00;
        M_myAlu_a = 16'h2aaa;
        M_myAlu_b = 16'h1555;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      ADD2_states: begin
        M_seg_values = 16'ha102;
        M_myAlu_alufn = 6'h00;
        M_myAlu_a = 16'haaaa;
        M_myAlu_b = 16'h5555;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      ADD3_states: begin
        M_seg_values = 16'ha103;
        M_myAlu_alufn = 6'h00;
        M_myAlu_a = 16'h7fff;
        M_myAlu_b = 16'h7fff;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SUB1_states: begin
        M_seg_values = 16'ha201;
        M_myAlu_alufn = 6'h01;
        M_myAlu_a = 16'h2aaa;
        M_myAlu_b = 16'h1557;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SUB2_states: begin
        M_seg_values = 16'ha202;
        M_myAlu_alufn = 6'h01;
        M_myAlu_a = 16'haaaa;
        M_myAlu_b = 16'h9455;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SUB3_states: begin
        M_seg_values = 16'ha203;
        M_myAlu_alufn = 6'h01;
        M_myAlu_a = 16'h7fff;
        M_myAlu_b = 16'h800f;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      MULT1_states: begin
        M_seg_values = 16'ha301;
        M_myAlu_alufn = 6'h02;
        M_myAlu_a = 16'h4000;
        M_myAlu_b = 16'h0000;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      MULT2_states: begin
        M_seg_values = 16'ha302;
        M_myAlu_alufn = 6'h02;
        M_myAlu_a = 16'h4000;
        M_myAlu_b = 16'h2000;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      MULT3_states: begin
        M_seg_values = 16'ha303;
        M_myAlu_alufn = 6'h02;
        M_myAlu_a = 16'h0080;
        M_myAlu_b = 16'h0008;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      AND1_states: begin
        M_seg_values = 16'hb101;
        M_myAlu_alufn = 6'h18;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      AND2_states: begin
        M_seg_values = 16'hb102;
        M_myAlu_alufn = 6'h18;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h1c00;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      AND3_states: begin
        M_seg_values = 16'hb103;
        M_myAlu_alufn = 6'h18;
        M_myAlu_a = 16'h9545;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      OR1_states: begin
        M_seg_values = 16'hb201;
        M_myAlu_alufn = 6'h1e;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      OR2_states: begin
        M_seg_values = 16'hb202;
        M_myAlu_alufn = 6'h1e;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h1c00;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      OR3_states: begin
        M_seg_values = 16'hb203;
        M_myAlu_alufn = 6'h1e;
        M_myAlu_a = 16'h9545;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      XOR1_states: begin
        M_seg_values = 16'hb301;
        M_myAlu_alufn = 6'h16;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      XOR2_states: begin
        M_seg_values = 16'hb302;
        M_myAlu_alufn = 6'h16;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h1c00;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      XOR3_states: begin
        M_seg_values = 16'hb303;
        M_myAlu_alufn = 6'h16;
        M_myAlu_a = 16'h9545;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      A1_states: begin
        M_seg_values = 16'hba01;
        M_myAlu_alufn = 6'h1a;
        M_myAlu_a = 16'h9545;
        M_myAlu_b = 16'h0fe5;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHL1_states: begin
        M_seg_values = 16'hd101;
        M_myAlu_alufn = 6'h20;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0001;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHL2_states: begin
        M_seg_values = 16'hd102;
        M_myAlu_alufn = 6'h20;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h000f;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHL3_states: begin
        M_seg_values = 16'hd103;
        M_myAlu_alufn = 6'h20;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0f25;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHR1_states: begin
        M_seg_values = 16'hd201;
        M_myAlu_alufn = 6'h21;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0001;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHR2_states: begin
        M_seg_values = 16'hd202;
        M_myAlu_alufn = 6'h21;
        M_myAlu_a = 16'h9555;
        M_myAlu_b = 16'h000f;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHR3_states: begin
        M_seg_values = 16'hd203;
        M_myAlu_alufn = 6'h21;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0f25;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHA1_states: begin
        M_seg_values = 16'hd301;
        M_myAlu_alufn = 6'h23;
        M_myAlu_a = 16'h1555;
        M_myAlu_b = 16'h0001;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHA2_states: begin
        M_myAlu_alufn = 6'h23;
        M_seg_values = 16'hd302;
        M_myAlu_a = 16'h9555;
        M_myAlu_b = 16'h000f;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      SHA3_states: begin
        M_seg_values = 16'hd303;
        M_myAlu_alufn = 6'h23;
        M_myAlu_a = 16'h9555;
        M_myAlu_b = 16'h0f25;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPEQ1_states: begin
        M_seg_values = 16'hc101;
        M_myAlu_alufn = 6'h33;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'hf6b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPEQ2_states: begin
        M_seg_values = 16'hc102;
        M_myAlu_alufn = 6'h33;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPEQ3_states: begin
        M_seg_values = 16'hc103;
        M_myAlu_a = 16'h76b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        M_myAlu_alufn = 6'h33;
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLT1_states: begin
        M_seg_values = 16'hc201;
        M_myAlu_alufn = 6'h35;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'h76b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLT2_states: begin
        M_seg_values = 16'hc202;
        M_myAlu_alufn = 6'h35;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLT3_states: begin
        M_seg_values = 16'hc203;
        M_myAlu_alufn = 6'h35;
        M_myAlu_a = 16'h76b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLE1_states: begin
        M_seg_values = 16'hc301;
        M_myAlu_alufn = 6'h37;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'h76b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLE2_states: begin
        M_seg_values = 16'hc302;
        M_myAlu_alufn = 6'h37;
        M_myAlu_a = 16'h36b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      CPLE3_states: begin
        M_seg_values = 16'hc303;
        M_myAlu_alufn = 6'h37;
        M_myAlu_a = 16'h76b1;
        M_myAlu_b = 16'h36b1;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      ROTR_states: begin
        M_seg_values = 16'hca01;
        M_myAlu_alufn = 6'h24;
        M_myAlu_a = 16'hff00;
        M_myAlu_b = 16'h0002;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
      ROTL_states: begin
        M_seg_values = 16'hca02;
        M_myAlu_alufn = 6'h25;
        M_myAlu_a = 16'hff00;
        M_myAlu_b = 16'h0002;
        if (io_dip[16+7+0-:1] == 1'h1) begin
          M_myAlu_a = 16'h0001;
        end
        io_led[8+7-:8] = M_myAlu_out[8+7-:8];
        io_led[0+7-:8] = M_myAlu_out[0+7-:8];
      end
    endcase
    if (M_counter_q[0+26-:27] == 1'h0) begin
      
      case (M_states_q)
        IDLE_states: begin
          if (io_button[4+0-:1] == 1'h1) begin
            M_states_d = AUTO_states;
          end
        end
        P_states: begin
          if (M_counter_q == 1'h0) begin
            if (io_button[1+0-:1] == 1'h1) begin
              M_states_d = IDLE_states;
            end
          end
        end
        F_states: begin
          if (M_counter_q == 1'h0) begin
            if (io_button[1+0-:1] == 1'h1) begin
              M_states_d = IDLE_states;
            end
          end
        end
        AUTO_states: begin
          M_states_d = ADD1_states;
        end
        ADD1_states: begin
          if (M_myAlu_out == 16'h3fff) begin
            M_states_d = ADD2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        ADD2_states: begin
          if (M_myAlu_out == 16'hffff) begin
            M_states_d = ADD3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        ADD3_states: begin
          if (M_myAlu_out == 16'hfffe) begin
            M_states_d = SUB1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SUB1_states: begin
          if (M_myAlu_out == 16'h1553) begin
            M_states_d = SUB2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SUB2_states: begin
          if (M_myAlu_out == 16'h1655) begin
            M_states_d = SUB3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SUB3_states: begin
          if (M_myAlu_out == 16'hfff0) begin
            M_states_d = MULT1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        MULT1_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = MULT2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        MULT2_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = MULT3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        MULT3_states: begin
          if (M_myAlu_out == 16'h0400) begin
            M_states_d = AND1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        AND1_states: begin
          if (M_myAlu_out == 16'h0545) begin
            M_states_d = AND2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        AND2_states: begin
          if (M_myAlu_out == 16'h1400) begin
            M_states_d = AND3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        AND3_states: begin
          if (M_myAlu_out == 16'h0545) begin
            M_states_d = OR1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        OR1_states: begin
          if (M_myAlu_out == 16'h1ff5) begin
            M_states_d = OR2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        OR2_states: begin
          if (M_myAlu_out == 16'h1d55) begin
            M_states_d = OR3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        OR3_states: begin
          if (M_myAlu_out == 16'h9fe5) begin
            M_states_d = XOR1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        XOR1_states: begin
          if (M_myAlu_out == 16'h1ab0) begin
            M_states_d = XOR2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        XOR2_states: begin
          if (M_myAlu_out == 16'h0955) begin
            M_states_d = XOR3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        XOR3_states: begin
          if (M_myAlu_out == 16'h9aa0) begin
            M_states_d = A1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        A1_states: begin
          if (M_myAlu_out == 16'h9545) begin
            M_states_d = SHL1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHL1_states: begin
          if (M_myAlu_out == 16'h2aaa) begin
            M_states_d = SHL2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHL2_states: begin
          if (M_myAlu_out == 16'h8000) begin
            M_states_d = SHL3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHL3_states: begin
          if (M_myAlu_out == 16'haaa0) begin
            M_states_d = SHR1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHR1_states: begin
          if (M_myAlu_out == 16'h0aaa) begin
            M_states_d = SHR2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHR2_states: begin
          if (M_myAlu_out == 16'h0001) begin
            M_states_d = SHR3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHR3_states: begin
          if (M_myAlu_out == 16'h00aa) begin
            M_states_d = SHA1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHA1_states: begin
          if (M_myAlu_out == 16'h0aaa) begin
            M_states_d = SHA2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHA2_states: begin
          if (M_myAlu_out == 16'hffff) begin
            M_states_d = SHA3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        SHA3_states: begin
          if (M_myAlu_out == 16'hfcaa) begin
            M_states_d = CPEQ1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPEQ1_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = CPEQ2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPEQ2_states: begin
          if (M_myAlu_out == 16'h0001) begin
            M_states_d = CPEQ3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPEQ3_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = CPLT1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLT1_states: begin
          if (M_myAlu_out == 16'h0001) begin
            M_states_d = CPLT2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLT2_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = CPLT3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLT3_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = CPLE1_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLE1_states: begin
          if (M_myAlu_out == 16'h0001) begin
            M_states_d = CPLE2_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLE2_states: begin
          if (M_myAlu_out == 16'h0001) begin
            M_states_d = CPLE3_states;
          end else begin
            M_states_d = F_states;
          end
        end
        CPLE3_states: begin
          if (M_myAlu_out == 16'h0000) begin
            M_states_d = ROTR_states;
          end else begin
            M_states_d = F_states;
          end
        end
        ROTR_states: begin
          if (M_myAlu_out == 16'h3fc0) begin
            M_states_d = ROTL_states;
          end else begin
            M_states_d = F_states;
          end
        end
        ROTL_states: begin
          if (M_myAlu_out == 16'hfc03) begin
            M_states_d = P_states;
          end else begin
            M_states_d = F_states;
          end
        end
      endcase
    end
    M_counter_d = M_counter_q + 1'h1;
  end
  
  always @(posedge clk) begin
    M_input_a_q <= M_input_a_d;
    M_input_b_q <= M_input_b_d;
    M_input_alufn_q <= M_input_alufn_d;
    M_counter_q <= M_counter_d;
    M_states_q <= M_states_d;
  end
  
endmodule
