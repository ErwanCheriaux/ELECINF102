module simu_pc;

   /* Fichier de generation de stimuli pour tester le module PC
    
    Il alimente le PC avec les bonnes entrées, et verifie que la sortie est correcte
    */


   reg        clk;
   reg        reset_n;
   reg [7:0]  data_in;
   reg        inc_PC, load_PC;
   wire [7:0] PC;
   reg        erreur;
       
   // Instanciation du module PC a tester
   REG_PC PC1(clk, reset_n, inc_PC, load_PC, data_in, PC);
   
   
   // On en fait pas de test rusé, on présente juste les entrées cycle à cycle,
   // et on vérifie à chaque fois que la sortie est correcte
   initial
     begin
        erreur = 0;
        data_in = 8'hAA;
        inc_PC = 0;
        load_PC = 0;
        clk = 0;
        reset_n = 0;
        #1;
        clk = 1;
        #1;
        clk = 0;
        reset_n = 1;
        # 1;
        clk = 1;
        #1;
        // on vérifie que la sortie de PC est bien à 0
        if(PC !== 0)
          begin
             $display("Erreur au temp %d : a la sortie du reset, PC n'est pas nul !", $time);
             erreur = 1;
          end
        #1;
        
        clk = 0;
        data_in = 0;
        #1;
        clk = 1;
        #1;
        // la sortie de PC n'a pas du bouger
        if(PC !== 0)
          begin
             $display("Erreur au temps %d, PC ne doit pas etre modifie quand inc_PC et load_PC sont a 0 !", $time);
             erreur = 1;
          end
        #1;
        
        clk = 0;
        data_in = 8'hA5;
        load_PC = 1;
        #1;
        clk = 1;
        #1;
        // on verifie que la sortie de PC est bien A5
        if(PC !== 8'hA5)
          begin
             $display("Erreur au temps %d, PC aurait du etre charge avec A5!", $time);
             erreur = 1;
          end
        #1;

        clk = 0;
        data_in = 8'h33;
        load_PC = 1;
        inc_PC = 1;
        #1;
        clk = 1;
        #1;
        // on verifie que la sortie de PC est bien 33
        if(PC !== 8'h33)
          begin
             $display("Erreur au temps %d, PC aurait du etre charge avec 33 (load_PC est prioritaire sur inc_PC) !", $time);
             erreur = 1;
          end
        #1;

        clk = 0;
        data_in = 8'h33;
        load_PC = 0;
        inc_PC = 1;
        #1;
        clk = 1;
        #1;
        // on verifie que la sortie de PC est bien 34
        if(PC !== 8'h34)
          begin
             $display("Erreur au temps %d, PC aurait du etre incremente a 34 !", $time);
             erreur = 1;
          end
        #1;

        clk = 0;
        data_in = 8'h00;
        load_PC = 0;
        inc_PC = 1;
        #1;
        clk = 1;
        #1;
        // on verifie que la sortie de PC est bien 35
        if(PC !== 8'h35)
          begin
             $display("Erreur au temps %d, PC aurait du etre incremente a 35 !", $time);
             erreur = 1;
          end
        #1;

        
        clk = 0;
        data_in = 8'h33;
        load_PC = 0;
        inc_PC = 0;
        #1;
        clk = 1;
        #1;
        // on verifie que la sortie de PC est bien encore 35
        if(PC !== 8'h35)
          begin
             $display("Erreur au temps %d, PC aurait du garder sa valeur (35), car load_PC et inc_PC sont nuls !", $time);
             erreur = 1;
          end
        #1;

        if(erreur == 0) 
        begin
          $display("Bravo, votre bloc PC semble fonctionner correctement");
          $display("Que cela nous vous dispense pas de jeter un oeil au chronogramme");
          $display("pour comprendre les tests effectues");
          $display("N'OUBLIEZ PAS DE QUITTER LE SIMULATEUR AVANT DE PASSER A LA SUITE") ;
        end
        else
        begin
          $display("Le bloc PC ne fonctionne pas correctement !");
          $display("Examinez le chronogramme, et faites les corrections necessaires");
          $display("N'OUBLIEZ PAS DE QUITTER LE SIMULATEUR AVANT TESTER VOTRE NOUVEAU CODE") ;
        end
     end
endmodule // simu_pc


