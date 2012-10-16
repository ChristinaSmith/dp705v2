// MHReceiver.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;

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
FIFOF#(Bit#(0))              messageF        <- mkFIFOF;
Reg#(Bit#(16))               countWrd        <- mkReg(0); 
Reg#(Bit#(16))               length          <- mkReg(0);
Reg#(UInt#(9))               hp              <- mkReg(0);
Reg#(Bool)                   endHead         <- mkReg(True);
Vector#(6, Reg#(Mesg))       mhV             <- replicateM(mkRegU);

/*rule rcvHeader(endHead);
  length <= getLength(mhV[5]);
  hp <= (hp < 6) ? hp + 1 : 0;
  if(hp < 6) begin
    mhV[hp] <= mesgInF.first;
    mesgInF.deq;
  end
  if(hp == 6)begin 
    messageF.enq(?); 
    endHead <= False; 
  end
endrule

rule moveMessage(messageF.notEmpty);
  Bool eom = (countWrd == length-1);
  mesgOutF.enq(mesgInF.first);
  mesgInF.deq;
  countWrd <= (eom) ? 0 : countWrd + 1;
  if(eom) begin 
    messageF.deq; 
    endHead <= True; 
  end
endrule
*/

rule take;
  mesgOutF.enq(mesgInF.first);
  mesgInF.deq;
endrule
interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);

endmodule
