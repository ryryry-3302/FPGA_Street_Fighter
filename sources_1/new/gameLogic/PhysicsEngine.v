`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2024 20:05:19
// Design Name: 
// Module Name: PhysicsEngine
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


module PhysicsEngine (
    input player_no, // identity of the player
    input clk,
    input reset,
    input isColliding,
    input movingLeft,
    input movingRight,
    input isJumpin,
    output reg [7:0] sprite_x_out,
    output reg [7:0] sprite_y_out
);


    reg[3:0] velocity_y = 0; // velocity in y direction
    // Define game state parameters
    always @(posedge clk or reset) //clock at 20 ticks per second
begin
    if (reset) begin
        case (player_no)
            0: begin
                sprite_x_out <= 15; // left end
                sprite_y_out <= 48; // 48 is the floor
            end
            1: begin
                sprite_x_out <= 75; // right end
                sprite_y_out <= 48; // 48 is the floor
            end             
            default: 
            begin
                sprite_x_out <= 0;
                sprite_y_out <= 0;
            end
        endcase
    end
    
    else begin
        if (movingLeft && sprite_x_out > 15 && ~isColliding) begin
            sprite_x_out <= sprite_x_out - 1;
        end
        if (movingRight && sprite_x_out < 75 && ~isColliding) begin
            sprite_x_out <= sprite_x_out + 1;
        end
        if (isJumpin && ~isColliding) begin
            velocity_y <= 20;
        end
        if (sprite_y_out > 48) begin
            sprite_y_out <= (sprite_y_out - velocity_y) >= 48? sprite_y_out - velocity_y : 48; 
            velocity_y <= ~isColliding? velocity_y -1: 0; //gravity
        end

    end
end




endmodule
