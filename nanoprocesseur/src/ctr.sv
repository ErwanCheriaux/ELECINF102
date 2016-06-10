/* 
 
 Ce bloc est un automate au coeur du processeur.
 C'est lui qui séquence les opérations des autres modules (PC, I, ALU, ...)
 
 Les sorties dépendent de l'état courant et éventuellement des entrées.
 Le calcul des sorties est purement combinatoire.
 
 */

module CTR(	input logic clk,
			input logic  reset_n, 
			input logic[7:0] I,
			input logic  Z,
			input logic  C,
 
			output logic load_OUT,
			output logic load_ACC,
			output logic load_I,
			output logic load_AD,
			output logic inc_PC,
			output logic load_PC,
			output logic sel_adr,
			output logic write
			);

 // Placer votre code 
     
   enum logic[1:0]     {IF, AF, EXE} etat;
   
 // Automate
   always@(posedge clk or negedge reset_n)
     if(!reset_n)
       etat <= IF;
       else
	 case(etat)
	   IF	: etat <= AF;
	   AF	: etat <= EXE;
	   EXE	: etat <= IF;
	 endcase  	 

     
// Gestion des sorties
   always @(*)
     begin
	load_OUT <= (etat == EXE);
	load_ACC <= (etat == EXE) && (I != 0) && (I<13);
	load_I <= (etat == IF);
	load_AD <= (etat == AF);
	inc_PC <= (etat == IF) || (etat == AF);
	load_PC <= (etat == AF);
	sel_adr <= (etat == EXE);
	write <= (etat == EXE);
     end
   
   
endmodule // CTR

