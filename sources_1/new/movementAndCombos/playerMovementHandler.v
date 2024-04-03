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
    
    input health,
    input BYPASS, //bot will have BYPASS to 1 to indicate it can access combos easily
    input [4:0]random5bit,
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
    
    //AI stuff
    reg leftAI = 0;
    reg rightAI = 0;
    reg upAI = 0;
    reg downAI = 0;
    reg [1:0]attackAI = 0;

 //debouncers for the inputs
    wire attackHOLDABLE; reg attackREG;
    
    reg [31:0]attackCount = 1;

    wire up; wire down; wire left; wire right; wire attack; wire block;
    debouncer upDebouncer(clk,upButtonRaw,up); 
    debouncer downDebouncer(clk,downButtonRaw,down); 
    debouncer leftDebouncer(clk,leftButtonRaw,left); 
    debouncer rightDebouncer(clk,rightButtonRaw,right); 
    debouncer attackDebouncer(clk,attackButtonRaw,attackHOLDABLE); 
    debouncer blockDebouncer(clk,blockButtonRaw,block); 

    always @ (posedge (clk)) begin
        if(attackHOLDABLE) begin
            attackCount = ((attackCount<20000000) && (attackCount!=0))? attackCount+1:0;
     end
    else begin
            attackCount = 1;
            end
     end

    assign attack = ((attackCount != 0)&& attackHOLDABLE);  
    //movement
    wire canMoveHori;
    wire canMoveVerti;
    assign canMoveHori= !(isStunned || isPerformingAttackAnimation);
    assign canMoveVerti = !(isStunned || isPerformingAttackAnimation || isInAir || isCrouched) ;
    
    assign movingLeft = canMoveHori? (BYPASS? leftAI:left):0;
    assign movingRight = canMoveHori? (BYPASS? rightAI:right):0;
    assign isCrouching = canMoveVerti? (BYPASS? downAI:down):0;
    assign isJumping = canMoveVerti? (BYPASS? upAI:up): 0;
    
    
    //attacks
    wire canPerformAttack = !(isStunned || isPerformingAttackAnimation);
    
    wire normalAttack;
    assign normalAttack = attack;
    
    wire specialAttack;
    comboLeftDownRight specialAttackCombo(.clk(clk),.right(right),.up(up),.down(down),.left(left),.attack(attack), .successWire(specialAttack));
    
    wire superSpecialAttack;
    konamiCombo superSpecialAttackCombo(.clk(clk),.right(right),.up(up),.down(down),.left(left),.attack(attack), .successWire(superSpecialAttack));
    
    assign comboMove[1:0] = (BYPASS)? attackAI:
    canPerformAttack?(superSpecialAttack ? 3 : (specialAttack ? 2: (normalAttack ?1:0))):0;
    //more powerful attacks always have priority
    
    //BELOW IS FOR THE AI TO CONTROL
    
    reg [5:0]countAImove = 0;
    reg [5:0]countAIattack = 0;
    always @ (posedge (BYPASS? gameTicks: 0)) begin
        countAImove = (countAImove > 20)? 0:countAImove+1;
        if (countAImove == 0) begin
            leftAI = (random5bit > 15);
            rightAI = !leftAI;
        end
        countAIattack = (countAIattack > (health > 154? 5: 3))? 0:countAIattack+1;
        if (countAIattack == 0) begin
            attackAI = (random5bit >= 29)? 3: 
            (random5bit > 27)?  2:
            (random5bit >18)? 1:
            0;
            //i Chucked jumping in here instead of movement so he doesnt keep jumping for periods
            upAI = (random5bit >28)? 1: 0;
            downAI = (random5bit >29)? 1: 0;
        end
        
    end
endmodule
