// MHSender.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import DReg       ::*;

interface LenGetIfc;
  method Bool dwm();
endinterface

interface MHSenderIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
  interface Put#(UInt#(9)) newLen;
  interface LenGetIfc getLen;
  interface Get#(UInt#(9)) giveLen;
endinterface

function Mesg packLength(UInt#(9) oldLen);
  Bit#(9)  newLen  = pack(oldLen);                                  // Transform UInt length to Bits
  Bit#(7)  zeros   = 7'b0;                                          // Supply MSB zeros (sign extend)
  Bit#(16) dntCare = 16'b0;                                         // Fill LSBs with garbage (not used)
  Bit#(32) x       = {zeros, newLen, dntCare};                      // Concatenate the values
  return (oldLen == 0) ? tagged ValidEOP x : tagged ValidNotEOP x;  // Tag EOP or not based on length of 0
endfunction

(* synthesize *)
module mkMHSender(MHSenderIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFO#(UInt#(9))              lenToFHF        <- mkFIFO;
FIFOF#(UInt#(9))             lengthF         <- mkFIFOF;
FIFOF#(Bit#(0))              headerF         <- mkFIFOF;
FIFOF#(Bit#(0))              messageF        <- mkFIFOF;
FIFOF#(Bit#(0))              msgDoneF        <- mkFIFOF;
Reg#(Maybe#(UInt#(9)))       lenR            <- mkReg(tagged Invalid);
Reg#(UInt#(9))               hp              <- mkReg(0);
Reg#(UInt#(9))               fragLenCnt      <- mkReg(1);
Reg#(UInt#(9))               msgHeadLen      <- mkReg(5);
Reg#(Bool)                   eopR            <- mkDReg(False);
Vector#(6, Reg#(Mesg))       mhV             <- replicateM(mkRegU);


rule popMhV(lengthF.notEmpty);
  for(Integer i=0; i<5; i=i+1) mhV[i] <= tagged ValidNotEOP fromInteger(i);
  mhV[5] <= packLength(lengthF.first);
//  lenR <= tagged Valid lengthF.first;
  lengthF.deq;
  headerF.enq(?);
endrule

rule sndHead(headerF.notEmpty);
  mesgOutF.enq(mhV[hp]);
  Bool eoh = (hp == msgHeadLen);
  hp <= (eoh) ? 0 : hp + 1; 
  if(eoh) begin
//    lengthF.deq;
    headerF.deq; 
    messageF.enq(?); 
  end
endrule

rule sndMesg(messageF.notEmpty);
//  Bool eom = (fragLenCnt == fromMaybe(maxBound, lenR));
  Bool eom = (isEOP(mesgInF.first));
  eopR <= eom;
  mesgOutF.enq(mesgInF.first);
//  fragLenCnt <= eom ? 1 : fragLenCnt + 1;
  if(eom) begin 
    messageF.deq;
//    lenToFHF.enq(fromMaybe(maxBound, lenR));
  end
  mesgInF.deq;
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);
interface newLen = toPut(lengthF);
interface giveLen = toGet(lenToFHF);

interface LenGetIfc getLen;
  method Bool dwm();
    //return (fragLenCnt == fromMaybe(maxBound,lenR));
    return (eopR); //DReg pulse may lose real EOP
  endmethod
endinterface

endmodule
