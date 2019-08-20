module out_controller(reset, CLK, cf_load, output_sel, output_rdy);
                              
input   cf_load, reset, CLK;
 
/*control output*/
output  reg [3:0] output_sel;        //output_sel
output  reg output_rdy;

reg         [4:0]pstate;                //current state
reg         [4:0]nstate;                //next state

parameter s0  = 5'b00000,    s1  = 5'b00001,    s2  = 5'b00010,    s3  = 5'b00011,
          s4  = 5'b00100,    s5  = 5'b00101,    s6  = 5'b00110,    s7  = 5'b00111,
          s8  = 5'b01000,    s9  = 5'b01001,    s10 = 5'b01010,    s11 = 5'b01011,
          s12 = 5'b01100,    s13 = 5'b01101,    s14 = 5'b01110,    s15 = 5'b01111,
          s16 = 5'b10000,    s17 = 5'b10001,    s18 = 5'b10010,    s19 = 5'b10011,
          s20 = 5'b10100,    s21 = 5'b10101,    s22 = 5'b10110,    s23 = 5'b10111,
          s24 = 5'b11000,    s25 = 5'b11001,    s26 = 5'b11010,    s27 = 5'b11011,
          s28 = 5'b11100,    s29 = 5'b11101;
          
always@(posedge CLK or posedge reset )
	if (reset == 1'b1)
		pstate <= s0;
    else
		pstate <= nstate;
		
		always@(pstate or cf_load)
			begin
			output_sel  [3:0]  <= 4'b0;                                     
			output_rdy        <= 0;
			
			case(pstate)
				s0: begin
					if (cf_load == 1'b1)
                     nstate <= s1;
                    else
                     nstate <= s0;
					end
					
				s1: begin
					nstate        <= s2;
					end
					
				s2: begin
					nstate        <= s3; 
					end
					
				s3: begin
					nstate        <= s4; 
					end
					
				s4: begin
					nstate        <= s5;					
					end
					
				s5: begin
					nstate        <= s6;
					end
					
				s6: begin
					nstate        <= s7;
					end
					
				s7: begin
					nstate        <= s8; 
					end	
					
				s8: begin
					nstate        <= s9; 
					end	
					
				s9: begin
					nstate        <= s10;
					end	
					
				s10:begin
					nstate        <= s11;
					end	
					
				s11:begin
					nstate         <= s12;
					end	
				
				s12:begin
					nstate         <= s13;
					end
					
				s13:begin
					nstate         <= s14;
					output_rdy <= 1;                       //set the output_rdy hign, the next cycle will show out the first output result  
					end
									
				s14:begin	
					nstate         <= s15;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0001;           //output B1 (b11) 
					end	
					
				s15:begin
					nstate 		   <= s16;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0010;           //output B2 (b12)
					end	
					
				s16:begin	
					nstate 		   <= s17;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0011;           //output B3 (b13) 
					end	
					
				s17:begin
					nstate 		   <= s18;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0100;           //output B4 (b14) 
					end	
			
				s18:begin
					nstate         <= s19; 
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0010;           //output B2 (b21)
					end	
					
				s19:begin
					nstate         <= s20;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0101;          //output B5 (b22)		
					end	
					
				s20:begin
					nstate 		   <= s21;
					output_rdy <= 1;				
					output_sel [3:0]  <= 4'b0110;          //output B6 (b23)	
					end	
					
				s21:begin
					nstate         <= s22;
					output_rdy <= 1;				
					output_sel [3:0]  <= 4'b0111;          //output B7 (b24)
					end
	      
/*s22-s25 do the */		      	
				s22:begin
					nstate 		   <= s23;
					output_rdy <= 1;			
					output_sel [3:0]  <= 4'b0011;          //output B3 (b31)
					end
	      	
				s23:begin
					nstate 		   <= s24;
					output_rdy <= 1;					
					output_sel [3:0]  <= 4'b0110;          //output B6 (b32)
					end
	      	
				s24:begin
					nstate 		   <= s25;
					output_rdy <= 1;				
					output_sel [3:0]  <= 4'b1000;          //output B8 (b33)
					end
	      	
				s25:begin
					nstate 		   <= s26;
					output_rdy <= 1;		
					output_sel [3:0]  <= 4'b1001;          //output B9 (b34)
					end
					
/*s26-s29 do the */	      	
				s26:begin
					nstate 		   <= s27;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b0100;          //output B4 (b41)
					end	
	      
				s27:begin
					nstate         <= s28; 
					output_rdy <= 1;					
					output_sel [3:0]  <= 4'b0111;          //output B7 (b42)
					end
	      	
				s28:begin
					nstate  	   <= s29;
					output_rdy <= 1;
					output_sel [3:0]  <= 4'b1001;          //output B9 (b43)
					end
	      		
				s29:begin
					nstate 		   <= s11; 
					output_sel [3:0]  <= 4'b1010;          //output B10 (b44)
					end	
					
				default: nstate <= s0;
			endcase
		end
endmodule 