//
// Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
//
// On Tue Oct 16 11:00:17 EDT 2012
//
// Method conflict info:
// Method: src_get
// Conflict-free: sink_put, newLen_get, length_dwm
// Conflicts: src_get
//
// Method: sink_put
// Conflict-free: src_get, newLen_get, length_dwm
// Conflicts: sink_put
//
// Method: newLen_get
// Conflict-free: src_get, sink_put, length_dwm
// Conflicts: newLen_get
//
// Method: length_dwm
// Conflict-free: src_get, sink_put, newLen_get
// Conflicts: length_dwm
//
//
// Ports:
// Name                         I/O  size props
// src_get                        O    33 reg
// RDY_src_get                    O     1 reg
// RDY_sink_put                   O     1 reg
// newLen_get                     O     9 reg
// RDY_newLen_get                 O     1 reg
// RDY_length_dwm                 O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// sink_put                       I    33 reg
// EN_sink_put                    I     1
// EN_length_dwm                  I     1
// EN_src_get                     I     1
// EN_newLen_get                  I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkBuffer(CLK,
		RST_N,

		EN_src_get,
		src_get,
		RDY_src_get,

		sink_put,
		EN_sink_put,
		RDY_sink_put,

		EN_newLen_get,
		newLen_get,
		RDY_newLen_get,

		EN_length_dwm,
		RDY_length_dwm);
  input  CLK;
  input  RST_N;

  // actionvalue method src_get
  input  EN_src_get;
  output [32 : 0] src_get;
  output RDY_src_get;

  // action method sink_put
  input  [32 : 0] sink_put;
  input  EN_sink_put;
  output RDY_sink_put;

  // actionvalue method newLen_get
  input  EN_newLen_get;
  output [8 : 0] newLen_get;
  output RDY_newLen_get;

  // action method length_dwm
  input  EN_length_dwm;
  output RDY_length_dwm;

  // signals for module outputs
  wire [32 : 0] src_get;
  wire [8 : 0] newLen_get;
  wire RDY_length_dwm, RDY_newLen_get, RDY_sink_put, RDY_src_get;

  // inlined wires
  wire [31 : 0] bram_serverAdapterB_outData_outData$wget;
  wire bram_serverAdapterA_outData_enqData$whas,
       bram_serverAdapterB_outData_enqData$whas,
       bram_serverAdapterB_outData_outData$whas;

  // register accum_value
  reg [7 : 0] accum_value;
  wire [7 : 0] accum_value$D_IN;
  wire accum_value$EN;

  // register bram_serverAdapterA_cnt
  reg [2 : 0] bram_serverAdapterA_cnt;
  wire [2 : 0] bram_serverAdapterA_cnt$D_IN;
  wire bram_serverAdapterA_cnt$EN;

  // register bram_serverAdapterA_s1
  reg [1 : 0] bram_serverAdapterA_s1;
  wire [1 : 0] bram_serverAdapterA_s1$D_IN;
  wire bram_serverAdapterA_s1$EN;

  // register bram_serverAdapterB_cnt
  reg [2 : 0] bram_serverAdapterB_cnt;
  wire [2 : 0] bram_serverAdapterB_cnt$D_IN;
  wire bram_serverAdapterB_cnt$EN;

  // register bram_serverAdapterB_s1
  reg [1 : 0] bram_serverAdapterB_s1;
  wire [1 : 0] bram_serverAdapterB_s1$D_IN;
  wire bram_serverAdapterB_s1$EN;

  // register countRd
  reg [8 : 0] countRd;
  wire [8 : 0] countRd$D_IN;
  wire countRd$EN;

  // register countRdReq
  reg [8 : 0] countRdReq;
  wire [8 : 0] countRdReq$D_IN;
  wire countRdReq$EN;

  // register countWrd
  reg [8 : 0] countWrd;
  wire [8 : 0] countWrd$D_IN;
  wire countWrd$EN;

  // register newMsg
  reg newMsg;
  wire newMsg$D_IN, newMsg$EN;

  // register readAddr
  reg [8 : 0] readAddr;
  wire [8 : 0] readAddr$D_IN;
  wire readAddr$EN;

  // register writeAddr
  reg [8 : 0] writeAddr;
  wire [8 : 0] writeAddr$D_IN;
  wire writeAddr$EN;

  // ports of submodule bram_memory
  wire [31 : 0] bram_memory$DIA,
		bram_memory$DIB,
		bram_memory$DOA,
		bram_memory$DOB;
  wire [8 : 0] bram_memory$ADDRA, bram_memory$ADDRB;
  wire bram_memory$ENA, bram_memory$ENB, bram_memory$WEA, bram_memory$WEB;

  // ports of submodule bram_serverAdapterA_outDataCore
  wire [31 : 0] bram_serverAdapterA_outDataCore$D_IN;
  wire bram_serverAdapterA_outDataCore$CLR,
       bram_serverAdapterA_outDataCore$DEQ,
       bram_serverAdapterA_outDataCore$EMPTY_N,
       bram_serverAdapterA_outDataCore$ENQ,
       bram_serverAdapterA_outDataCore$FULL_N;

  // ports of submodule bram_serverAdapterB_outDataCore
  wire [31 : 0] bram_serverAdapterB_outDataCore$D_IN,
		bram_serverAdapterB_outDataCore$D_OUT;
  wire bram_serverAdapterB_outDataCore$CLR,
       bram_serverAdapterB_outDataCore$DEQ,
       bram_serverAdapterB_outDataCore$EMPTY_N,
       bram_serverAdapterB_outDataCore$ENQ,
       bram_serverAdapterB_outDataCore$FULL_N;

  // ports of submodule lenF
  wire [8 : 0] lenF$D_IN, lenF$D_OUT;
  wire lenF$CLR, lenF$DEQ, lenF$EMPTY_N, lenF$ENQ, lenF$FULL_N;

  // ports of submodule mesgInF
  wire [32 : 0] mesgInF$D_IN, mesgInF$D_OUT;
  wire mesgInF$CLR, mesgInF$DEQ, mesgInF$EMPTY_N, mesgInF$ENQ, mesgInF$FULL_N;

  // ports of submodule mesgOutF
  wire [32 : 0] mesgOutF$D_IN, mesgOutF$D_OUT;
  wire mesgOutF$CLR,
       mesgOutF$DEQ,
       mesgOutF$EMPTY_N,
       mesgOutF$ENQ,
       mesgOutF$FULL_N;

  // ports of submodule msgF
  wire [8 : 0] msgF$D_IN, msgF$D_OUT;
  wire msgF$CLR, msgF$DEQ, msgF$EMPTY_N, msgF$ENQ, msgF$FULL_N;

  // rule scheduling signals
  wire CAN_FIRE_RL_accum_accumulate,
       CAN_FIRE_RL_bram_serverAdapterA_cnt_finalAdd,
       CAN_FIRE_RL_bram_serverAdapterA_moveToOutFIFO,
       CAN_FIRE_RL_bram_serverAdapterA_outData_deqOnly,
       CAN_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq,
       CAN_FIRE_RL_bram_serverAdapterA_outData_enqOnly,
       CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstCore,
       CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq,
       CAN_FIRE_RL_bram_serverAdapterA_overRun,
       CAN_FIRE_RL_bram_serverAdapterA_s1__dreg_update,
       CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways,
       CAN_FIRE_RL_bram_serverAdapterB_cnt_finalAdd,
       CAN_FIRE_RL_bram_serverAdapterB_moveToOutFIFO,
       CAN_FIRE_RL_bram_serverAdapterB_outData_deqOnly,
       CAN_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq,
       CAN_FIRE_RL_bram_serverAdapterB_outData_enqOnly,
       CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstCore,
       CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq,
       CAN_FIRE_RL_bram_serverAdapterB_overRun,
       CAN_FIRE_RL_bram_serverAdapterB_s1__dreg_update,
       CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways,
       CAN_FIRE_RL_newLength,
       CAN_FIRE_RL_readBRAM,
       CAN_FIRE_RL_readReqBRAM,
       CAN_FIRE_RL_writeBRAM,
       CAN_FIRE_length_dwm,
       CAN_FIRE_newLen_get,
       CAN_FIRE_sink_put,
       CAN_FIRE_src_get,
       WILL_FIRE_RL_accum_accumulate,
       WILL_FIRE_RL_bram_serverAdapterA_cnt_finalAdd,
       WILL_FIRE_RL_bram_serverAdapterA_moveToOutFIFO,
       WILL_FIRE_RL_bram_serverAdapterA_outData_deqOnly,
       WILL_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq,
       WILL_FIRE_RL_bram_serverAdapterA_outData_enqOnly,
       WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstCore,
       WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq,
       WILL_FIRE_RL_bram_serverAdapterA_overRun,
       WILL_FIRE_RL_bram_serverAdapterA_s1__dreg_update,
       WILL_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways,
       WILL_FIRE_RL_bram_serverAdapterB_cnt_finalAdd,
       WILL_FIRE_RL_bram_serverAdapterB_moveToOutFIFO,
       WILL_FIRE_RL_bram_serverAdapterB_outData_deqOnly,
       WILL_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq,
       WILL_FIRE_RL_bram_serverAdapterB_outData_enqOnly,
       WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstCore,
       WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq,
       WILL_FIRE_RL_bram_serverAdapterB_overRun,
       WILL_FIRE_RL_bram_serverAdapterB_s1__dreg_update,
       WILL_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways,
       WILL_FIRE_RL_newLength,
       WILL_FIRE_RL_readBRAM,
       WILL_FIRE_RL_readReqBRAM,
       WILL_FIRE_RL_writeBRAM,
       WILL_FIRE_length_dwm,
       WILL_FIRE_newLen_get,
       WILL_FIRE_sink_put,
       WILL_FIRE_src_get;

  // remaining internal signals
  wire [8 : 0] msgF_first__51_MINUS_1___d192;
  wire [7 : 0] x__h817, y__h818, y__h820;
  wire [2 : 0] bram_serverAdapterB_cnt_4_PLUS_IF_bram_serverA_ETC___d100;
  wire countRdReq_50_EQ_msgF_first__51_MINUS_1_58___d212,
       countRd_73_EQ_msgF_first__51_MINUS_1_58___d205;

  // actionvalue method src_get
  assign src_get = mesgOutF$D_OUT ;
  assign RDY_src_get = mesgOutF$EMPTY_N ;
  assign CAN_FIRE_src_get = mesgOutF$EMPTY_N ;
  assign WILL_FIRE_src_get = EN_src_get ;

  // action method sink_put
  assign RDY_sink_put = mesgInF$FULL_N ;
  assign CAN_FIRE_sink_put = mesgInF$FULL_N ;
  assign WILL_FIRE_sink_put = EN_sink_put ;

  // actionvalue method newLen_get
  assign newLen_get = lenF$D_OUT ;
  assign RDY_newLen_get = lenF$EMPTY_N ;
  assign CAN_FIRE_newLen_get = lenF$EMPTY_N ;
  assign WILL_FIRE_newLen_get = EN_newLen_get ;

  // action method length_dwm
  assign RDY_length_dwm = msgF$EMPTY_N ;
  assign CAN_FIRE_length_dwm = msgF$EMPTY_N ;
  assign WILL_FIRE_length_dwm = EN_length_dwm ;

  // submodule bram_memory
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd32),
	  .MEMSIZE(10'd512)) bram_memory(.CLKA(CLK),
					 .CLKB(CLK),
					 .ADDRA(bram_memory$ADDRA),
					 .ADDRB(bram_memory$ADDRB),
					 .DIA(bram_memory$DIA),
					 .DIB(bram_memory$DIB),
					 .WEA(bram_memory$WEA),
					 .WEB(bram_memory$WEB),
					 .ENA(bram_memory$ENA),
					 .ENB(bram_memory$ENB),
					 .DOA(bram_memory$DOA),
					 .DOB(bram_memory$DOB));

  // submodule bram_serverAdapterA_outDataCore
  SizedFIFO #(.p1width(32'd32),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) bram_serverAdapterA_outDataCore(.RST(RST_N),
							       .CLK(CLK),
							       .D_IN(bram_serverAdapterA_outDataCore$D_IN),
							       .ENQ(bram_serverAdapterA_outDataCore$ENQ),
							       .DEQ(bram_serverAdapterA_outDataCore$DEQ),
							       .CLR(bram_serverAdapterA_outDataCore$CLR),
							       .D_OUT(),
							       .FULL_N(bram_serverAdapterA_outDataCore$FULL_N),
							       .EMPTY_N(bram_serverAdapterA_outDataCore$EMPTY_N));

  // submodule bram_serverAdapterB_outDataCore
  SizedFIFO #(.p1width(32'd32),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) bram_serverAdapterB_outDataCore(.RST(RST_N),
							       .CLK(CLK),
							       .D_IN(bram_serverAdapterB_outDataCore$D_IN),
							       .ENQ(bram_serverAdapterB_outDataCore$ENQ),
							       .DEQ(bram_serverAdapterB_outDataCore$DEQ),
							       .CLR(bram_serverAdapterB_outDataCore$CLR),
							       .D_OUT(bram_serverAdapterB_outDataCore$D_OUT),
							       .FULL_N(bram_serverAdapterB_outDataCore$FULL_N),
							       .EMPTY_N(bram_serverAdapterB_outDataCore$EMPTY_N));

  // submodule lenF
  FIFO2 #(.width(32'd9), .guarded(32'd1)) lenF(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(lenF$D_IN),
					       .ENQ(lenF$ENQ),
					       .DEQ(lenF$DEQ),
					       .CLR(lenF$CLR),
					       .D_OUT(lenF$D_OUT),
					       .FULL_N(lenF$FULL_N),
					       .EMPTY_N(lenF$EMPTY_N));

  // submodule mesgInF
  FIFO2 #(.width(32'd33), .guarded(32'd1)) mesgInF(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(mesgInF$D_IN),
						   .ENQ(mesgInF$ENQ),
						   .DEQ(mesgInF$DEQ),
						   .CLR(mesgInF$CLR),
						   .D_OUT(mesgInF$D_OUT),
						   .FULL_N(mesgInF$FULL_N),
						   .EMPTY_N(mesgInF$EMPTY_N));

  // submodule mesgOutF
  FIFO2 #(.width(32'd33), .guarded(32'd1)) mesgOutF(.RST(RST_N),
						    .CLK(CLK),
						    .D_IN(mesgOutF$D_IN),
						    .ENQ(mesgOutF$ENQ),
						    .DEQ(mesgOutF$DEQ),
						    .CLR(mesgOutF$CLR),
						    .D_OUT(mesgOutF$D_OUT),
						    .FULL_N(mesgOutF$FULL_N),
						    .EMPTY_N(mesgOutF$EMPTY_N));

  // submodule msgF
  FIFO1 #(.width(32'd9), .guarded(32'd1)) msgF(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(msgF$D_IN),
					       .ENQ(msgF$ENQ),
					       .DEQ(msgF$DEQ),
					       .CLR(msgF$CLR),
					       .D_OUT(msgF$D_OUT),
					       .FULL_N(msgF$FULL_N),
					       .EMPTY_N(msgF$EMPTY_N));

  // rule RL_writeBRAM
  assign CAN_FIRE_RL_writeBRAM =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;
  assign WILL_FIRE_RL_writeBRAM =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;

  // rule RL_readReqBRAM
  assign CAN_FIRE_RL_readReqBRAM =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;
  assign WILL_FIRE_RL_readReqBRAM =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;

  // rule RL_newLength
  assign CAN_FIRE_RL_newLength = msgF$EMPTY_N && lenF$FULL_N && newMsg ;
  assign WILL_FIRE_RL_newLength = CAN_FIRE_RL_newLength ;

  // rule RL_accum_accumulate
  assign CAN_FIRE_RL_accum_accumulate = 1'd1 ;
  assign WILL_FIRE_RL_accum_accumulate = 1'd1 ;

  // rule RL_bram_serverAdapterA_stageReadResponseAlways
  assign CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways =
	     mesgInF$EMPTY_N && (bram_serverAdapterA_cnt ^ 3'h4) < 3'd7 &&
	     (!mesgInF$D_OUT[32] || msgF$FULL_N) ;
  assign WILL_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;

  // rule RL_bram_serverAdapterA_moveToOutFIFO
  assign CAN_FIRE_RL_bram_serverAdapterA_moveToOutFIFO =
	     (!bram_serverAdapterA_s1[0] ||
	      bram_serverAdapterA_outDataCore$FULL_N) &&
	     bram_serverAdapterA_s1[1] ;
  assign WILL_FIRE_RL_bram_serverAdapterA_moveToOutFIFO =
	     CAN_FIRE_RL_bram_serverAdapterA_moveToOutFIFO ;

  // rule RL_bram_serverAdapterA_overRun
  assign CAN_FIRE_RL_bram_serverAdapterA_overRun =
	     bram_serverAdapterA_s1[1] &&
	     !bram_serverAdapterA_outDataCore$FULL_N ;
  assign WILL_FIRE_RL_bram_serverAdapterA_overRun =
	     CAN_FIRE_RL_bram_serverAdapterA_overRun ;

  // rule RL_bram_serverAdapterA_outData_setFirstCore
  assign CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstCore =
	     bram_serverAdapterA_outDataCore$EMPTY_N ;
  assign WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstCore =
	     bram_serverAdapterA_outDataCore$EMPTY_N ;

  // rule RL_bram_serverAdapterA_outData_setFirstEnq
  assign CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq =
	     !bram_serverAdapterA_outDataCore$EMPTY_N &&
	     bram_serverAdapterA_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq =
	     CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq ;

  // rule RL_bram_serverAdapterA_outData_enqOnly
  assign CAN_FIRE_RL_bram_serverAdapterA_outData_enqOnly =
	     bram_serverAdapterA_outDataCore$FULL_N &&
	     bram_serverAdapterA_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterA_outData_enqOnly =
	     CAN_FIRE_RL_bram_serverAdapterA_outData_enqOnly ;

  // rule RL_bram_serverAdapterA_outData_deqOnly
  assign CAN_FIRE_RL_bram_serverAdapterA_outData_deqOnly = 1'b0 ;
  assign WILL_FIRE_RL_bram_serverAdapterA_outData_deqOnly = 1'b0 ;

  // rule RL_bram_serverAdapterA_outData_enqAndDeq
  assign CAN_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq = 1'b0 ;
  assign WILL_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq = 1'b0 ;

  // rule RL_bram_serverAdapterA_cnt_finalAdd
  assign CAN_FIRE_RL_bram_serverAdapterA_cnt_finalAdd = 1'b0 ;
  assign WILL_FIRE_RL_bram_serverAdapterA_cnt_finalAdd = 1'b0 ;

  // rule RL_bram_serverAdapterA_s1__dreg_update
  assign CAN_FIRE_RL_bram_serverAdapterA_s1__dreg_update = 1'd1 ;
  assign WILL_FIRE_RL_bram_serverAdapterA_s1__dreg_update = 1'd1 ;

  // rule RL_bram_serverAdapterB_stageReadResponseAlways
  assign CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways =
	     msgF$EMPTY_N && (bram_serverAdapterB_cnt ^ 3'h4) < 3'd7 &&
	     countRdReq < msgF$D_OUT &&
	     accum_value != 8'd0 ;
  assign WILL_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;

  // rule RL_bram_serverAdapterB_moveToOutFIFO
  assign CAN_FIRE_RL_bram_serverAdapterB_moveToOutFIFO =
	     (!bram_serverAdapterB_s1[0] ||
	      bram_serverAdapterB_outDataCore$FULL_N) &&
	     bram_serverAdapterB_s1[1] ;
  assign WILL_FIRE_RL_bram_serverAdapterB_moveToOutFIFO =
	     CAN_FIRE_RL_bram_serverAdapterB_moveToOutFIFO ;

  // rule RL_bram_serverAdapterB_overRun
  assign CAN_FIRE_RL_bram_serverAdapterB_overRun =
	     bram_serverAdapterB_s1[1] &&
	     !bram_serverAdapterB_outDataCore$FULL_N ;
  assign WILL_FIRE_RL_bram_serverAdapterB_overRun =
	     CAN_FIRE_RL_bram_serverAdapterB_overRun ;

  // rule RL_bram_serverAdapterB_outData_setFirstCore
  assign CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstCore =
	     bram_serverAdapterB_outDataCore$EMPTY_N ;
  assign WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstCore =
	     bram_serverAdapterB_outDataCore$EMPTY_N ;

  // rule RL_bram_serverAdapterB_outData_setFirstEnq
  assign CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq =
	     !bram_serverAdapterB_outDataCore$EMPTY_N &&
	     bram_serverAdapterB_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq =
	     CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq ;

  // rule RL_readBRAM
  assign CAN_FIRE_RL_readBRAM =
	     msgF$EMPTY_N &&
	     (bram_serverAdapterB_outDataCore$EMPTY_N ||
	      bram_serverAdapterB_outData_enqData$whas) &&
	     mesgOutF$FULL_N &&
	     bram_serverAdapterB_outData_outData$whas ;
  assign WILL_FIRE_RL_readBRAM = CAN_FIRE_RL_readBRAM ;

  // rule RL_bram_serverAdapterB_outData_enqOnly
  assign CAN_FIRE_RL_bram_serverAdapterB_outData_enqOnly =
	     bram_serverAdapterB_outDataCore$FULL_N &&
	     !CAN_FIRE_RL_readBRAM &&
	     bram_serverAdapterB_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterB_outData_enqOnly =
	     CAN_FIRE_RL_bram_serverAdapterB_outData_enqOnly ;

  // rule RL_bram_serverAdapterB_outData_deqOnly
  assign CAN_FIRE_RL_bram_serverAdapterB_outData_deqOnly =
	     bram_serverAdapterB_outDataCore$EMPTY_N &&
	     CAN_FIRE_RL_readBRAM &&
	     !bram_serverAdapterB_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterB_outData_deqOnly =
	     CAN_FIRE_RL_bram_serverAdapterB_outData_deqOnly ;

  // rule RL_bram_serverAdapterB_outData_enqAndDeq
  assign CAN_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq =
	     bram_serverAdapterB_outDataCore$EMPTY_N &&
	     bram_serverAdapterB_outDataCore$FULL_N &&
	     CAN_FIRE_RL_readBRAM &&
	     bram_serverAdapterB_outData_enqData$whas ;
  assign WILL_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq =
	     CAN_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq ;

  // rule RL_bram_serverAdapterB_cnt_finalAdd
  assign CAN_FIRE_RL_bram_serverAdapterB_cnt_finalAdd =
	     WILL_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ||
	     CAN_FIRE_RL_readBRAM ;
  assign WILL_FIRE_RL_bram_serverAdapterB_cnt_finalAdd =
	     CAN_FIRE_RL_bram_serverAdapterB_cnt_finalAdd ;

  // rule RL_bram_serverAdapterB_s1__dreg_update
  assign CAN_FIRE_RL_bram_serverAdapterB_s1__dreg_update = 1'd1 ;
  assign WILL_FIRE_RL_bram_serverAdapterB_s1__dreg_update = 1'd1 ;

  // inlined wires
  assign bram_serverAdapterA_outData_enqData$whas =
	     WILL_FIRE_RL_bram_serverAdapterA_moveToOutFIFO &&
	     bram_serverAdapterA_s1[0] ;
  assign bram_serverAdapterB_outData_enqData$whas =
	     WILL_FIRE_RL_bram_serverAdapterB_moveToOutFIFO &&
	     bram_serverAdapterB_s1[0] ;
  assign bram_serverAdapterB_outData_outData$wget =
	     bram_serverAdapterB_outDataCore$EMPTY_N ?
	       bram_serverAdapterB_outDataCore$D_OUT :
	       bram_memory$DOB ;
  assign bram_serverAdapterB_outData_outData$whas =
	     bram_serverAdapterB_outDataCore$EMPTY_N ||
	     WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq ;

  // register accum_value
  assign accum_value$D_IN = x__h817 + y__h818 ;
  assign accum_value$EN = 1'd1 ;

  // register bram_serverAdapterA_cnt
  assign bram_serverAdapterA_cnt$D_IN =
	     bram_serverAdapterA_cnt + 3'd0 + 3'd0 ;
  assign bram_serverAdapterA_cnt$EN = 1'b0 ;

  // register bram_serverAdapterA_s1
  assign bram_serverAdapterA_s1$D_IN =
	     { CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways,
	       1'b0 } ;
  assign bram_serverAdapterA_s1$EN = 1'd1 ;

  // register bram_serverAdapterB_cnt
  assign bram_serverAdapterB_cnt$D_IN =
	     bram_serverAdapterB_cnt_4_PLUS_IF_bram_serverA_ETC___d100 ;
  assign bram_serverAdapterB_cnt$EN =
	     CAN_FIRE_RL_bram_serverAdapterB_cnt_finalAdd ;

  // register bram_serverAdapterB_s1
  assign bram_serverAdapterB_s1$D_IN =
	     { CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways,
	       1'b1 } ;
  assign bram_serverAdapterB_s1$EN = 1'd1 ;

  // register countRd
  assign countRd$D_IN =
	     countRd_73_EQ_msgF_first__51_MINUS_1_58___d205 ?
	       9'd0 :
	       countRd + 9'd1 ;
  assign countRd$EN = CAN_FIRE_RL_readBRAM ;

  // register countRdReq
  assign countRdReq$D_IN =
	     countRdReq_50_EQ_msgF_first__51_MINUS_1_58___d212 ?
	       9'd0 :
	       countRdReq + 9'd1 ;
  assign countRdReq$EN =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;

  // register countWrd
  assign countWrd$D_IN = mesgInF$D_OUT[32] ? 9'd1 : countWrd + 9'd1 ;
  assign countWrd$EN =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;

  // register newMsg
  assign newMsg$D_IN = EN_length_dwm ;
  assign newMsg$EN = WILL_FIRE_RL_newLength || EN_length_dwm ;

  // register readAddr
  assign readAddr$D_IN =
	     countRdReq_50_EQ_msgF_first__51_MINUS_1_58___d212 ?
	       { ~readAddr[8], 8'd0 } :
	       readAddr + 9'd1 ;
  assign readAddr$EN =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;

  // register writeAddr
  assign writeAddr$D_IN =
	     mesgInF$D_OUT[32] ? { ~writeAddr[8], 8'd0 } : writeAddr + 9'd1 ;
  assign writeAddr$EN =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;

  // submodule bram_memory
  assign bram_memory$ADDRA = writeAddr ;
  assign bram_memory$ADDRB = readAddr ;
  assign bram_memory$DIA = mesgInF$D_OUT[31:0] ;
  assign bram_memory$DIB = 32'd0 ;
  assign bram_memory$WEA = 1'd1 ;
  assign bram_memory$WEB = 1'd0 ;
  assign bram_memory$ENA =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ;
  assign bram_memory$ENB =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ;

  // submodule bram_serverAdapterA_outDataCore
  assign bram_serverAdapterA_outDataCore$D_IN = bram_memory$DOA ;
  assign bram_serverAdapterA_outDataCore$ENQ =
	     WILL_FIRE_RL_bram_serverAdapterA_outData_enqOnly ;
  assign bram_serverAdapterA_outDataCore$DEQ = 1'b0 ;
  assign bram_serverAdapterA_outDataCore$CLR = 1'b0 ;

  // submodule bram_serverAdapterB_outDataCore
  assign bram_serverAdapterB_outDataCore$D_IN = bram_memory$DOB ;
  assign bram_serverAdapterB_outDataCore$ENQ =
	     WILL_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq ||
	     WILL_FIRE_RL_bram_serverAdapterB_outData_enqOnly ;
  assign bram_serverAdapterB_outDataCore$DEQ =
	     WILL_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq ||
	     WILL_FIRE_RL_bram_serverAdapterB_outData_deqOnly ;
  assign bram_serverAdapterB_outDataCore$CLR = 1'b0 ;

  // submodule lenF
  assign lenF$D_IN = msgF$D_OUT ;
  assign lenF$ENQ = CAN_FIRE_RL_newLength ;
  assign lenF$DEQ = EN_newLen_get ;
  assign lenF$CLR = 1'b0 ;

  // submodule mesgInF
  assign mesgInF$D_IN = sink_put ;
  assign mesgInF$ENQ = EN_sink_put ;
  assign mesgInF$DEQ =
	     mesgInF$EMPTY_N && (bram_serverAdapterA_cnt ^ 3'h4) < 3'd7 &&
	     (!mesgInF$D_OUT[32] || msgF$FULL_N) ;
  assign mesgInF$CLR = 1'b0 ;

  // submodule mesgOutF
  assign mesgOutF$D_IN =
	     { countRd_73_EQ_msgF_first__51_MINUS_1_58___d205,
	       bram_serverAdapterB_outData_outData$wget } ;
  assign mesgOutF$ENQ =
	     msgF$EMPTY_N &&
	     (bram_serverAdapterB_outDataCore$EMPTY_N ||
	      bram_serverAdapterB_outData_enqData$whas) &&
	     mesgOutF$FULL_N &&
	     bram_serverAdapterB_outData_outData$whas ;
  assign mesgOutF$DEQ = EN_src_get ;
  assign mesgOutF$CLR = 1'b0 ;

  // submodule msgF
  assign msgF$D_IN = countWrd ;
  assign msgF$ENQ = WILL_FIRE_RL_writeBRAM && mesgInF$D_OUT[32] ;
  assign msgF$DEQ = EN_length_dwm ;
  assign msgF$CLR = 1'b0 ;

  // remaining internal signals
  assign bram_serverAdapterB_cnt_4_PLUS_IF_bram_serverA_ETC___d100 =
	     bram_serverAdapterB_cnt +
	     (WILL_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ?
		3'd1 :
		3'd0) +
	     (CAN_FIRE_RL_readBRAM ? 3'd7 : 3'd0) ;
  assign countRdReq_50_EQ_msgF_first__51_MINUS_1_58___d212 =
	     countRdReq == msgF_first__51_MINUS_1___d192 ;
  assign countRd_73_EQ_msgF_first__51_MINUS_1_58___d205 =
	     countRd == msgF_first__51_MINUS_1___d192 ;
  assign msgF_first__51_MINUS_1___d192 = msgF$D_OUT - 9'd1 ;
  assign x__h817 = accum_value + y__h820 ;
  assign y__h818 =
	     CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways ?
	       8'd255 :
	       8'd0 ;
  assign y__h820 =
	     CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways ?
	       8'd1 :
	       8'd0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        accum_value <= `BSV_ASSIGNMENT_DELAY 8'd0;
	bram_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	bram_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	bram_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	bram_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	countRd <= `BSV_ASSIGNMENT_DELAY 9'd0;
	countRdReq <= `BSV_ASSIGNMENT_DELAY 9'd0;
	countWrd <= `BSV_ASSIGNMENT_DELAY 9'd1;
	newMsg <= `BSV_ASSIGNMENT_DELAY 1'd1;
	readAddr <= `BSV_ASSIGNMENT_DELAY 9'd0;
	writeAddr <= `BSV_ASSIGNMENT_DELAY 9'd0;
      end
    else
      begin
        if (accum_value$EN)
	  accum_value <= `BSV_ASSIGNMENT_DELAY accum_value$D_IN;
	if (bram_serverAdapterA_cnt$EN)
	  bram_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY
	      bram_serverAdapterA_cnt$D_IN;
	if (bram_serverAdapterA_s1$EN)
	  bram_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY
	      bram_serverAdapterA_s1$D_IN;
	if (bram_serverAdapterB_cnt$EN)
	  bram_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY
	      bram_serverAdapterB_cnt$D_IN;
	if (bram_serverAdapterB_s1$EN)
	  bram_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY
	      bram_serverAdapterB_s1$D_IN;
	if (countRd$EN) countRd <= `BSV_ASSIGNMENT_DELAY countRd$D_IN;
	if (countRdReq$EN)
	  countRdReq <= `BSV_ASSIGNMENT_DELAY countRdReq$D_IN;
	if (countWrd$EN) countWrd <= `BSV_ASSIGNMENT_DELAY countWrd$D_IN;
	if (newMsg$EN) newMsg <= `BSV_ASSIGNMENT_DELAY newMsg$D_IN;
	if (readAddr$EN) readAddr <= `BSV_ASSIGNMENT_DELAY readAddr$D_IN;
	if (writeAddr$EN) writeAddr <= `BSV_ASSIGNMENT_DELAY writeAddr$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    accum_value = 8'hAA;
    bram_serverAdapterA_cnt = 3'h2;
    bram_serverAdapterA_s1 = 2'h2;
    bram_serverAdapterB_cnt = 3'h2;
    bram_serverAdapterB_s1 = 2'h2;
    countRd = 9'h0AA;
    countRdReq = 9'h0AA;
    countWrd = 9'h0AA;
    newMsg = 1'h0;
    readAddr = 9'h0AA;
    writeAddr = 9'h0AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_bram_serverAdapterA_overRun)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_bram_serverAdapterB_overRun)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
  end
  // synopsys translate_on
endmodule  // mkBuffer

