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


rule popMhV(lengthF.notEmpty);                                // Rule: Populates the MH fields when length is available
  for(Integer i=0; i<5; i=i+1)                                // For each of the first 5 fields
    mhV[i] <= tagged ValidNotEOP fromInteger(i);              // The sixth field assign length
  mhV[5] <= packLength(lengthF.first);                        // Done with length
  lengthF.deq;                                                // Notify to send header
  headerF.enq(?);
endrule

rule sndHead(headerF.notEmpty);                               // Rule: Output header when fields are populated
  mesgOutF.enq(mhV[hp]);                                      // Output header fields one at a time
  Bool eoh = (hp == msgHeadLen);                              // Determine if end of header 
  hp <= (eoh) ? 0 : hp + 1;                                   // Update header pointer, reset if end of header
  if(eoh) begin                                               // if end of header...
    headerF.deq;                                              // Notify done sending header
    messageF.enq(?);                                          // Notify ready to send message body
  end
endrule

rule sndMesg(messageF.notEmpty);                              // Rule: Output message body when header is sent
  Bool eom = (isEOP(mesgInF.first));                          // Determine if end of message
  eopR <= eom;                                                // Write value in DReg, used for dwm()
  mesgOutF.enq(mesgInF.first);                                // Output message one word at a time
  mesgInF.deq;                                                // Remove word that was just sent
  if(eom) messageF.deq;                                       // On end of message, notify done sending
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);
interface newLen = toPut(lengthF);
interface giveLen = toGet(lenToFHF);

interface LenGetIfc getLen;
  method Bool dwm();               // TODO: clarify token atomicity.. what is the proper machinery to indicate that we are done with a message?
    //return isEOP(mesgInF.first);
    return (eopR); //DReg pulse may lose real EOP
  endmethod
endinterface

endmodule
