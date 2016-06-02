`default_nettype none

module fpga (
        ////////////////////////    Push Button        ///////////////////////
        input logic   [3:0]    key,             //    Pushbutton[3:0]
        ////////////////////////    DPDT Switch        ///////////////////////
        input logic   [9:0]    sw,              //    Toggle Switch[9:0]
        ////////////////////////    7-SEG Dispaly    /////////////////////////
        output logic  [6:0]    hex0,            //    Seven Segment Digit 0
        output logic  [6:0]    hex1,            //    Seven Segment Digit 1
        output logic  [6:0]    hex2,            //    Seven Segment Digit 2
        output logic  [6:0]    hex3,            //    Seven Segment Digit 3
        output logic  [6:0]    hex4,            //    Seven Segment Digit 4
        output logic  [6:0]    hex5,            //    Seven Segment Digit 5
        ////////////////////////////    LED        ///////////////////////////
        output logic  [9:0]    ledr             //    LED Red[9:0]
        );

   // ajouter votre code à partir d'ici

endmodule
