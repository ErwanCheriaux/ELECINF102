`default_nettype none

  module nanoprocesseur (clk, reset_n,
                         ram_write, ram_addr, ram_data_read, ram_data_write,
                         out, I);
   // Entrées globales
   input logic       clk;
   input logic       reset_n;
   
   // Entrées-sorties allant à la RAM
   output logic       ram_write;
   output logic [7:0] ram_addr;
   input  logic [7:0] ram_data_read;
   output logic [7:0] ram_data_write;

   // Sortie de commande du haut-parleur et des LEDS
   output logic [7:0] out;

   // Sortie du registre d'instruction pour le debug
   output logic [7:0] I;

   /************************************
    *  Signaux internes                *  
    ************************************/
   
   // Signaux du PC
   logic         inc_PC;
   logic         load_PC;
   logic [7:0]        PC;

   // Signaux de l'ALU
   logic [7:0]   ALU_out;
   logic         C_out;
   logic         Z_out;
   logic [7:0]   accu;

   // Signaux de l'accumulateur
   logic         load_ACC;
   logic         C;
   logic         Z;
   
   // Registre d'instructions
   // logic [7:0]   I; (déjà déclaré, cf plus haut)
   logic         load_I;
   
   // Signaux du registre d'adresses
   logic         load_AD;
   logic [7:0]   AD;
      
   // Signal de controle du mux d'adresses
   logic         sel_adr;
   
   // Signaux du registre du buzzer
   logic         load_OUT;
   


   
   /**************************************
    * Instanciation des modules internes *
    **************************************/

   // Instanciation du PC
   // Sur front montant de l'horloge :
   //   - si load_PC == 0 et inc_PC == 0, il garde sa valeur 
   //   - si load_PC == 1, PC échantilonne la valeur présente sur ram_data_read
   //   - si inc_PC  == 1, PC devient PC + 1

   REG_PC REG_PC(.clk(clk),
                 .reset_n(reset_n), 
                 .inc_PC(inc_PC), 
                 .load_PC(load_PC), 
                 .data_in(ram_data_read), 
                 .PC(PC));

   
   // Instanciation de l'ALU : cf http://sen.enst.fr/bci/pan1A/pratique_nanoprocesseur/alu
   ALU ALU(.I(I[3:0]), 
           .B(ram_data_read), 
           .A(accu), 
           .Cin(C),
           .S(ALU_out), 
           .Cout(C_out), 
           .Z(Z_out)
           );
   
   

   // Instanciation du registre d'adresse
   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       AD <= 0;
     else if (load_AD)
       AD <= ram_data_read;

   // Instanciation du registre d'instruction
   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       I <= 0;
     else if (load_I)
       I <= ram_data_read;

   // Instanciation de l'accumulateur
   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       begin
          accu <= 0;
          Z <= 0;
          C <= 0;
       end
     else if (load_ACC)
       begin
          accu <= ALU_out;
          Z <= Z_out;
          C <= C_out;
       end

   assign ram_data_write = accu;

   
   // Instanciation du registre buzzer et LEDS
   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       out <= 0;
     else if (load_OUT)
       out <= ram_data_read;


   // Instanciation du contrôleur (séquenceur)
   CTR CTR(.clk(clk), 
           .reset_n(reset_n), 
           .I(I), 
           .Z(Z), 
           .C(C), 
           .load_OUT(load_OUT), 
           .load_ACC(load_ACC), 
           .load_I(load_I), 
           .load_AD(load_AD), 
           .inc_PC(inc_PC), 
           .load_PC(load_PC), 
           .sel_adr(sel_adr), 
           .write(ram_write)
           );
   
   // Instanciation du MUX d'adresses
   assign       ram_addr = sel_adr ?  AD : PC;

endmodule // nanoprocesseur
