// MHReceiver.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import BRAM       ::*;

interface MHRecieverIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
endinterface

function Bit#(16) getLength(Mesg m);
  Bit#(32) word = stripEOPTag(m);
  return word[31:16];
endfunction

(* synthesize *)
module mkMHReciever(MHRecieverIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFOF#(UInt#(9))             msgF            <- mkFIFOF;
Reg#(Bit#(16))               countWrd        <- mkReg(0); 
Reg#(UInt#(9))               countRdReq      <- mkReg(0);
Reg#(UInt#(9))               countRd         <- mkReg(0);
Reg#(UInt#(9))               readAddr        <- mkReg(0);
Reg#(UInt#(9))               writeAddr       <- mkReg(0);

Vector#(6, Reg#(Mesg))       mhReverseV             <- replicateM(mkRegU);
Reg#(UInt#(9))               hp              <- mkReg(5);
FIFOF#(Bit#(0))              headerF        <- mkFIFOF;
Reg#(Bit#(16))               length          <-mkReg(0);

rule rcvHeader;
  Bool eop = isEOP(mesgInF.first);
  if(!eop && hp > 0)
  begin
    mhReverseV[hp] <= mesgInF.first;
    mesgInF.deq;
  end
  length <= getLength(mhReverseV[0]);
  hp <= (hp > 0) ? hp - 1 : 5;
  if(hp == 0)headerF.enq(?);
endrule

rule moveMessage(headerF.notEmpty);
  Bool eop = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first);
  mesgInF.deq;
  countWrd <= (eop) ? 0 : countWrd + 1;
  if(countWrd == length)headerF.deq;
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);

endmodule
