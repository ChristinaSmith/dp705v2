// MHReceiver.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;

interface MHReceiverIfc;
  interface Put#(Mesg) ingress;
  interface Get#(Mesg) egress;
endinterface

function Bit#(16) getLength(Mesg m);
  Bit#(32) word = stripEOPTag(m);
  return word[31:16];
endfunction

(* synthesize *)
module mkMHReceiver(MHReceiverIfc);

FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
Reg#(UInt#(4))               mhp             <- mkReg(0);
Reg#(Bool)                   captMsgHead     <- mkReg(False);
Vector#(6, Reg#(Mesg))       mhV             <- replicateM(mkRegU);

//Reg#(Bit#(16))               countWrd        <- mkReg(0); 
//Reg#(Bit#(16))               length          <- mkReg(0);

rule captMsgHeader (!captMsgHead);
  Bool eoh = (mhp==5);
  mhp <= (eoh) ? 0 : mhp+1;
  mhV[mhp] <= mesgInF.first; mesgInF.deq();
  captMsgHead <= eoh;
endrule

rule passMsgPayload (captMsgHead);
  Bool eom = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first); mesgInF.deq();
  captMsgHead <= !eom;
endrule


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
interface ingress = toPut(mesgInF);
interface egress  = toGet(mesgOutF);

endmodule
