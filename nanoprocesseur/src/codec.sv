`default_nettype none

/* Audio CODEC : USB mode, DSP slave IF, 48kHz */
  
module codec(input  logic clk_50,       // Horloge système 50Mhz
             input  logic reset_n,      // Reset (actif bas)
             
             // I2C configuration port
             output logic i2c_sclk,
             inout        i2c_sdat,
              
             // Codec chip ports (codec in slave mode)
             output logic  aud_adclrck,  // ADC l/r clock
             input  logic  aud_adcdat,   // ADC input data serial bitstream
             output logic  aud_daclrck,  // DAC l/r clock
             output logic  aud_dacdat,   // DAC output data serial bitstream
             output logic  aud_bclk,     // Bitstream clock (BCLK)
             output logic  aud_mclk,     // Chip clock (MCLK)

             // Audio data IN and OUT
             output logic[15:0] adc_data_l, 
             output logic[15:0] adc_data_r,
             input  logic[15:0] dac_data_l, 
             input  logic[15:0] dac_data_r,
             output logic data_ena
             );


   logic clk_12;
   logic [9:0] cpt_clk;

   always_ff @(posedge clk_50 or negedge reset_n) begin
      if (!reset_n)
      begin
         cpt_clk   <= 10'd0;
      end
      else
      begin
         cpt_clk <= cpt_clk + 1'b1;
      end
   end

   assign clk_12       = cpt_clk[1];
   assign aud_mclk     = clk_12    ; // clk/4 ie 12.5 for 50MHz (au lieu de 12)
                                     // Si plus de précision est necessaire,
                                     // utiliser une pll


   // Codec configuration block
   codec_ctrl codec_ctrl(.clk(clk_50),
                         .reset_n (reset_n),
                         .i2c_sdat(i2c_sdat),
                         .i2c_sclk(i2c_sclk)
                         );

   
   // The codec is in DSP slave mode : BCLK = 12MHz too
   assign aud_bclk = clk_12;

   // BCLK = 250*Fs
   logic [7:0] cpt;
   always_ff @(posedge clk_12 or negedge reset_n)
     if(~reset_n)
       cpt <= 0;
     else
       if (cpt >= 249)
         cpt <= 0;
       else
         cpt <= cpt+1;

   // LRC generation
   always @(negedge clk_12)
     if(cpt==0)
       begin
          aud_adclrck <= 1;
          aud_daclrck <= 1;
       end
     else 
       begin
          aud_adclrck <= 0;
          aud_daclrck <= 0;
     end

   // Input data buffer
   logic [31:0] data_in;
   always_ff @(posedge clk_12)
     if(cpt < 32)
       begin
          data_in[31:1] <= data_in[30:0];
          data_in[0] <= aud_adcdat;
       end

   always_ff @(posedge clk_12)
     if(cpt == 32)
       begin
          adc_data_r <= data_in[15:0];
          adc_data_l <= data_in[31:16];
       end

   // Output shift register
   logic [31:0] data_out;
   always_ff @(negedge clk_12)
     if(cpt < 32)
       begin
          data_out[31:1] <= data_out[30:0];
          aud_dacdat <= data_out[31];
       end
     else if (cpt == 32)
       data_out <= {dac_data_l, dac_data_r};

   always_ff @(posedge clk_12)
     data_ena <= cpt == 0;
   

endmodule
