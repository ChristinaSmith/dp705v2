/*
 * Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
 * 
 * On Thu Oct 11 17:17:19 EDT 2012
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkMHReciever_h__
#define __mkMHReciever_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkMHReciever module */
class MOD_mkMHReciever : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt32> INST_countRd;
  MOD_Reg<tUInt32> INST_countRdReq;
  MOD_Reg<tUInt32> INST_countWrd;
  MOD_Reg<tUInt8> INST_endHead;
  MOD_Reg<tUInt32> INST_hp;
  MOD_Reg<tUInt32> INST_length;
  MOD_Fifo<tUInt64> INST_mesgInF;
  MOD_Fifo<tUInt64> INST_mesgOutF;
  MOD_Fifo<tUInt8> INST_messageF;
  MOD_Reg<tUInt64> INST_mhV;
  MOD_Reg<tUInt64> INST_mhV_1;
  MOD_Reg<tUInt64> INST_mhV_2;
  MOD_Reg<tUInt64> INST_mhV_3;
  MOD_Reg<tUInt64> INST_mhV_4;
  MOD_Reg<tUInt64> INST_mhV_5;
  MOD_Fifo<tUInt32> INST_msgF;
  MOD_Reg<tUInt32> INST_readAddr;
  MOD_Reg<tUInt32> INST_writeAddr;
 
 /* Constructor */
 public:
  MOD_mkMHReciever(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUInt8 PORT_EN_src_get;
  tUInt8 PORT_EN_sink_put;
  tUInt64 PORT_sink_put;
  tUInt64 PORT_src_get;
  tUInt8 PORT_RDY_src_get;
  tUInt8 PORT_RDY_sink_put;
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_sink_put;
  tUInt8 DEF_WILL_FIRE_src_get;
  tUInt8 DEF_CAN_FIRE_sink_put;
  tUInt8 DEF_CAN_FIRE_src_get;
  tUInt8 DEF_WILL_FIRE_RL_moveMessage;
  tUInt8 DEF_CAN_FIRE_RL_moveMessage;
  tUInt8 DEF_WILL_FIRE_RL_rcvHeader;
  tUInt8 DEF_CAN_FIRE_RL_rcvHeader;
 
 /* Local definitions */
 private:
  tUInt64 DEF_mesgInF_first____d41;
 
 /* Rules */
 public:
  void RL_rcvHeader();
  void RL_moveMessage();
 
 /* Methods */
 public:
  tUInt64 METH_src_get();
  tUInt8 METH_RDY_src_get();
  void METH_sink_put(tUInt64 ARG_sink_put);
  tUInt8 METH_RDY_sink_put();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkMHReciever &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkMHReciever &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkMHReciever &backing);
};

#endif /* ifndef __mkMHReciever_h__ */
