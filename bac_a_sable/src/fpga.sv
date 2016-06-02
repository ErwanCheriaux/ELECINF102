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
	
	always @(posedge clk or negedge reset_n)	
	if(~reset_n)
	begin
		sortie <=  8'd0;
	end	
	else
	begin
		sortie <= sortie + 1;
	end
	
	always @(*) ledr <= sortie;
 
endmodule