//
// Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
//
// On Tue Oct 16 11:00:16 EDT 2012
//
// Method conflict info:
// Method: ingress_put
// Conflict-free: egress_get
// Conflicts: ingress_put
//
// Method: egress_get
// Conflict-free: ingress_put
// Conflicts: egress_get
//
//
// Ports:
// Name                         I/O  size props
// RDY_ingress_put                O     1 reg
// egress_get                     O    33 reg
// RDY_egress_get                 O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// ingress_put                    I    33 reg
// EN_ingress_put                 I     1
// EN_egress_get                  I     1
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

module mkMHReceiver(CLK,
		    RST_N,

		    ingress_put,
		    EN_ingress_put,
		    RDY_ingress_put,

		    EN_egress_get,
		    egress_get,
		    RDY_egress_get);
  input  CLK;
  input  RST_N;

  // action method ingress_put
  input  [32 : 0] ingress_put;
  input  EN_ingress_put;
  output RDY_ingress_put;

  // actionvalue method egress_get
  input  EN_egress_get;
  output [32 : 0] egress_get;
  output RDY_egress_get;

  // signals for module outputs
  wire [32 : 0] egress_get;
  wire RDY_egress_get, RDY_ingress_put;

  // register captMsgHead
  reg captMsgHead;
  wire captMsgHead$D_IN, captMsgHead$EN;

  // register mhV
  reg [32 : 0] mhV;
  wire [32 : 0] mhV$D_IN;
  wire mhV$EN;

  // register mhV_1
  reg [32 : 0] mhV_1;
  wire [32 : 0] mhV_1$D_IN;
  wire mhV_1$EN;

  // register mhV_2
  reg [32 : 0] mhV_2;
  wire [32 : 0] mhV_2$D_IN;
  wire mhV_2$EN;

  // register mhV_3
  reg [32 : 0] mhV_3;
  wire [32 : 0] mhV_3$D_IN;
  wire mhV_3$EN;

  // register mhV_4
  reg [32 : 0] mhV_4;
  wire [32 : 0] mhV_4$D_IN;
  wire mhV_4$EN;

  // register mhV_5
  reg [32 : 0] mhV_5;
  wire [32 : 0] mhV_5$D_IN;
  wire mhV_5$EN;

  // register mhp
  reg [3 : 0] mhp;
  wire [3 : 0] mhp$D_IN;
  wire mhp$EN;

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

  // rule scheduling signals
  wire CAN_FIRE_RL_captMsgHeader,
       CAN_FIRE_RL_passMsgPayload,
       CAN_FIRE_RL_take,
       CAN_FIRE_egress_get,
       CAN_FIRE_ingress_put,
       WILL_FIRE_RL_captMsgHeader,
       WILL_FIRE_RL_passMsgPayload,
       WILL_FIRE_RL_take,
       WILL_FIRE_egress_get,
       WILL_FIRE_ingress_put;

  // action method ingress_put
  assign RDY_ingress_put = mesgInF$FULL_N ;
  assign CAN_FIRE_ingress_put = mesgInF$FULL_N ;
  assign WILL_FIRE_ingress_put = EN_ingress_put ;

  // actionvalue method egress_get
  assign egress_get = mesgOutF$D_OUT ;
  assign RDY_egress_get = mesgOutF$EMPTY_N ;
  assign CAN_FIRE_egress_get = mesgOutF$EMPTY_N ;
  assign WILL_FIRE_egress_get = EN_egress_get ;

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

  // rule RL_captMsgHeader
  assign CAN_FIRE_RL_captMsgHeader = mesgInF$EMPTY_N && !captMsgHead ;
  assign WILL_FIRE_RL_captMsgHeader = CAN_FIRE_RL_captMsgHeader ;

  // rule RL_passMsgPayload
  assign CAN_FIRE_RL_passMsgPayload =
	     mesgInF$EMPTY_N && mesgOutF$FULL_N && captMsgHead ;
  assign WILL_FIRE_RL_passMsgPayload = CAN_FIRE_RL_passMsgPayload ;

  // rule RL_take
  assign CAN_FIRE_RL_take = mesgInF$EMPTY_N && mesgOutF$FULL_N ;
  assign WILL_FIRE_RL_take =
	     CAN_FIRE_RL_take && !WILL_FIRE_RL_passMsgPayload &&
	     !WILL_FIRE_RL_captMsgHeader ;

  // register captMsgHead
  assign captMsgHead$D_IN =
	     WILL_FIRE_RL_passMsgPayload ? !mesgInF$D_OUT[32] : mhp == 4'd5 ;
  assign captMsgHead$EN =
	     WILL_FIRE_RL_passMsgPayload || WILL_FIRE_RL_captMsgHeader ;

  // register mhV
  assign mhV$D_IN = mesgInF$D_OUT ;
  assign mhV$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd0 ;

  // register mhV_1
  assign mhV_1$D_IN = mesgInF$D_OUT ;
  assign mhV_1$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd1 ;

  // register mhV_2
  assign mhV_2$D_IN = mesgInF$D_OUT ;
  assign mhV_2$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd2 ;

  // register mhV_3
  assign mhV_3$D_IN = mesgInF$D_OUT ;
  assign mhV_3$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd3 ;

  // register mhV_4
  assign mhV_4$D_IN = mesgInF$D_OUT ;
  assign mhV_4$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd4 ;

  // register mhV_5
  assign mhV_5$D_IN = mesgInF$D_OUT ;
  assign mhV_5$EN = WILL_FIRE_RL_captMsgHeader && mhp == 4'd5 ;

  // register mhp
  assign mhp$D_IN = (mhp == 4'd5) ? 4'd0 : mhp + 4'd1 ;
  assign mhp$EN = CAN_FIRE_RL_captMsgHeader ;

  // submodule mesgInF
  assign mesgInF$D_IN = ingress_put ;
  assign mesgInF$ENQ = EN_ingress_put ;
  assign mesgInF$DEQ =
	     WILL_FIRE_RL_take || WILL_FIRE_RL_captMsgHeader ||
	     WILL_FIRE_RL_passMsgPayload ;
  assign mesgInF$CLR = 1'b0 ;

  // submodule mesgOutF
  assign mesgOutF$D_IN = mesgInF$D_OUT ;
  assign mesgOutF$ENQ = WILL_FIRE_RL_take || WILL_FIRE_RL_passMsgPayload ;
  assign mesgOutF$DEQ = EN_egress_get ;
  assign mesgOutF$CLR = 1'b0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        captMsgHead <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mhp <= `BSV_ASSIGNMENT_DELAY 4'd0;
      end
    else
      begin
        if (captMsgHead$EN)
	  captMsgHead <= `BSV_ASSIGNMENT_DELAY captMsgHead$D_IN;
	if (mhp$EN) mhp <= `BSV_ASSIGNMENT_DELAY mhp$D_IN;
      end
    if (mhV$EN) mhV <= `BSV_ASSIGNMENT_DELAY mhV$D_IN;
    if (mhV_1$EN) mhV_1 <= `BSV_ASSIGNMENT_DELAY mhV_1$D_IN;
    if (mhV_2$EN) mhV_2 <= `BSV_ASSIGNMENT_DELAY mhV_2$D_IN;
    if (mhV_3$EN) mhV_3 <= `BSV_ASSIGNMENT_DELAY mhV_3$D_IN;
    if (mhV_4$EN) mhV_4 <= `BSV_ASSIGNMENT_DELAY mhV_4$D_IN;
    if (mhV_5$EN) mhV_5 <= `BSV_ASSIGNMENT_DELAY mhV_5$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    captMsgHead = 1'h0;
    mhV = 33'h0AAAAAAAA;
    mhV_1 = 33'h0AAAAAAAA;
    mhV_2 = 33'h0AAAAAAAA;
    mhV_3 = 33'h0AAAAAAAA;
    mhV_4 = 33'h0AAAAAAAA;
    mhV_5 = 33'h0AAAAAAAA;
    mhp = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMHReceiver

