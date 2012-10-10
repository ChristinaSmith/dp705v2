// Checker.bsv 
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import tbDefs     ::*;

import DReg     ::*;

interface CheckerIfc;
  interface Put#(Mesg) sink1;
  interface Put#(Mesg) sink2;
endinterface



module mkChecker(CheckerIfc);
// state instanced here
FIFO#(Mesg)      buffF       <- mkFIFO;
Reg#(Bit#(8))    incorrect   <- mkReg(0);
FIFO#(Mesg)      checkF      <- mkFIFO;
Reg#(Bit#(8))    minLen      <- mkReg('1);
Reg#(Bit#(8))    maxLen      <- mkReg('0);
Reg#(Bit#(8))    mesgCnt     <- mkReg(1);
Reg#(Bit#(8))    wordCnt     <- mkReg(1);
Reg#(Mesg)    buff     <- mkReg(?);
Reg#(Mesg)    check     <- mkReg(?);
Reg#(Bool)    cmpFire     <- mkDReg(False);
Reg#(Bool)    cmpEOP     <- mkDReg(False);
Reg#(Bool)    cmpMatch   <- mkDReg(False);

// rules here
rule compare;
  cmpFire <= True;

  buff <= buffF.first;
  check <= checkF.first;

  let got = buffF.first; buffF.deq;
  let chk = checkF.first; checkF.deq;
  
  

  Bit#(32) expected = stripEOPTag(chk);
  Bit#(32) received = stripEOPTag(got);
  Bool eMatchR = (expected == received);
  cmpMatch <= eMatchR;
  Bool eop = isEOP(chk);
  cmpEOP <= eop;
//  $display("match: %b, eop: %b", eMatchR, eop);

  wordCnt <= (eMatchR && eop) ? 1 : (eMatchR) ? wordCnt + 1 : wordCnt;

  if(eMatchR && eop) begin
    $display("Message Count: %d || Length: %d || Last word rcv'd: %0x", mesgCnt, wordCnt, received);
    mesgCnt <= mesgCnt + 1;
    minLen <= (wordCnt < minLen) ? wordCnt : minLen;
    maxLen <= (wordCnt > maxLen) ? wordCnt : maxLen;
  end else

  if(mesgCnt % 50 == 1)$display("Max Length: %d, Min Length: %d", maxLen, minLen);
    

  if(!eMatchR) begin 
    $display("Message Error: %0x, %0x",received, expected);
    incorrect <= incorrect + 1;
//    $finish;
  end
endrule

// interfaces provided here
  interface sink1 = toPut(buffF);
  interface sink2 = toPut(checkF);
endmodule
