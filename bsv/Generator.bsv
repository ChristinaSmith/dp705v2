// Generator.bsv - Generates stream of type Mesg of pseudo-random length with a terminating word tagged with EOP
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

FIFO#(Mesg)                  mesgOutF   <- mkFIFO;
FIFO#(Bit#(9))               randomF    <- mkFIFO;
Reg#(Bit#(9))                count      <- mkReg(0);
Reg#(Vector#(4, Bit#(8)))    patternV   <- mkReg(unpack('h00010203));
Reg#(Bit#(9))                mesgLen    <- mkReg(10);
Reg#(Vector#(4, Bit#(8)))    initV      <- mkReg(unpack('h01020304));
Reg#(Bool)                   tmp        <- mkReg(True);
Reg#(Bool)                   seedLFSR   <- mkReg(True);
Reg#(Bool)                   startLFSR  <- mkReg(False);
Reg#(Bit#(9))                minLen     <- mkReg('1);
Reg#(Bit#(9))                maxLen     <- mkReg('0);
LFSR#(Bit#(32))              lfsr       <- mkLFSR_32;

function Bit#(8) addX (Bit#(8) y, Bit#(8) x) = y + x;

rule setupLFSR(seedLFSR);                                     // Rule: Give LFSR a seed value
  startLFSR <= True;                                          // Signal LFSR to generate first value in rule setMsgLen
  seedLFSR <= False;                                          // Only give LFSR a seed value once
  lfsr.seed('h55555555);                                      // LFSR seed value
endrule

rule setMsgLen(startLFSR);                                    // Rule: Grab LFSR value and generate another
  let p = lfsr.value[31:23];                                  // Take upper 9 bits of 32 bit LFSR
  if(p>0 && p<255)begin                                       // Only accept values in the range of 0<p<255
    randomF.enq(p);                                           // Save LFSR value for future use as the length of next generated message
    minLen <= (p < minLen) ? p : minLen;                      // Check for new minimum length
    maxLen <= (p > maxLen) ? p : maxLen;                      // Check for new maximum length
  end
  lfsr.next;                                                  // Request new LFSR value
endrule

rule genMesgNotEOP(count < mesgLen - 1);                      // Rule: While we have not reached the end of message
    mesgOutF.enq(tagged ValidNotEOP pack(patternV));          // Output tagged ValidNotEOP pattern
    patternV <= map(addX(4), patternV);                       // Update pattern for next output by adding 4 to each byte
    count <= count + 1;                                       // Increase word count to determine end of message
endrule

rule genMesgEOP(count == mesgLen - 1);                        // Rule: When we have reached the end of message
    mesgOutF.enq(tagged ValidEOP pack(patternV));             // Output tagged ValidEOP pattern (last word of message)
    patternV <= initV;                                        // Give pattern the first word of the next message
    initV <= map(addX(1), initV);                             // Generate the first word of the following message
    count <= 0;                                               // Reset word count
    mesgLen <= randomF.first;                                 // Give mesgLen the next value from LFSR for the next message
    randomF.deq;                                              // Deq LFSR value that was just written to mesgLen
endrule

interface src = toGet(mesgOutF);
endmodule
