module disass(input [3:0] I);

   logic[4*8:0] chaine;

   always@(I)
     begin
        chaine = "    ";
        case (I)
          0 : chaine = "NOP";
          1 : chaine = "XOR";
          2 : chaine = "AND";
          3 : chaine = "OR";
          4 : chaine = "ADD";
          5 : chaine = "ADC";
          6 : chaine = "SUB";
          7 : chaine = "SBC";
          8 : chaine = "ROL";
          9 : chaine = "ROR";
          10: chaine = "LDA";
          11: chaine = "STA";
          12: chaine = "OUT";
          13: chaine = "JMP";
          14: chaine = "JNC";
          15: chaine = "JNZ";
        endcase // case(I)
        $display($time, chaine);
     end
endmodule // disass
