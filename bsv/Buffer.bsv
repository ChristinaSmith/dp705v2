// Buffer.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import BRAM       ::*;

interface LenShowIfc;
  method UInt#(9) lenShow();
  method Action dwm();
endinterface

interface BufferIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
  interface LenShowIfc length;
endinterface

function BRAMRequest#(UInt#(9), Bit#(32)) makeRequest(Bool write, UInt#(9) addr, Bit#(32) data);
  return BRAMRequest{
                    write: write,
                    responseOnWrite: False,
                    address: addr,
                    datain: data
                    };
endfunction

function Bit#(32) stripEOPTag(Mesg m);
  case (m) matches
    tagged ValidNotEOP .z: return (z);
    tagged ValidEOP    .z: return (z);
  endcase
endfunction

function UInt#(9) generateAddr(Bool isEOP, UInt#(9) oldAddr);
  Bit#(9) newAddr = pack(oldAddr);
  newAddr[8] = ~newAddr[8];
  newAddr[7:0] = 0;
  return isEOP ? unpack(newAddr) : oldAddr + 1;
endfunction

(* synthesize *)
module mkBuffer(BufferIfc);

FIFO#(Mesg)                  mesgOutF        <- mkFIFO;
FIFO#(Mesg)                  mesgInF         <- mkFIFO;
FIFOF#(UInt#(9))             msgF            <- mkFIFOF;
Reg#(UInt#(9))               countWrd        <- mkReg(1); 
Reg#(UInt#(9))               countRdReq      <- mkReg(0);
Reg#(UInt#(9))               countRd         <- mkReg(0);
Reg#(UInt#(9))               readAddr        <- mkReg(0);
Reg#(UInt#(9))               writeAddr       <- mkReg(0);

BRAM_Configure cfg = defaultValue;
cfg.memorySize = 512;
cfg.latency    = 1;
BRAM2Port#(UInt#(9), Bit#(32)) bram <- mkBRAM2Server(cfg);

rule writeBRAM;                                                 // For every incident Mesg word...
  let y = mesgInF.first; mesgInF.deq;                           // dequeue the incident Mesg
  Bool isEOP = tbDefs::isEOP(y);                                // detect if is an EOP
  Bit#(32) data = stripEOPTag(y);                               // get the raw data
  bram.portA.request.put(makeRequest(True, writeAddr, data));   // write the data to BRAM
  countWrd <= isEOP ? 1 : countWrd + 1;                         // update our count of message length
  if (isEOP) msgF.enq(countWrd);                                // send a token to read port on EOP
  writeAddr <= generateAddr(isEOP, writeAddr);                  // update the Write Address
endrule

rule readReqBRAM(msgF.notEmpty);                                // When we have a read mesg token...
  let x = msgF.first;                                           // get the length of the message
  Bool isEOP = (countRdReq==x);                                 // detect EOP on match
  if(countRdReq < x)                                            // don't read past end of message
    bram.portB.request.put(makeRequest(False, readAddr, 0));    // issue read request
  countRdReq <= isEOP ? 0 : countRdReq + 1;                     // update our read request position
  readAddr <= generateAddr(isEOP, readAddr);                    // update the Read Address
endrule

rule readBRAM;                                                  // For every read response from BRAM...
  let d <- bram.portB.response.get;                             // get the data
  Bool isEOP = (countRd == msgF.first-1);                       // check if it is an EOP
  countRd <= isEOP ? 0 : countRd + 1;                           // update our read response position
  Mesg m = isEOP ? tagged ValidEOP d : tagged ValidNotEOP d;    // form the output message
  mesgOutF.enq(m);                                              // send it off
//  if(isEOP) msgF.deq;                                           // if an EOP, take a token
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);

interface LenShowIfc length;
  method UInt#(9) lenShow();
    return msgF.first();
  endmethod

  method Action dwm();
    msgF.deq();
  endmethod
endinterface

endmodule
