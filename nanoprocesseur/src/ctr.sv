/* 
 
 Ce bloc est un automate au coeur du processeur.
 C'est lui qui s�quence les op�rations des autres modules (PC, I, ALU, ...)
 
 Les sorties d�pendent de l'�tat courant et �ventuellement des entr�es.
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
            // entre ICI 


            // Et la...

endmodule // CTR

