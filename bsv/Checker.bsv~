// Checker.bsv - Compares two inputs for equality 
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import tbDefs     ::*;

import DReg     ::*;

interface CheckerIfc;
  interface Put#(Mesg) sink1;
  interface Put#(Mesg) sink2;
  method Bit#(4) incorrectCnt;
endinterface


(* synthesize *)
module mkChecker(CheckerIfc);

FIFO#(Mesg)      buffF       <- mkFIFO;
Reg#(Bit#(8))    incorrect   <- mkReg(0);
FIFO#(Mesg)      checkF      <- mkFIFO;
Reg#(Bit#(8))    minLen      <- mkReg('1);
Reg#(Bit#(8))    maxLen      <- mkReg('0);
Reg#(Bit#(8))    mesgCnt     <- mkReg(1);
Reg#(Bit#(8))    wordCnt     <- mkReg(1);
Reg#(Bool)       cmpFire     <- mkDReg(False);
Reg#(Bool)       cmpEOP      <- mkDReg(False);
Reg#(Bool)       cmpMatch    <- mkDReg(False);

rule compare;
  cmpFire <= True;

  let got = buffF.first; buffF.deq;
  let chk = checkF.first; checkF.deq;
  
  Bit#(32) expected = stripEOPTag(chk);
  Bit#(32) received = stripEOPTag(got);
  Bool eMatchR = (expected == received);
  cmpMatch <= eMatchR;
  Bool eop = isEOP(chk);
  cmpEOP <= eop;

  wordCnt <= (eMatchR && eop) ? 1 : (eMatchR) ? wordCnt + 1 : wordCnt;

  if(eMatchR && eop) begin
//    $display("Message Count: %d || Length: %d || Last word rcv'd: %0x", mesgCnt, wordCnt, received);           // used for debug
    mesgCnt <= mesgCnt + 1;
    minLen <= (wordCnt < minLen) ? wordCnt : minLen;
    maxLen <= (wordCnt > maxLen) ? wordCnt : maxLen;
  end else
 
 // if(mesgCnt % 50 == 1)$display("Max Length: %d, Min Length: %d", maxLen, minLen);       // Used for debug
    

  if(!eMatchR) begin 
    $display("Message Error: %0x, %0x",received, expected);
    incorrect <= incorrect + 1;
//    $finish;
  end
endrule

  interface sink1 = toPut(buffF);
  interface sink2 = toPut(checkF);
  method Bit#(4) incorrectCnt = pack(incorrect[3:0]);
endmodule
