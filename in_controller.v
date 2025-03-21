module in_controller(reset, clk, cf_load, clr, select, select_in);
input  cf_load, reset, clk;                    //input 
output clr;  
output reg [3:0] select;                       //12 input reg
output reg select_in;               
reg    [4:0] pstate, nstate;          

parameter s0  = 5'b00000,      s1  = 5'b00001,      s2  = 5'b00010,      s3  = 5'b00011,    
          s4  = 5'b00100,      s5  = 5'b00101,      s6  = 5'b00110,      s7  = 5'b00111,
          s8  = 5'b01000,      s9  = 5'b01001,      s10 = 5'b01010,      s11 = 5'b01011,
          s12 = 5'b01100,      s13 = 5'b01101,      s14 = 5'b01110,      s15 = 5'b01111,
          s16 = 5'b10000,      s17 = 5'b10001,      s18 = 5'b10010,      s19 = 5'b10011;
                                                                            //20 state, including 1 initiation state
always@(posedge clk or posedge reset)
	begin
		if (reset == 1'b1)
			pstate <= s0; 
		else
		    pstate <= nstate;
	end
	
	always@(pstate or cf_load)                             //state transform
		begin
			select [3:0] <= 4'b0;
		    select_in <= 0;

		case(pstate)
			
			s0: begin
					if (cf_load == 1'b1)
						nstate <= s1;
					else
						nstate <= s0;
				end
			
            s1: begin
				    select [3:0] <= 4'b0001;
				    select_in <= 1;
					nstate <= s2;	                      
				end
				
			s2: begin
				    select [3:0] <= 4'b0010;
				    select_in <= 1;
					nstate <= s3;                        
				end

            s3: begin
				    select [3:0] <= 4'b0011;
				    select_in <= 1;
					nstate <= s4;                     
				end

            s4: begin
				    select [3:0]  <= 4'b0100;
				    select_in <= 1; 
					nstate <= s5;                        
				end

			s5: begin
				    select [3:0]  <= 4'b0101;
				    select_in <= 1;
					nstate <= s6;                        
				end

			s6: begin
				    select [3:0]  <= 4'b0110;
				    select_in <= 1;
					nstate <= s7;                        
				end
				
			s7: begin
				    select [3:0]  <= 4'b0111;
				    select_in <= 1;
					nstate <= s8;                        
				end			

			s8: begin
				    select [3:0]  <= 4'b1000;
				    select_in <= 1;
					nstate <= s9;                        
				end	

			s9: begin
				    select [3:0]  <= 4'b1001;
				    select_in <= 1;
					nstate <= s10;                        
				end
				
			s10: begin
				    select [3:0]  <= 4'b1010;
				    select_in <= 1;
					nstate <= s11;                        
				end	
				
			s11: begin
				    select [3:0]  <= 4'b1011;
				    select_in <= 1;
					nstate <= s12;                        
				end
				
			s12: begin
				    select [3:0]  <= 4'b1100;
				    select_in <= 1;
					nstate <= s13;                        
				end	
				
			s13: begin  
					nstate <= s14;
					select_in <= 1; 
				end		
				
			s14: begin
					nstate <= s15;
					select_in <= 0;                        
				end	
			
			s15: begin
					nstate <= s16;
					select_in <= 0;                        
				end		
				
			s16: begin
					nstate <= s17;           
					select_in <= 0;             
				end	
				
			s17: begin
					nstate <= s18;           
					select_in <= 0;             
				end	
				
			s18: begin
					nstate <= s19;           
					select_in <= 0;             
				end
				
			s19: begin
					nstate <= s1;            
					select_in <= 0;            
				end
				
			default: nstate <= s0;
		endcase
	end					

assign clr = (pstate==s19) ? 1'b1 : 1'b0 ;                      //clear the input regs at state 19

endmodule 	