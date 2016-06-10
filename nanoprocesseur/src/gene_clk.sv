`default_nettype none
  module gene_clk(clk_50,
                  clk_1s,
                  clk_1M);
   
   input logic  clk_50;
   output logic clk_1s;
   output logic clk_1M;
               
   // Compteur de division de l'horloge à 50MHz
   bit [25:0] cpt;

   always_ff @(posedge clk_50)
     if (cpt == 49_999_999)
       cpt <= 0;
     else
       cpt <= cpt + 1;

   always_ff @(posedge clk_50)
     clk_1s <= cpt < 25_000_000;

   always_ff @(posedge clk_50)
     clk_1M <= cpt[3];

   
  
endmodule // gene_clk






   
