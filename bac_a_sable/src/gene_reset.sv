module gene_reset(clk, key, reset_n);
   input  clk,key;
   output  reset_n;

// Les attributs de synthèse servent à enmpêcher l'optimisation
  logic reset_n   /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */ ;
  logic reset_r /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */; 

   always @(posedge clk or negedge key)
   if (!key)
   begin
     reset_r <= 1'b0;
     reset_n <= 1'b0 ;
   end
   else
   begin
     reset_r <= 1'b1 ;
     reset_n <= reset_r ;
   end

endmodule
