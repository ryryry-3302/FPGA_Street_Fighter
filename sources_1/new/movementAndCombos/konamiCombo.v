`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 21:39:32
// Design Name: 
// Module Name: konamiCombo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module konamiCombo(
     input clk,
     
     input bypass,
     input up,
     input down,
     input left,
     input right,
     input attack,
     input block,
     
     output successWire
    );
    
    wire allInputs; //OR of all the inputs to see if the combo has been broken
    assign allInputs = up || down || left || right || attack; //BLOCK has not been added yet
    
    reg success;
    assign successWire = success;
    
    wire [8:0]move;
    comboWindow upMove1(clk, up, allInputs, move[0]);
    comboWindow upMove2(clk, move[0]?up:0, allInputs, move[1]);
    comboWindow downMove1(clk, move[1]?down:0, allInputs, move[2]);
    comboWindow downMove2(clk, move[2]?down:0, allInputs, move[3]);
    comboWindow leftMove1(clk, move[3]?left:0, allInputs, move[4]);
    comboWindow rightMove1(clk, move[4]?right:0, allInputs, move[5]);
    comboWindow leftMove2(clk, move[5]?left:0, allInputs, move[6]);
    comboWindow rightMove2(clk, move[6]?right:0, allInputs, move[7]); 
    comboWindow attackMove(clk, move[7]?attack:0, allInputs, move[8]);
    //testing currently. up down right
    
    always @ (posedge clk) begin
        if (bypass) begin success <= 1; end
//        if (move[0]) begin
//            if (move[1]) begin
//                if (move[2]) begin
//                    if (move[3]) begin
//                        if (move[4]) begin
//                            if (move[5]) begin
//                                if (move[6]) begin
//                                    if (move[7]) begin
//                                        if (move[8]) begin
//                                            success = 1;
//                                        end
//                                    end
//                                end
//                            end
//                        end
//                    end
//                end
//            end
//        end
            if (move[8]) begin
                success = 1;
            end
        if (!move[8]) begin success = 0; end
    end
    
    
endmodule
