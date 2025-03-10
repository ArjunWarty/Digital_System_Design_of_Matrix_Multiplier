module out_reg (reset, CLK, cf_load,
                out_sclr, ouputcon, out_gate); 
                
input   cf_load, reset, CLK;

/*control output latch*/
output  out_sclr;                   //initialization output reg syncheonous clear//
output  reg [3:0] ouputcon;         //initialization 10 outputs data store signal//
output  reg out_gate; 

reg         [4:0]cs;                //current state
reg         [4:0]ns;                //next state

parameter s0  = 5'b00000,
          s1  = 5'b00001,
          s2  = 5'b00010,
          s3  = 5'b00011,
          s4  = 5'b00100,
          s5  = 5'b00101,
          s6  = 5'b00110,
          s7  = 5'b00111,
          s8  = 5'b01000,
          s9  = 5'b01001,
          s10 = 5'b01010,
          s11 = 5'b01011,
          s12 = 5'b01100,
          s13 = 5'b01101,
          s14 = 5'b01110,
          s15 = 5'b01111,
          s16 = 5'b10000,
          s17 = 5'b10001,
          s18 = 5'b10010,
          s19 = 5'b10011,
          s20 = 5'b10100,
          s21 = 5'b10101,
          s22 = 5'b10110,
          s23 = 5'b10111,
          s24 = 5'b11000,
          s25 = 5'b11001,
          s26 = 5'b11010,
          s27 = 5'b11011,
          s28 = 5'b11100,
          s29 = 5'b11101;
          
always@(posedge CLK or posedge reset )
	if (reset == 1'b1)
		cs <= s0;
    else
		cs <= ns;
		
		always@(cs or cf_load)
			begin
			ouputcon   [3:0]  <= 4'b0;
			out_gate          <= 0;		
			case(cs)
				s0: begin
					if (cf_load == 1'b1)
                     ns <= s1;
                    else
                     ns <= s0;
					end
					
				s1: begin
					ns        <= s2;
					end
					
				s2: begin
					ns        <= s3; 
					end
					
				s3: begin
					ns        <= s4; 
					out_gate  <= 1;
					end
					
				s4: begin
					ns        <= s5;
					out_gate  <= 1;                	
					ouputcon [3:0]  <= 4'b0001;                //store b11 to B1 out_reg
					end
					
				s5: begin
					ns        <= s6;
					out_gate  <= 1;
					end
					
				s6: begin
					ns        <= s7;
					out_gate  <= 1;
					end
					
				s7: begin
					ns        <= s8; 
					out_gate  <= 1;
					ouputcon [3:0]  <= 4'b0010;                 //store b12 to B2 out_reg
					
					end	
					
				s8: begin
					ns        <= s9; 
					out_gate  <= 1;
					end	
					
				s9: begin
					ns        <= s10;
					out_gate  <= 1;
					end	
					
				s10:begin
					ns        <= s11;
					out_gate  <= 1;		
					ouputcon [3:0]  <= 4'b0011;            //store b13 to B3 out_reg
					end	
					
				s11:begin
					ns         <= s12;
					out_gate   <= 1;
					end	
				
				s12:begin
					ns         <= s13;
					out_gate   <= 1;
					end
					
				s13:begin
					ns         <= s14;
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b0100;            //store b14 to B4 out_reg 
					end
									
				s14:begin	
					ns         <= s15;
					out_gate   <= 1;
					ouputcon [3:0]   <= 4'b0101;           //store b22 to B5 out_reg 
					end	
					
				s15:begin
					ns 		   <= s16;
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b0110;            //store b23 to B6 out_reg
					end	
					
				s16:begin	
					ns 		   <= s17;
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b0111;            //store b24 to B7 out_reg 
					end	
					
				s17:begin
					ns 		   <= s18;
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b1000;            //store b33 to B8 out_reg
					end	
			
				s18:begin
					ns         <= s19; 
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b1001;          //store b34 to B9 out_reg
					end	
					
				s19:begin
					ns         <= s20;
					out_gate   <= 1;
					ouputcon [3:0]  <= 4'b1010;          //store b44 to B10 out_reg	
					end	
					
				s20:begin
					ns 		   <= s21;
					out_gate   <= 1;
					end	
					
				s21:begin
					ns         <= s22;
					end
	      
/*s22-s25 do the */		      	
				s22:begin
					ns 		   <= s23;
					end
	      	
				s23:begin
					ns 		   <= s24;
					end
	      	
				s24:begin
					ns 		   <= s25;
					end
	      	
				s25:begin
					ns 		   <= s26;
					end
					
/*s26-s29 do the */	      	
				s26:begin
					ns 		   <= s27;
					end	
	      
				s27:begin
					ns         <= s28; 
					end
	      	
				s28:begin
					ns  	   <= s29;
					end
	      		
				s29:begin
					ns 		   <= s1; 
					end	
					
				default: ns <= s0;
			endcase
		end
		
assign out_sclr = (cs==s29) ? 1'b1 : 1'b0 ;
endmodule 

