// FHReceiver.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;

interface FHRecieverIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
endinterface

function Bit#(16) getLength(Mesg m);
  Bit#(32) word = stripEOPTag(m);
  return word[31:16];
endfunction

(* synthesize *)
module mkFHReciever(FHRecieverIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFOF#(Bit#(0))              messageF        <- mkFIFOF;
Reg#(Bit#(16))               countWrd        <- mkReg(0); 
Reg#(Bit#(16))               length          <- mkReg(0);
Reg#(UInt#(9))               fhp             <- mkReg(0);
Reg#(Bool)                   endHead         <- mkReg(True);
Vector#(3, Reg#(Mesg))       fhV             <- replicateM(mkRegU);

/*rule rcvHeader(endHead);
//  length <= getLength(fhV[5]);
  fhp <= (fhp < 3) ? fhp + 1 : 0;
  if(fhp < 3) begin
    fhV[fhp] <= mesgInF.first;
    mesgInF.deq;
  end
  if(fhp == 3)begin 
    messageF.enq(?); 
    endHead <= False; 
  end
endrule
*/
rule move;
//rule moveMessage(messageF.notEmpty);
//  Bool eom = (countWrd == length-1);
//  Bool eom = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first);
  mesgInF.deq;
//  countWrd <= (eom) ? 0 : countWrd + 1;
//  if(eom) begin 
//    messageF.deq; 
//    endHead <= True; 
//  end
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);

endmodule
