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


module comboLeftDownRight(
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
    comboWindow leftWindow(clk, left, allInputs, move[0]);
    comboWindow downWindow(clk, down, allInputs, move[1]);
    comboWindow rightWindow(clk, right, allInputs, move[2]);
    comboWindow attackWindow(clk, attack, allInputs, move[3]);
    //testing currently. up down right
    
    always @ (posedge clk) begin
        if (bypass) begin success <= 1; end
        if (move[0]) begin
            if (move[1]) begin
                if (move[2]) begin
                    if (move[3]) begin
                        success = 1;
                    end
                end
            end
        end
        if (!move[3]) begin success = 0; end
    end
    
    
endmodule
