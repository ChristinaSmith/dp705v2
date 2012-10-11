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
import MHReciever  ::*;
import FIFO        ::*;
import tbDefs      ::*;


module mkFTop_dp705 (Empty);

// state instanced here
GeneratorIfc     gen1         <- mkGenerator(True);
GeneratorIfc     gen2         <- mkGenerator(False);
CheckerIfc       chk          <- mkChecker;
BufferIfc        buf1         <- mkBuffer;
MHSenderIfc      mhsnd        <- mkMHSender;
MHRecieverIfc    mhrcv        <- mkMHReciever;
Reg#(Bit#(16))   cycleCounter <- mkReg(0);
Reg#(UInt#(9))   length       <- mkReg(0);
FIFO#(Mesg)      s2rF         <- mkFIFO;


// rules here
rule cycleCount;
  cycleCounter <= cycleCounter + 1;
endrule

rule gobble;
  if(cycleCounter==15000)$finish;
endrule

//From Generator1 to Double Buffer
mkConnection(gen1.src, buf1.sink);

//From Double Buffer to MHSender
mkConnection(buf1.newLen, mhsnd.newLen);

rule cnctDwm(mhsnd.getLen.dwm);
  buf1.length.dwm();
endrule

mkConnection(buf1.src, mhsnd.sink);

//From MHSender to MHReciever
//mkConnection(mhsnd.src, mhrcv.sink);

//From MHSender to s2rF
mkConnection(mhsnd.src, toPut(s2rF));

//From s2rF to MHReciever
mkConnection(toGet(s2rF), mhrcv.sink);

//From MHReciever to Checker
mkConnection(mhrcv.src, chk.sink1);


//From Generator1 to Checker
mkConnection(gen2.src, chk.sink2);

endmodule
