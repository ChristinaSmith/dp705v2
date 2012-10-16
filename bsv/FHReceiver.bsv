// FHReceiver.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import Vector     ::*;
import tbDefs     ::*;

interface FHReceiverIfc;
  interface Put#(Mesg) ingress;
  interface Get#(Mesg) egress;
endinterface

function Bit#(16) getLength(Mesg m);
  Bit#(32) word = stripEOPTag(m);
  return word[31:16];
endfunction

(* synthesize *)
module mkFHReceiver(FHReceiverIfc);

FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
Reg#(UInt#(9))               fhp             <- mkReg(0);
Vector#(3, Reg#(Mesg))       fhV             <- replicateM(mkRegU);
Reg#(Bool)                   captFrmHead     <- mkReg(False);

// This module will consume a Mesg stream from the mesgInF and strip off
// the fixed length frame header, store the frame header, and pass the payload
// along to the output. The Bool state captFrmHead ensure the exclusive firing of
// the two rules.

rule captFrmHeader (!captFrmHead);
  Bool eoh = (fhp==2);
  fhp <= (eoh) ? 0 : fhp+1;
  fhV[fhp] <= mesgInF.first; mesgInF.deq();
  captFrmHead <= eoh;
endrule

rule passMsgPayload (captFrmHead);
  Bool eom = isEOP(mesgInF.first);
  mesgOutF.enq(mesgInF.first); mesgInF.deq();
  captFrmHead <= !eom;
endrule

interface ingress = toPut(mesgInF);
interface egress  = toGet(mesgOutF);

endmodule
