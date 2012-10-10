// Checker.bsv - consumer module
// Copyright (c) 2012 Atomic Rules LLC - ALL RIGHTS RESERVED
// Christina Smith

package tbDefs;
typedef union tagged {
  Bit#(32) ValidNotEOP;
  Bit#(32) ValidEOP;
} Mesg deriving (Bits, Eq);




function Bool isEOP(Mesg m);
  case (m) matches
    tagged ValidNotEOP .z: return False;
    tagged ValidEOP    .z: return True;
  endcase
endfunction


function Bit#(32) stripEOPTag(Mesg m);
  case (m) matches
    tagged ValidNotEOP .z: return (z);
    tagged ValidEOP    .z: return (z);
  endcase
endfunction



endpackage



