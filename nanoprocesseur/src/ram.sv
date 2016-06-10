module ram(clk, 
           write, 
           addr, 
           data_in,
           data_out);

   input logic clk;
   input logic write;
   input logic [7:0] addr;
   input logic [7:0] data_in;
   output logic [7:0] data_out;
   
   // Instanciation de la RAM (ici : 256 mots de 8 bits)
   logic [7:0] ram_t[0:255];
   
   initial
     begin
        // initialisation de la RAM avec le fichier d'initialisation
          $readmemh("../assembleur/ram.lst", ram_t);
     end

   always_ff @ (posedge clk) 
     if(write)
       ram_t[addr] <= data_in;


   always_ff @ (posedge clk) 
     data_out <= ram_t[addr];
   

   
endmodule
