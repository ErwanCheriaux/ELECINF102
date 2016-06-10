`default_nettype none

module simu;
   
   // Signaux globaux
   logic        reset_n;
   logic        sclk;

   // commande du haut-parleur
   logic [7:0]  out;

   // Les signaux relies a la RAM
   logic       ram_write;
   logic [7:0] ram_addr;
   logic [7:0] ram_data_read;
   logic [7:0] ram_data_write;

   // Signaux de debug du processeur
   logic [7:0] I;
   

   // Emulation d'une horloge et d'un reset
   initial
     begin
        reset_n <= 0;
        sclk <= 0;
        repeat (10) 
          @(posedge sclk);
        reset_n <= 1;
     end

   always
     #10 sclk <= ~sclk;

   nanoprocesseur proc1
     (
      .clk(sclk),
      .reset_n(reset_n),
      .ram_data_write(ram_data_write),
      .ram_data_read(ram_data_read),
      .ram_write(ram_write),
      .ram_addr(ram_addr),
      .out(out),
      .I(I)
      );
   
   
   ram mem1
     (
      .clk(~sclk),
      .addr(ram_addr),
      .write(ram_write),
      .data_out(ram_data_read),
      .data_in(ram_data_write)
      );
   
   disass disass(proc1.I[3:0]);
   
   
endmodule
