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
    input [6:0]player_1x,
    input [6:0]player_1y,
    input [6:0]player_2x,
    input [6:0]player_2y,
    input reset,
    output reg player_1_collision =0,
    output reg player_1_hitrange =0,
    output reg player_2_collision =0
);

reg [15:0] distance_X;
reg [15:0] distance_Y;
reg [15:0] distance_squared;

always @(posedge clk)begin
    distance_X <= player_1x - player_2x;
    distance_Y <= player_1y - player_2y;
    distance_squared <= (distance_X * distance_X) + (distance_Y * distance_Y);
    
    if  (~reset &&distance_squared < (20 * 20)) begin
        player_1_collision <= 1;
        player_2_collision <= 1;
    end
    else begin
        player_1_collision <= 0;
        player_2_collision <= 0;
    end

   if  (~reset &&distance_squared < (24 * 24)) begin
        player_1_hitrange <= 1;
    end
    else begin
        player_1_hitrange <= 0;        
    end      
end


endmodule

