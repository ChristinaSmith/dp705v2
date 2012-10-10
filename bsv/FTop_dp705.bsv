// FTop_dp705.bsv - the top level module
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith
import Generator   ::*;
import Checker     ::*;
//import SendV1      ::*;
//import RcvV1       ::*;
import GetPut      ::*;
import Connectable ::*;
import Buffer      ::*;
import MHSender    ::*;


module mkFTop_dp705 (Empty);

// state instanced here
GeneratorIfc     gen1         <- mkGenerator(True);
GeneratorIfc     gen2         <- mkGenerator(False);
CheckerIfc       chk          <- mkChecker;
BufferIfc        buf1         <- mkBuffer;
MHSenderIfc      mhsnd        <- mkMHSender;
//SendV1Ifc        send         <- mkSendV1;
//RcvV1Ifc         rcv          <- mkRcvV1;
Reg#(Bit#(16))  cycleCounter  <- mkReg(0);
//FIFO between send and rcv
Reg#(UInt#(9))  length       <- mkReg(0);


// rules here
rule cycleCount;
  cycleCounter <= cycleCounter + 1;
endrule

rule gobble;
  if(cycleCounter==15000)$finish;
endrule

rule cnctMHsnd;
  mhsnd.peek.lenPeek(buf1.length.lenShow());
endrule

rule cnctDwm(mhsnd.peek.dwm);
  buf1.length.dwm();
endrule

mkConnection(gen1.src, buf1.sink);
//imkConnection(buf1.src, chk.sink1);
mkConnection(gen2.src, chk.sink2);

// interfaces provided here

endmodule
