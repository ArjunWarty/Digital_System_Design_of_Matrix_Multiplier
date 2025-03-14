module cal_controller(reset, CLK, cf_load, x1, y1, x2, y2, x3, y3, sclr, out_sel);                      
input   cf_load, reset, CLK;
output  reg [3:0] x1,y1;
output  reg [3:0] x2,y2;
output  reg [3:0] x3,y3;
output  sclr; 
output  reg [3:0] out_sel;         //10 output value
reg         [4:0]pstate;            
reg         [4:0]nstate;                
parameter s0  = 5'b00000,          s1  = 5'b00001,          s2  = 5'b00010,          s3  = 5'b00011,
          s4  = 5'b00100,          s5  = 5'b00101,          s6  = 5'b00110,          s7  = 5'b00111,
          s8  = 5'b01000,          s9  = 5'b01001,          s10 = 5'b01010,          s11 = 5'b01011,
          s12 = 5'b01100,          s13 = 5'b01101,          s14 = 5'b01110,          s15 = 5'b01111,
          s16 = 5'b10000,          s17 = 5'b10001,          s18 = 5'b10010,          s19 = 5'b10011,
          s20 = 5'b10100,          s21 = 5'b10101,          s22 = 5'b10110;
                   
always@(posedge CLK or posedge reset )
	if (reset == 1'b1)
		pstate <= s0;
    else
		pstate <= nstate;
		
		always@(pstate or cf_load)
			begin
			x1 <= 4'b0; 
			x2 <= 4'b0;
			x3 <= 4'b0;
			y1 <= 4'b0;
			y2 <= 4'b0;
			y3 <= 4'b0;
			out_sel [3:0]    <= 4'b0;
			case(pstate)
				s0: begin
					if (cf_load == 1'b1)
                     nstate <= s1;
                    else
                     nstate <= s0;
					end
					
				s1: begin
					nstate<= s2;
					end
					
				s2: begin
					nstate<= s3; 
					end
					
				s3: begin
					nstate <= s4; 
					end
					
				s4: begin
					nstate<= s5;					
					end
					
				s5: begin
					nstate<= s6;
					end
					
				s6: begin
					nstate<= s7;
					end
					
				s7: begin
					nstate<= s8; 
					end	
					
				s8: begin
					nstate <= s9; 
					end	
					
				s9: begin
					nstate <= s10;
					end	
					
				s10:begin
					nstate <= s11;
					x1<= 4'b0001; 
					x2 <= 4'b0010;
					x3 <= 4'b0011;
	     
					y1<= 4'b0001;
					y2 <= 4'b0010;
					y3<= 4'b0011;                             // b11 = a11^2+a21^2+a31^2
               		out_sel [3:0]  <= 4'b0001;                
					end	
					
				s11:begin
					nstate <= s12;
					x1     <= 4'b0001; 
					x2     <= 4'b0010;
					x3     <= 4'b0011;
					y1     <= 4'b0100;
					y2     <= 4'b0101;
					y3     <= 4'b0110;                       //b12 = a11*a12+a21*a22+a31*a32
               		out_sel [3:0]  <= 4'b0010;  
					end	
				
				s12:begin
					nstate <= s13;
					x1     <= 4'b0001; 
					x2     <= 4'b0010;
					x3     <= 4'b0011;
	      			y1     <= 4'b0111;
					y2     <= 4'b1000;
					y3     <= 4'b1001;                       // b13 = a11*a13+a21*a23+a31*a33
					out_sel [3:0]  <= 4'b0011; 
					end
					
				s13:begin
					nstate <= s14;	
					x1     <= 4'b0001; 
					x2     <= 4'b0010;
					x3     <= 4'b0011;
	      			y1     <= 4'b1010;
					y2     <= 4'b1011;
					y3     <= 4'b1100;                      // b14 = a11*a14+a21*a24+a31*a34
					out_sel [3:0]  <= 4'b0100;        
					end
									
				s14:begin	
					nstate <= s15;
				    x1     <= 4'b0100; 
					x2     <= 4'b0101;
					x3     <= 4'b0110;
	      			y1     <= 4'b0100;
					y2     <= 4'b0101;
					y3     <= 4'b0110;                       //  b22=a12^2+a22^2+a32^2
					out_sel [3:0]   <= 4'b0101;              	
					end
					
				s15:begin
					nstate <= s16;
					x1     <= 4'b0100; 
					x2     <= 4'b0101;
					x3    <= 4'b0110;
	      			y1     <= 4'b0111;
					y2     <= 4'b1000;
					y3     <= 4'b1001;                       // b23= a12*a13+a22*a23+a32*a33
					out_sel [3:0]  <= 4'b0110;              
					end	
					
				s16:begin	
					nstate <= s17;
					x1     <= 4'b0100; 
					x2     <= 4'b0101;
					x3     <= 4'b0110;
	      			y1     <= 4'b1010;
					y2     <= 4'b1011;
					y3     <= 4'b1100;                       // b24= a12*a14+a22*a24+a32*a34
					out_sel [3:0]  <= 4'b0111;            
					end	
					
				s17:begin
					nstate <= s18;
					x1     <= 4'b0111; 
					x2     <= 4'b1000;
					x3     <= 4'b1001;
	      			y1    <= 4'b0111;
					y2     <= 4'b1000;
					y3     <= 4'b1001;                    // b33=a13^2+a23^2+a33^2
					out_sel [3:0]  <= 4'b1000;           
					end	
			
				s18:begin
					nstate <= s19; 
					x1     <= 4'b0111; 
					x2     <= 4'b1000;
					x3     <= 4'b1001;
	      			y1     <= 4'b1010;
					y2     <= 4'b1011;
					y3     <= 4'b1100;                   // do b34=a13*a14+a23*a24+a33*a34
					out_sel [3:0]  <= 4'b1001;             
					end	
					
				s19:begin
					nstate <= s20;
					x1     <= 4'b1010; 
					x2     <= 4'b1011;
					x3     <= 4'b1100;
	      			y1     <= 4'b1010;
					y2     <= 4'b1011;
					y3     <= 4'b1100;               // b44 = a14^23+a24^2+a34^2	
					out_sel [3:0]  <= 4'b1010;       
					end	
					
				s20:begin
					nstate 		   <= s21;
					end	
					
				s21:begin
					nstate         <= s22;
					end
	      	      	
				s22:begin
					nstate 		   <= s4;
					end

				default: nstate <= s0;
			endcase
		end
		
assign sclr = (pstate==s22) ? 1'b1 : 1'b0 ;
endmodule 