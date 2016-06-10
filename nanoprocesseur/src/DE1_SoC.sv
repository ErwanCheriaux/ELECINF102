`default_nettype none

module DE1_SoC(

      ///////// aud /////////
      input  wire        aud_adcdat,
      output wire        aud_adclrck,
      output wire        aud_bclk,
      output logic       aud_dacdat,
      output wire        aud_daclrck,
      output logic       aud_mclk,

      ///////// clock /////////
      input  wire        clock_50,

      ///////// fpga /////////
      output logic       fpga_i2c_sclk,
      inout  wire        fpga_i2c_sdat,

      ///////// gpio /////////
      inout  wire [35:0] gpio_0,
      inout  wire [35:0] gpio_1,


      ///////// hex  /////////
      output logic[6:0]  hex0,
      output logic[6:0]  hex1,
      output logic[6:0]  hex2,
      output logic[6:0]  hex3,
      output logic[6:0]  hex4,
      output logic[6:0]  hex5,

      ///////// key /////////
      input  wire [3:0]  key,

      ///////// ledr /////////
      output logic[9:0]  ledr,
      ///////// sw /////////
      input  wire [9:0]  sw
);


   // Génération d'un reset à partir d'un boutton poussoir
   logic             auto_reset_n;
   wire reset_n = key[0];

   // Génération d'une horloge lente (1s de période)
   // et d'une horloge pour le processeur
   logic             clk_1s;
   logic             clk_1M;
   
   gene_clk gene_clkl(.clk_50(clock_50), .clk_1s(clk_1s), .clk_1M(clk_1M));

   // L'horloge du processeur est soit une horloge interne à 1MHz soit elle
   // vient du bouton key3. Le choix se fait avec SW0
   logic             sclk;
   assign       sclk = sw[0] ? key[3] : clk_1M;
  

   // Instanciation du codec son :
   logic [15:0]      dac_data_r, dac_data_l;
   logic                    audio_data_ena;
   codec codec(.clk_50(clock_50),
               .reset_n(reset_n),
               
               // I2C for configuration
               .i2c_sclk(fpga_i2c_sclk),
               .i2c_sdat(fpga_i2c_sdat),
               
               // CODEC ports
               .aud_adclrck ( aud_adclrck ) ,
               .aud_adcdat  ( aud_adcdat  ) ,
               .aud_daclrck ( aud_daclrck ) ,
               .aud_dacdat  ( aud_dacdat  ) ,
               .aud_bclk    ( aud_bclk    ) ,
               .aud_mclk    ( aud_mclk    ) ,

               // Audio output data
               .dac_data_l  ( dac_data_l ) ,
               .dac_data_r  ( dac_data_r )
               );

   // Instanciation du registre d'entrée-sortie (buzzer + LEDs)
   //   [0]   : buzzer (dupliqué sur codec audio)
   //   [7:1] : LEDS
   logic [7:0]              out;

   assign dac_data_l = {out[0], 15'h7fff};
   assign dac_data_r = {out[0], 15'h7fff};

   assign ledr       = {clk_1s, 2'b00, out[7:1]};

   assign gpio_0[9]  = out[0];
   //assign  gpio_0          =       36'hzzzzzzzzz;
   assign  gpio_1          =       36'hzzzzzzzzz;


   // Instantication de la RAM
   logic                     ram_write;
   logic [7:0]               ram_addr;
   logic [7:0]               ram_data_read;
   logic [7:0]               ram_data_write;

   ram ram(
           .clk      ( clock_50       ) ,
           .addr     ( ram_addr       ) ,
           .write    ( ram_write      ) ,
           .data_out ( ram_data_read  ) ,
           .data_in  ( ram_data_write )
           );
   
   
   // Instanciation du processeur
   logic [7:0]               I; // pour le débug
   nanoprocesseur proc(
                       .clk            ( sclk           ) ,
                       .reset_n        ( reset_n        ) ,
                       .ram_data_read  ( ram_data_read  ) ,
                       .ram_data_write ( ram_data_write ) ,
                       .ram_write      ( ram_write      ) ,
                       .ram_addr       ( ram_addr       ) ,
                       .out            ( out            ) ,
                       .I              ( I              )
                       );

   // Debug :
   //  - Adresses RAM sur aficheurs 1:0
   //  - Instruction sur afficheurs 3:2
   //  - Accumulateur sur afficheurs 5:4
   seven_seg s0(ram_addr[3:0], hex0);
   seven_seg s1(ram_addr[7:4], hex1);

   seven_seg s4(I[3:0], hex2);
   seven_seg s5(I[7:4], hex3);

   seven_seg s6(ram_data_write[3:0], hex4);
   seven_seg s7(ram_data_write[7:4], hex5);
   
endmodule
