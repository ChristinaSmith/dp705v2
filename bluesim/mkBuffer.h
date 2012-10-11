/*
 * Generated by Bluespec Compiler, version 2012.09.beta1 (build 29570, 2012-09.11)
 * 
 * On Thu Oct 11 17:17:19 EDT 2012
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkBuffer_h__
#define __mkBuffer_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkBuffer module */
class MOD_mkBuffer : public Module {
 
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
  MOD_Wire<tUInt8> INST_accum_acc_v1;
  MOD_Wire<tUInt8> INST_accum_acc_v2;
  MOD_Reg<tUInt8> INST_accum_value;
  MOD_BRAM<tUInt32,tUInt32,tUInt8> INST_bram_memory;
  MOD_Reg<tUInt8> INST_bram_serverAdapterA_cnt;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_cnt_1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_cnt_2;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_cnt_3;
  MOD_Fifo<tUInt32> INST_bram_serverAdapterA_outDataCore;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_outData_deqCalled;
  MOD_Wire<tUInt32> INST_bram_serverAdapterA_outData_enqData;
  MOD_Wire<tUInt32> INST_bram_serverAdapterA_outData_outData;
  MOD_Reg<tUInt8> INST_bram_serverAdapterA_s1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_s1_1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterA_writeWithResp;
  MOD_Reg<tUInt8> INST_bram_serverAdapterB_cnt;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_cnt_1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_cnt_2;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_cnt_3;
  MOD_Fifo<tUInt32> INST_bram_serverAdapterB_outDataCore;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_outData_deqCalled;
  MOD_Wire<tUInt32> INST_bram_serverAdapterB_outData_enqData;
  MOD_Wire<tUInt32> INST_bram_serverAdapterB_outData_outData;
  MOD_Reg<tUInt8> INST_bram_serverAdapterB_s1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_s1_1;
  MOD_Wire<tUInt8> INST_bram_serverAdapterB_writeWithResp;
  MOD_Reg<tUInt32> INST_countRd;
  MOD_Reg<tUInt32> INST_countRdReq;
  MOD_Reg<tUInt32> INST_countWrd;
  MOD_Fifo<tUInt32> INST_lenF;
  MOD_Fifo<tUInt64> INST_mesgInF;
  MOD_Fifo<tUInt64> INST_mesgOutF;
  MOD_Fifo<tUInt32> INST_msgF;
  MOD_Reg<tUInt8> INST_newMsg;
  MOD_Reg<tUInt32> INST_readAddr;
  MOD_Reg<tUInt32> INST_writeAddr;
 
