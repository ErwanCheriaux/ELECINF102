//`default_nettype none

module dec7seg (        
        ////////////////////////    DPDT Switch        ///////////////////////
        input logic   [3:0]    i,              //    Toggle Switch[9:0]
        ////////////////////////    7-SEG Dispaly    /////////////////////////
        output logic  [6:0]    o            //    Seven Segment Digit 0
     
		  );
   
	// ajouter votre code à partir d'ici
	always @(*)
		case(i)
			
			4'h0: o <= 7'b 1000000;
			4'h1: o <= 7'b 1111001;
			4'h2: o <= 7'b 0100100;
			4'h3: o <= 7'b 0110000;
			4'h4: o <= 7'b 0011001;
			4'h5: o <= 7'b 0010010;
			4'h6: o <= 7'b 0000010;
			4'h7: o <= 7'b 1111000;
			4'h8: o <= 7'b 0000000;
			4'h9: o <= 7'b 0010000;
			4'ha: o <= 7'b 0001000;
			4'hb: o <= 7'b 0000011;
			4'hc: o <= 7'b 0100111;
			4'hd: o <= 7'b 0100001;
			4'he: o <= 7'b 0000110;
			4'hf: o <= 7'b 0001110;
					
		endcase
	
endmodule
