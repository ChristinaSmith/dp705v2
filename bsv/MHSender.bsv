// MHSender.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import BRAM       ::*;

interface LenGetIfc;
  method Bool dwm();
endinterface

interface MHSenderIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
  interface Put#(UInt#(9)) newLen;
  interface LenGetIfc getLen;
endinterface

function Mesg packLength(UInt#(9) oldLen);
  Bit#(9)  newLen  = pack(oldLen);
  Bit#(7)  zeros   = 7'b0;
  Bit#(16) dntCare = 16'b0;
  Bit#(32) x       = {zeros, newLen, dntCare}; 
//  Mesg val = (oldLen == 0) ? tagged ValidEOP x : tagged ValidNotEOP x;
  Mesg val = tagged ValidNotEOP x;
  return val;
endfunction

(* synthesize *)
module mkMHSender(MHSenderIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
Vector#(6, Reg#(Mesg))       mhV             <- replicateM(mkRegU);
FIFOF#(UInt#(9))             lengthF         <- mkFIFOF;
Reg#(UInt#(9))               hp              <- mkReg(0);
Reg#(UInt#(9))               fragLenCnt      <- mkReg(1);
FIFOF#(Bit#(0))              headerF         <- mkFIFOF;
FIFOF#(Bit#(0))              messageF        <- mkFIFOF;
FIFOF#(Bit#(0))              msgDoneF        <- mkFIFOF;
Reg#(Maybe#(UInt#(9)))       lenR            <- mkReg(tagged Invalid);

rule popMhV(lengthF.notEmpty);
  for(Integer i=0; i<5; i=i+1) mhV[i] <= tagged ValidNotEOP fromInteger(i);
  mhV[5] <= packLength(lengthF.first);
  lenR <= tagged Valid lengthF.first;
  lengthF.deq;
  headerF.enq(?);
endrule

rule sndHead(headerF.notEmpty);
  mesgOutF.enq(mhV[hp]);
  hp <= (hp == 5) ? 0 : hp + 1; 
  if(hp == 5)begin headerF.deq; messageF.enq(?); end
//  lengthF.deq;
endrule

rule sndMesg(messageF.notEmpty);
  Bool eop = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first);
  fragLenCnt <= (fragLenCnt == fromMaybe(maxBound,lenR)) ? 1 : fragLenCnt + 1;
  mesgInF.deq;
  if(eop) begin messageF.deq;  end
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);
interface newLen = toPut(lengthF);

interface LenGetIfc getLen;
  method Bool dwm();
    return (fragLenCnt == fromMaybe(maxBound,lenR));
  endmethod
endinterface

endmodule
