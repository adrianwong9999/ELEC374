/* here we implement the typical bus. we implement the bus using a 32-to-5 encoder and a 32-to-1 mux. note, the mux was created using
a combination of smaller multiplxers. the five select signal inputs for this multiplexer come from our 32-to-5 encoder */

module bus(
  output [31:0] busMuxOut,
  input [31:0] R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, 
  R11in, R12in, R13in, R14in, R15in, HIin, LOin, ZHighIn, ZLowIn, PCin, MDRin,
  inPortIn, C_sign_extended,
  input R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out,
  R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, hiOut, loOut,
  ZHighout, ZLowout, PCout, MDRout, inPortOut, Cout);
  
  /* in the lab instructions, it says that the signals to the 32-to-5 encoder are simulated in phase 1. the lab instructions state that
  the idea is to choose only one of the registers R0 to R15, HI, LO, Zhigh,Zlow, PC, MDR, In.Port, or the sign-extended version of the 
  constant C, as the source of the bus. The output of the BusMux, BusMuxOut,is the Bus itself */
  
  reg [31:0] busOutput;
  always @ (*)
  begin
  if(R0Out == 1)
    busOutput <= R0in;
   else if (R1Out == 1)
    busOutput <= R1in;
   else if (R2Out == 1)
    busOutput <= R2in;
   else if (R3Out == 1)
    busOutput <= R3in;
   else if (R4Out == 1)
    busOutput <= R4in;
   else if (R5Out == 1)
    busOutput <= R5in;
   else if (R6Out == 1)
     busOutput <= R6in;
   else if (R7Out == 1)
    busOutput <= R7in;
   else if (R8Out == 1)
    busOutput <= R8in;
   else if (R9Out == 1)
    busOutput <= R9in;
   else if (R10Out == 1)
    busOutput <= R10in;
   else if (R11Out == 1)
     busOutput <= R11in;
   else if (R12Out == 1)
    busOutput <= R12in;
   else if (R13Out == 1)
    busOutput <= R13in;
   else if (R14Out == 1)
    busOutput <= R14in;
   else if (R15Out == 1)
    busOutput <= R15in;
   else if (hiOut == 1)
    busOutput <= HIin;
  else if (loOut == 1)
    busOutput <= LOin;
  else if (ZHighout == 1)
    busOutput <= ZHighIn;
  else if (ZLowout == 1)
    busOutput <= ZLowIn;
  else if (PCout == 1)
    busOutput <= PCin;
  else if (MDRout == 1)
    busOutput <= MDRin;
  else if (inPortOut == 1)
    busOutput <= inPortIn;
  else if (Cout == 1)
    busOutput <= C_sign_extended;
	else
		busOutput <= 0;
  end

  assign busMuxOut = busOutput;
  
endmodule
  