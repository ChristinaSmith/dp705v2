// FHSender.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

// Local (non-BSV) package imports...
import tbDefs     ::*;

// Bluespec package imports...
import FIFO       ::*;
import FIFOF      ::*;
import GetPut     ::*;
import Vector     ::*;

interface FHSenderIfc;
  interface Put#(Mesg) ingress;
  interface Get#(Mesg) egress;
endinterface

(* synthesize *)
module mkFHSender(FHSenderIfc);

FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFOF#(Bit#(0))              headerF         <- mkFIFOF;
Reg#(UInt#(4))               fhp             <- mkReg(1);
Reg#(UInt#(4))               frmHeadLen      <- mkReg(3);
Reg#(Bool)                   updateFH        <- mkReg(True);
Vector#(3, Reg#(Mesg))       fhV             <- replicateM(mkRegU);
Reg#(Bool)                   sentFrmHead     <- mkReg(False);

rule popFhV(updateFH);                                  // Rule: Populate header fields of frame header                             
  for(Integer i=0; i<3; i=i+1)                          // For each of the 3 fields
    fhV[i] <= tagged ValidNotEOP fromInteger(i+10);     // Write arbitrary value for each field
  headerF.enq(?);                                       // enq token indicating a new Frame Header is Ready
  updateFH <= False;                                    // Signal done populating header
endrule

// sndHead and sndMesg are mutually exclusive; we must send exactly one frame header
// for every frame payload (zero or more message headers). We use the Bool state sentFrmHead
// to implement this alternation pattern.

rule sndHead(headerF.notEmpty && !sentFrmHead);         // Rule: Output the generated header when fields populated and not sending body 
  mesgOutF.enq(fhV[fhp-1]);                             // Output frame header one field at a time
  Bool eoh = (fhp == frmHeadLen);                       // Determine end of header by comparing frame header pointer and frame header length
  fhp <= (eoh) ? 1 : fhp+1;                             // update frame header pointer
  if (eoh) headerF.deq;                                 // consume the Frame Header is Ready token
  updateFH    <= eoh;                                   // trigger generation of the next FH
  sentFrmHead <= eoh;                                   // indicate that Frame Header has been sent
endrule

rule sndMesg (sentFrmHead);                             // Rule: Output message body when frame header is sent
  Bool eom = isEOP(mesgInF.first);                      // Test for end of message at each word
  mesgOutF.enq(mesgInF.first);                          // Output each word
  mesgInF.deq;                                          // Throw away word after sent
  sentFrmHead <= !eom;                                  // update flag
endrule

interface ingress = toPut(mesgInF);
interface egress  = toGet(mesgOutF);



endmodule
