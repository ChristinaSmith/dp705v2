// MHSender.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import BRAM       ::*;

interface LenPeekIfc;
  method Action lenPeek(UInt#(9) len);
  method Bool dwm();
endinterface

interface MHSenderIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
  interface LenPeekIfc peek;
endinterface

function Mesg packLength(UInt#(9) oldLen);
  Bit#(9)  newLen  = pack(oldLen);
  Bit#(7)  zeros   = 7'b0;
  Bit#(16) dntCare = 16'b0;
  Bit#(32) x       = {zeros, newLen, dntCare}; 
  Mesg val = (oldLen == 0) ? tagged ValidEOP x : tagged ValidNotEOP x;
  return val;
endfunction

(* synthesize *)
module mkMHSender(MHSenderIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
Vector#(6, Reg#(Mesg))       mhV             <- replicateM(mkRegU);
Reg#(UInt#(9))               length          <- mkReg(0);
Reg#(UInt#(9))               hp              <- mkReg(0);
Reg#(Bool)                   headSent        <- mkReg(False);
FIFOF#(Bit#(0))              headerF         <- mkFIFOF;
FIFOF#(Bit#(0))              messageF        <- mkFIFOF;

rule popMhV;
  for(Integer i=0; i<5; i=i+1) mhV[i] <= tagged ValidNotEOP fromInteger(i);
  mhV[5] <= packLength(length);
  headerF.enq(?);
endrule

rule sndHead(headerF.notEmpty);
  mesgOutF.enq(mhV[hp]);
  hp <= (hp == 5) ? 0 : hp + 1; 
  if(hp == 5)begin headerF.deq; messageF.enq(?); end
endrule

rule sndMesg(messageF.notEmpty);
  Bool eop = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first);
  mesgInF.deq;
  if(eop) messageF.deq;
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);

interface LenPeekIfc peek;
  method Action lenPeek(UInt#(9) len);
    length <= len;
  endmethod

  method Bool dwm();
    return True;
  endmethod
endinterface

endmodule