`default_nettype none

module fpga (
        ////////////////////////    50MHz Clock        ///////////////////////
        input logic            clock_50,        // 50 MHz
        ////////////////////////    Push Button        ///////////////////////
        input logic   [3:0]    key,             //    Pushbutton[3:0]
        ////////////////////////    DPDT Switch        ///////////////////////
        input logic   [9:0]    sw,              //    Toggle Switch[9:0]
        ////////////////////////    7-SEG Dispaly    /////////////////////////
        output logic  [6:0]    hex0,            //    Seven Segment Digit 0
        output logic  [6:0]    hex1,            //    Seven Segment Digit 1
        output logic  [6:0]    hex2,            //    Seven Segment Digit 2
        output logic  [6:0]    hex3,            //    Seven Segment Digit 3
        output logic  [6:0]    hex4,            //    Seven Segment Digit 4
        output logic  [6:0]    hex5,            //    Seven Segment Digit 5
        ////////////////////////////    LED        ///////////////////////////
        output logic  [9:0]    ledr             //    LED Red[9:0]
        );

   // Génération d'une horloge lente (0.5s de période)
   logic             clk;
   gene_clk gene_clkl(.clk_50(clock_50), .clk_out(clk));

   // Génération d'un reset à partir du bouton key[0]
   logic             reset_n;
   gene_reset gene_reset(.clk(clock_50), .key(key[0]), .reset_n(reset_n));
	
   // ajouter votre code à partir d'ici
   
	logic [7:0] sortie;
	
	logic [25:0] cpt;  // 2^26 => 64M > 50_000_000
	logic clk_div;
	
	// Compteur (diviseur de freq)
	always @(posedge clock_50)
	if(cpt == 50_000_000 -1) 
		begin
		cpt <= 0;
		clk_div <= 1;
		end
	else
		begin
		cpt <= cpt +1;
		clk_div <= 0;
		end
	
	// Compteur (auto)
	always @(posedge clock_50)
	if(!reset_n)
			sortie <=  8'd0;
	else		
		begin
		if (clk_div) sortie <= sortie + 1;		
		end
	
	always @(*) ledr <= sortie;
	
	dec7seg dec0(.i(sortie[3:0]),.o(hex0));
	dec7seg dec1(.i(sortie[7:4]),.o(hex1));
 
endmodule