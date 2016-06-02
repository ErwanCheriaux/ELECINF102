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
	logic [9:0] sortie;
	logic [25:0] cpt;  // 2^26 => 64M > 50_000_000	
	logic clk_div;
	logic g_a_d;

	logic [7:0] pwm;
	logic [7:0] seuil;
	logic [1:0] mode;
	logic etat;
	
	always @(*) 
	begin
	mode <= sw[1:0];
	case(mode)
	
		2'd 0: seuil <= 8'd 63;
		2'd 1: seuil <= 8'd 127;
		2'd 2: seuil <= 8'd 191;
		2'd 3: seuil <= 8'd 255;
	
	endcase
	end
	
	always @(posedge clock_50)
	if(clk_div)
	begin
	if(pwm > seuil)
		etat=1;
	else
		etat=0;
	if(pwm==255)
	pwm<=0;
	else
	pwm<= pwm+1;
	end
	
	// Compteur (diviseur de freq)
	always @(posedge clock_50)
	if(cpt == 2000 -1) 
		begin
		cpt <= 0;
		clk_div <= 1;
		end
	else
		begin
		cpt <= cpt +1;
		clk_div <= 0;
		end
		
	always @(*) ledr[0] <= etat;
	
endmodule 