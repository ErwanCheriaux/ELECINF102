/* 
 Ce module est le registre PC.
  Sur front montant de l'horloge :
    - si load_PC == 0 et inc_PC == 0, il garde sa valeur 
    - si load_PC == 1, PC échantilonne la valeur présente sur data_in
    - si inc_PC  == 1, PC devient PC + 1 
 */

module REG_PC(	input logic clk,
				input logic reset_n,
				input logic inc_PC,
				input logic load_PC,
				input logic [7:0] data_in,
				output logic [7:0] PC
                );

  // Ajoutez votre code d'ici
  
  
  
  // A là...
   
endmodule // PC

   
