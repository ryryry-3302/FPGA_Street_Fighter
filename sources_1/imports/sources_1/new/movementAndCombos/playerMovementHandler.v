`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 17:40:44
// Design Name: 
// Module Name: playerMovementHandler
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


module playerMovementHandler(

    //raw inputs
    input clk,
    input gameTicks,
    
    input playerNumber,
    
    input upButtonRaw,
    input downButtonRaw,
    input leftButtonRaw,
    input rightButtonRaw,
    
    input attackButtonRaw,
    input blockButtonRaw,
    
    //outputs to pass to game state
    output isCrouching,
    output movingLeft,
    output movingRight,
    output isJumping,
    output isBlocking,
    output [1:0]comboMove,
    
    //inputs to get from games state
    input [2:0]playerChar,
    input isCrouched,
    input isInAir,
    input isStunned,
    input isPerformingAttackAnimation
    );
    

    
    //debouncers for the inputs
    wire up; wire down; wire left; wire right; wire attack; wire block;
    debouncer upDebouncer(clk,upButtonRaw,up); 
    debouncer downDebouncer(clk,downButtonRaw,down); 
    debouncer leftDebouncer(clk,leftButtonRaw,left); 
    debouncer rightDebouncer(clk,rightButtonRaw,right); 
    debouncer attackDebouncer(clk,attackButtonRaw,attack); 
    debouncer blockDebouncer(clk,blockButtonRaw,block); 
    
    //movement
    wire canMoveHori;
    wire canMoveVerti;
    assign canMoveHori= !(isStunned || isPerformingAttackAnimation);
    assign canMoveVerti = !(isStunned || isPerformingAttackAnimation || isInAir || isCrouched) ;
    
    assign movingLeft = canMoveHori? left:0;
    assign movingRight = canMoveHori? right:0;
    assign isCrouching = canMoveVerti? down:0;
    assign isJumping = canMoveVerti? up: 0;
    
    
    //attacks
    wire canPerformAttack = !(isStunned || isPerformingAttackAnimation);
    
    wire normalAttack;
    assign normalAttack = attack;
    
    wire specialAttack;
    comboLeftDownRight specialAttackCombo(.clk(clk),.right(right),.up(up),.down(down),.left(left),.attack(attack), .successWire(specialAttack));
    
    wire superSpecialAttack;
    konamiCombo superSpecialAttackCombo(.clk(clk),.right(right),.up(up),.down(down),.left(left),.attack(attack), .successWire(superSpecialAttack));
    
    assign comboMove[1:0] = canPerformAttack?(superSpecialAttack ? 3 : (specialAttack ? 2: (normalAttack ?1:0))):0;
    //more powerful attacks always have priority
    
    always @ (posedge gameTicks) begin
        
    end
endmodule
