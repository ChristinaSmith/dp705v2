// Buffer.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import FIFOF      ::*;
import Vector     ::*;
import tbDefs     ::*;
import BRAM       ::*;
import Accum      ::*;

interface LenShowIfc;
  method Action dwm();
endinterface

interface BufferIfc;
  interface Get#(Mesg) src;
  interface Put#(Mesg) sink;
  interface Get#(UInt#(9)) newLen;
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
FIFOF#(UInt#(9))             msgF            <- mkFIFOF1;
Reg#(UInt#(9))               countWrd        <- mkReg(1); 
Reg#(UInt#(9))               countRdReq      <- mkReg(0);
Reg#(UInt#(9))               countRd         <- mkReg(0);
Reg#(UInt#(9))               readAddr        <- mkReg(0);
Reg#(UInt#(9))               writeAddr       <- mkReg(0);
Accumulator2Ifc#(Bit#(8))    accum           <- mkAccumulator2;
FIFO#(UInt#(9))              lenF            <- mkFIFO;
Reg#(Bool)                   newMsg          <- mkReg(True);

BRAM_Configure cfg = defaultValue;
cfg.memorySize = 512;
cfg.latency    = 1;
BRAM2Port#(UInt#(9), Bit#(32)) bram <- mkBRAM2Server(cfg);

rule writeBRAM;                                                 // For every incident Mesg word...
  let y = mesgInF.first; mesgInF.deq;                           // dequeue the incident Mesg
  Bool isEOP = tbDefs::isEOP(y);                                // detect if is an EOP
  Bit#(32) data = stripEOPTag(y);                               // get the raw data
  bram.portA.request.put(makeRequest(True, writeAddr, data));   // write the data to BRAM
  accum.acc1(1);
  countWrd <= isEOP ? 1 : countWrd + 1;                         // update our count of message length
  if (isEOP) msgF.enq(countWrd);                                // send a token to read port on EOP
  writeAddr <= generateAddr(isEOP, writeAddr);                  // update the Write Address
endrule

//can i use implicit conditions for msgF .. do i need if?
rule readReqBRAM(countRdReq<msgF.first && accum > 0);                        // When we have a read mesg token...
//  if(countRdReq < msgF.first-1) begin                         // don't read past end of message
    bram.portB.request.put(makeRequest(False, readAddr, 0));    // issue read request
    accum.acc2(-1);
    //let x = msgF.first-1;                                     // get the length of the message
    Bool isEOP = (countRdReq==msgF.first-1);                    // detect EOP on match
    countRdReq <= isEOP ? 0 : countRdReq + 1;                   // update our read request position
    readAddr <= generateAddr(isEOP, readAddr);                  // update the Read Address
//  end
endrule

rule readBRAM;                                                  // For every read response from BRAM...
  let d <- bram.portB.response.get;                             // get the data
  Bool isEOP = (countRd == msgF.first-1);                       // check if it is an EOP
  countRd <= isEOP ? 0 : countRd + 1;                           // update our read response position
  Mesg m = isEOP ? tagged ValidEOP d : tagged ValidNotEOP d;    // form the output message
  mesgOutF.enq(m);                                              // send it off
//  if(isEOP) msgF.deq;                                         // if an EOP, take a token
endrule

rule newLength(newMsg);
  lenF.enq(msgF.first);
  newMsg <= False;
endrule

interface src  = toGet(mesgOutF);
interface sink = toPut(mesgInF);
interface newLen = toGet(lenF);

interface LenShowIfc length;
  method Action dwm();
    msgF.deq();
    newMsg <= True;
  endmethod
endinterface

endmodule