 /* Constructor */
 public:
  MOD_mkBuffer(tSimStateHdl simHdl, char const *name, Module *parent);
 
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
  tUInt8 PORT_EN_newLen_get;
  tUInt8 PORT_EN_length_dwm;
  tUInt64 PORT_sink_put;
  tUInt64 PORT_src_get;
  tUInt8 PORT_RDY_src_get;
  tUInt8 PORT_RDY_sink_put;
  tUInt32 PORT_newLen_get;
  tUInt8 PORT_RDY_newLen_get;
  tUInt8 PORT_RDY_length_dwm;
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_length_dwm;
  tUInt8 DEF_WILL_FIRE_newLen_get;
  tUInt8 DEF_WILL_FIRE_sink_put;
  tUInt8 DEF_WILL_FIRE_src_get;
  tUInt8 DEF_WILL_FIRE_RL_newLength;
  tUInt8 DEF_CAN_FIRE_RL_newLength;
  tUInt8 DEF_WILL_FIRE_RL_readBRAM;
  tUInt8 DEF_CAN_FIRE_RL_readBRAM;
  tUInt8 DEF_WILL_FIRE_RL_readReqBRAM;
  tUInt8 DEF_CAN_FIRE_RL_readReqBRAM;
  tUInt8 DEF_WILL_FIRE_RL_writeBRAM;
  tUInt8 DEF_CAN_FIRE_RL_writeBRAM;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_overRun;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_overRun;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_moveToOutFIFO;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_moveToOutFIFO;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_stageReadResponseAlways;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_s1__dreg_update;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_s1__dreg_update;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_cnt_finalAdd;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_cnt_finalAdd;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_outData_enqAndDeq;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_outData_deqOnly;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_outData_deqOnly;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_outData_enqOnly;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_outData_enqOnly;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstEnq;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterB_outData_setFirstCore;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterB_outData_setFirstCore;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_overRun;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_overRun;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_moveToOutFIFO;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_moveToOutFIFO;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_stageReadResponseAlways;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_s1__dreg_update;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_s1__dreg_update;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_cnt_finalAdd;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_cnt_finalAdd;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_outData_enqAndDeq;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_outData_deqOnly;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_outData_deqOnly;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_outData_enqOnly;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_outData_enqOnly;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstEnq;
  tUInt8 DEF_WILL_FIRE_RL_bram_serverAdapterA_outData_setFirstCore;
  tUInt8 DEF_CAN_FIRE_RL_bram_serverAdapterA_outData_setFirstCore;
  tUInt8 DEF_WILL_FIRE_RL_accum_accumulate;
  tUInt8 DEF_CAN_FIRE_RL_accum_accumulate;
  tUInt8 DEF_CAN_FIRE_length_dwm;
  tUInt8 DEF_msgF_i_notEmpty____d215;
  tUInt8 DEF_CAN_FIRE_newLen_get;
  tUInt8 DEF_CAN_FIRE_sink_put;
  tUInt8 DEF_CAN_FIRE_src_get;
  tUInt32 DEF_b__h4528;
  tUInt32 DEF_msgF_first____d179;
  tUInt8 DEF_x__h819;
  tUInt8 DEF_b__h3340;
  tUInt8 DEF_b__h1935;
  tUInt8 DEF_bram_serverAdapterB_s1___d205;
  tUInt8 DEF_bram_serverAdapterA_s1___d204;
  tUInt8 DEF_bram_serverAdapterB_cnt_3_whas____d203;
  tUInt8 DEF_bram_serverAdapterB_cnt_2_whas____d195;
  tUInt8 DEF_bram_serverAdapterB_cnt_1_whas____d194;
  tUInt8 DEF_bram_serverAdapterA_cnt_3_whas____d202;
  tUInt8 DEF_bram_serverAdapterA_cnt_2_whas____d189;
  tUInt8 DEF_bram_serverAdapterA_cnt_1_whas____d188;
 
 /* Local definitions */
 private:
  tUInt32 DEF_x__h2950;
  tUInt32 DEF_x__h1545;
  tUInt32 DEF_msgF_first__45_MINUS_1___d185;
 
 /* Rules */
 public:
  void RL_accum_accumulate();
  void RL_bram_serverAdapterA_outData_setFirstCore();
  void RL_bram_serverAdapterA_outData_setFirstEnq();
  void RL_bram_serverAdapterA_outData_enqOnly();
  void RL_bram_serverAdapterA_outData_deqOnly();
  void RL_bram_serverAdapterA_outData_enqAndDeq();
  void RL_bram_serverAdapterA_cnt_finalAdd();
  void RL_bram_serverAdapterA_s1__dreg_update();
  void RL_bram_serverAdapterA_stageReadResponseAlways();
  void RL_bram_serverAdapterA_moveToOutFIFO();
  void RL_bram_serverAdapterA_overRun();
  void RL_bram_serverAdapterB_outData_setFirstCore();
  void RL_bram_serverAdapterB_outData_setFirstEnq();
  void RL_bram_serverAdapterB_outData_enqOnly();
  void RL_bram_serverAdapterB_outData_deqOnly();
  void RL_bram_serverAdapterB_outData_enqAndDeq();
  void RL_bram_serverAdapterB_cnt_finalAdd();
  void RL_bram_serverAdapterB_s1__dreg_update();
  void RL_bram_serverAdapterB_stageReadResponseAlways();
  void RL_bram_serverAdapterB_moveToOutFIFO();
  void RL_bram_serverAdapterB_overRun();
  void RL_writeBRAM();
  void RL_readReqBRAM();
  void RL_readBRAM();
  void RL_newLength();
 
 /* Methods */
 public:
  tUInt64 METH_src_get();
  tUInt8 METH_RDY_src_get();
  void METH_sink_put(tUInt64 ARG_sink_put);
  tUInt8 METH_RDY_sink_put();
  tUInt32 METH_newLen_get();
  tUInt8 METH_RDY_newLen_get();
  void METH_length_dwm();
  tUInt8 METH_RDY_length_dwm();
 
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
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkBuffer &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkBuffer &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkBuffer &backing);
};

#endif /* ifndef __mkBuffer_h__ */
