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
	logic [1:0]push_inc_etat;		
	logic [1:0]push_dec_etat;		
	logic clk_div;
	logic mode;
	logic inc;
	logic dec;	
	
	// choisir le mode avec le swtich sw[0]
	always @(*) mode <= sw[0];
	
	// Sauvegarde de l'état actuel et de l'état précédent et permet de decaler automatiquement
	always @(posedge clock_50)
	begin
		push_inc_etat <= {push_inc_etat[0], key[1]};
	push_dec_etat <= {push_dec_etat[0], key[2]};

	end
	
	// mise a jour des boutons inc et dec lors d'un front montant
	always@(*)
	begin
	   inc <= !push_inc_etat[0] && push_inc_etat[1];
		dec <= !push_dec_etat[0] && push_dec_etat[1];
	end
	
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
	
	always @(posedge clock_50)
	if(!reset_n)
			sortie <=  8'd0;
	else		
		if (mode) 
			begin
				if (clk_div) sortie <= sortie + 1;	// Compteur (auto)
			end	
		else
			begin
				if (inc)	sortie <= sortie + 1;
				if (dec)	sortie <= sortie - 1;
			end	 
	
	always @(*) ledr <= sortie;
	
	dec7seg dec0(.i(sortie[3:0]),.o(hex0));
	dec7seg dec1(.i(sortie[7:4]),.o(hex1));
	
endmodule