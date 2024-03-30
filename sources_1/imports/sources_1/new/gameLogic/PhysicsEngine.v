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
    output reg [7:0]velocityUp,
    input player_no, // identity of the player
    input clk,
    input reset,
    input isColliding,
    input movingLeft,
    input movingRight,
    input isJumping,
    input [6:0] sprite2_x,
    input [6:0] sprite2_y,
    output reg [6:0] sprite_x_out = 30,
    output reg [6:0] sprite_y_out = 48
);


    reg [6:0] velocity_y_up = 0; // velocity in y direction in 2's
    reg [6:0] velocity_y_down =0;

    // Define game state parameters
    
    
    always @(posedge clk) //clock at 20 ticks per second
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
            if (movingLeft && sprite_x_out > 15 && ~(isColliding && sprite_x_out> sprite2_x )) begin // && ~isColliding
                sprite_x_out <= sprite_x_out - 2;
            end
            if (movingRight && sprite_x_out < 75 &&  ~(isColliding && sprite_x_out < sprite2_x)) begin // && ~isColliding
                sprite_x_out <= sprite_x_out + 2;
            end
            
            if (isColliding && sprite_y_out < sprite2_y) begin
                            sprite_y_out <= sprite_y_out-3;
                            velocity_y_up <= 0;
                            velocity_y_down <= 1;
            end
            else if (isJumping &&( (sprite_y_out == 48))) begin
                velocity_y_up <= 14;
                velocity_y_down <= 2;
                sprite_y_out <= sprite_y_out - velocity_y_up + velocity_y_down;
            end
           
            
            else if (sprite_y_out >= 49) begin
            sprite_y_out <= 48;
            velocity_y_up <= 0;
            velocity_y_down <= 0;
            end
             
            else if (sprite_y_out <= 14) begin
                sprite_y_out <= 15;
                velocity_y_up <= 0;
                velocity_y_down <= 1;
            end
            
            else  begin
                velocity_y_up <= velocity_y_up >0? velocity_y_up -1 : 0;
                velocity_y_down <= velocity_y_down <15 && velocity_y_down >0 || sprite_y_out <48? velocity_y_down +1 : 0;
                sprite_y_out <= (sprite_y_out - velocity_y_up + velocity_y_down)<=48?(sprite_y_out - velocity_y_up + velocity_y_down): 48; 
            end
      
        end
    end




endmodule
