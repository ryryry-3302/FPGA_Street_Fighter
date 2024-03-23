`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2024 20:05:19
// Design Name: 
// Module Name: CollisionDetection
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


module CollisionDetection (
    input clk,
    input player_1x,
    input player_1y,
    input player_2x,
    input player_2y,
    output reg player_1_collision =0,
    output reg player_2_collision =0
);

always @(posedge clk)begin


    if ((player_1x - player_2x > -7 && player_1x - player_2x < 7) && (player_1y - player_2y > -13 && player_1y - player_2y < 13)) begin
        player_1_collision <= 1;
        player_2_collision <= 1;
    end
    else begin
        player_1_collision <= 0;
        player_2_collision <= 0;
    end     
end


endmodule

