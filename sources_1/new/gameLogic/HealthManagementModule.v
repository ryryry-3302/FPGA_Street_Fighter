//, input damageTo1, input damageTo2, 

module HealthManagement (
    input clk,
    input reset,
    input player_1_hitrangewire,
    input [2:0] attack_statex,
    input [2:0] attack_statey,
    output reg [8:0] health_1 = 200,
    output reg [8:0] health_2 = 200,
    output reg [2:0] state
);
    
    //state 00 fight
    //state 01 player 1 wins
    //state 02 player 2 wins
      
    always @(posedge clk) begin
        if (reset) begin
            health_2 <= 200;
            health_1 <= 200;
        end
       
        if (player_1_hitrangewire && attack_statex == 2'b11 && health_2 > 0) begin
            health_2 <= (health_2 > 40) ? health_2 - 40 : 0;
        end else if (player_1_hitrangewire && attack_statex == 2'b10 && health_2 > 0) begin
            health_2 <= health_2 > 10 ? health_2 - 10 : 0;
        end else if (player_1_hitrangewire && attack_statex == 2'b01 && health_2 > 0) begin
            health_2 <= health_2 > 4 ? health_2 - 4 : 0;
        end
       
        if (player_1_hitrangewire && attack_statey == 2'b11 && health_2 > 0) begin
            health_1 <= (health_1 > 40) ? health_1 - 40 : 0;
        end else if (player_1_hitrangewire && attack_statey == 2'b10 && health_2 > 0) begin
            health_1 <= health_1 > 10 ? health_1 - 10 : 0;
        end else if (player_1_hitrangewire && attack_statey == 2'b01 && health_2 > 0) begin
            health_1 <= health_1 > 4 ? health_1 - 4 : 0;
        end
       
        if (health_2 == 0) begin
            state <= 2'b01;
        end else if (health_1 == 0) begin
            state <= 2'b10;
        end else begin
            state <= 2'b00;
        end
    end
endmodule

