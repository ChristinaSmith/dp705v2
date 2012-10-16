// Generator.bsv
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

import GetPut     ::*;
import FIFO       ::*;
import Vector     ::*;
import tbDefs     ::*;
import LFSR       ::*;

interface GeneratorIfc;
  interface Get#(Mesg) src;
endinterface
(* synthesize *)
module mkGenerator(GeneratorIfc);

// state instanced here
FIFO#(Mesg)                  mesgOutF   <- mkFIFO;
FIFO#(Bit#(9))               randomF    <- mkFIFO;
Reg#(Bit#(9))                count      <- mkReg(0);
Reg#(Vector#(4, Bit#(8)))    patternV   <- mkReg(unpack('h00010203));
Reg#(Bit#(9))                mesgLen    <- mkReg(5);
Reg#(Vector#(4, Bit#(8)))    initV      <- mkReg(unpack('h01020304));
Reg#(Bool)                   tmp        <- mkReg(True);
LFSR#(Bit#(32))              lfsr       <- mkLFSR_32;
Reg#(Bool)                   seedLFSR   <- mkReg(True);
Reg#(Bool)                   startLFSR  <- mkReg(False);
Reg#(Bit#(9))                minLen     <- mkReg('1);
Reg#(Bit#(9))                maxLen     <- mkReg('0);


function Bit#(8) addX (Bit#(8) y, Bit#(8) x) = y + x;

/*rule setupLFSR(seedLFSR);
  startLFSR <= True;
  seedLFSR <= False;
  lfsr.seed('h55555555);
endrule

rule setMsgLen(startLFSR);
  let p = lfsr.value[31:23];
  if(p>6 && p<242)begin 
    randomF.enq(p);
    minLen <= (p < minLen) ? p : minLen;
    maxLen <= (p > maxLen) ? p : maxLen;
  end
  lfsr.next;
endrule
*/
rule genMesgNotEOP(count < mesgLen -1);
    mesgOutF.enq(tagged ValidNotEOP pack(patternV));
    patternV <= map(addX(4), patternV);
    count <= count + 1;
endrule

rule genMesgEOP(count == mesgLen-1);
    mesgOutF.enq(tagged ValidEOP pack(patternV));
    patternV <= initV;
    initV <= map(addX(1), initV);
    count <= 0;
    mesgLen <= 10;
//    mesgLen <= randomF.first;
//    randomF.deq;
endrule

interface src = toGet(mesgOutF);
endmodule
