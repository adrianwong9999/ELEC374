`timescale 1ns / 10ps
module div_op_tb; 	
	reg	PCout, ZHighout, ZLowout, MDRout, R2Out, R4Out;// add any other signals to see in your simulation
	reg	MARin, PCin, MDRin, IRin, Yin;
	reg 	IncPC, Read;
	reg 	[4:0] DIV; 
	reg 	R5in, R2in, R4in;
	reg	HIin, LOin, ZHighIn, Cin, ZLowIn;
	reg	Clock, Clear;		// US clear
	reg	[31:0] Mdatain;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6= 4'b1101;
reg	[3:0] Present_state= Default;

initial Clear = 0;

cpu_phase1 DUT(PCout, ZHighout, Zlowout, MDRout, R2out, R4out, MARin, Zin, PCin, MDRin, IRin, Yin, IncPC, Read, DIV, R5in, R2in, R4in, Clock, Clear, Mdatain);
	 //the input (in.port) and output (out.port) connects the CPU to the outside world
   //the input (in.port) and output (out.port) connects the CPU to the outside world

initial 
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
	case (Present_state)
		Default			:	#60 Present_state = Reg_load1a;
		Reg_load1a		:	#60 Present_state = Reg_load1b;
		Reg_load1b		:	#60 Present_state = Reg_load2a;
		Reg_load2a		:	#60 Present_state = Reg_load2b;
		Reg_load2b		:	#60 Present_state = Reg_load3a;
		Reg_load3a		:	#60 Present_state = Reg_load3b;
		Reg_load3b		:	#60 Present_state = T0;
		T0					:	#60 Present_state = T1;
		T1					:	#60 Present_state = T2;
		T2					:	#60 Present_state = T3;
		T3					:	#60 Present_state = T4;
		T4					:	#60 Present_state = T5;
		T5					:	#60 Present_state = T6;
		endcase
	end

always @(Present_state)// do the required job ineach state
begin
	case (Present_state)              //assert the required signals in each clock cycle
		Default: begin
				PCout <= 0;   ZLowout <= 0; ZHighout <= 0;  MDRout<= 0;   //initialize the signals
				R2Out <= 0;   R4Out <= 0;   MARin <= 0;   ZLowIn <= 0; ZHighIn <= 0;  
				PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
				IncPC <= 0;   Read <= 0;   DIV <= 0;
				R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000;
		end
		Reg_load1a: begin 
				Mdatain<= 32'h00000007;
				Read = 0; MDRin = 0;	//the first zero is there for completeness
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R2in <= 1;  
				#15 MDRout<= 0; R2in <= 0;     
		end
		Reg_load2a: begin 
				Mdatain <= 32'h00000003;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R4in <= 1;  
				#15 MDRout<= 0; R4in <= 0;
		end
		Reg_load3a: begin 
				Mdatain <= 32'h00000027;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load3b: begin
				#10 MDRout<= 1; R5in <= 1;  
				#15 MDRout<= 0; R5in <= 0;
		end
	
		T0: begin//see if you need to de-assert these signals
				Mdatain <= 32'h00000007; // dummy pc
				PCin <= 1; MDRout <=1;
				
				#10 PCout<= 1; MARin <= 1; IncPC <= 1; 
				#10 PCin <= 0; MDRout <=0; PCout<= 0; MARin <= 0; IncPC <= 0;
		end
		T1: begin
				Mdatain <= 32'h4A920000;  
				Read <= 1; MDRin <= 1;
				#10 Read <= 0; MDRin <= 0;

				
		end
		T2: begin
				MDRout<= 1; IRin <= 1; 
				#10 MDRout<= 0; IRin <= 0; 
		end
		T3: begin
				#10 R2Out<= 1; Yin <= 1;  
				#15 R2Out<= 0; Yin <= 0;
		end
		T4: begin
				R4Out<= 1; DIV <= 5'b01111; ZLowIn <= 1; ZHighIn <= 1;
				#25 R4Out<= 0; ZLowIn <= 0; ZHighIn <= 0;
		end
		T5: begin
				ZLowout<= 1; LOin <= 1; 
				#25 ZLowout<= 0; LOin <= 0;
		end
		T6: begin
				ZHighout<= 1; HIin <= 1; 
				#35 ZHighout<= 0; HIin <= 0;
		end
	endcase
end
endmodule
