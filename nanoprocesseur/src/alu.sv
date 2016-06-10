
/* Ce module (bloc) est l'Unite Arithmétique et Logique du processeur (ALU en anglais).
 Son rôle, est d'effectuer un calcul sur deux opérandes (avec éventuellement une retenue entrante).
 L'opération a effectuer est donnée par le bus I (instruction).
 
 Pour connaitre le code de chaque operation, on se reportera au texte du TP.
 
 Ce bloc est purement combinatoire. Il a 3 signaux à générer :
    - S
    - Z (1 si S est nul, 0 sinon)
    - Cout (une éventuelle retenue sortante)
 */


module ALU (
   input logic [3:0]  I,           // Instruction, donnant le type d'operation a effectuer
   input logic [7:0]  A,        // Premiere operande : le contenu de l'Amulateur
   input logic [7:0]  B,    // Deuxieme operande : la donnee lue dans la RAM a l'adresse en cours
   input logic        Cin,        // Troisieme operande : une eventuelle retenue entrante
   
   output logic [7:0] S,     // Sortie de l'ALU = operation(operande1, operande2)
   output logic       Cout,       // Sortie de l'ALU : retenue sortante eventuelle
   output logic       Z) ;      // Sortie de l'ALU : bit Z, 1 si S est nul, 0 sinon


   // Insérez votre code entre ici


   // Et là

endmodule // ALU

   
