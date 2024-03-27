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
    output reg player_1_collision =0,
    output reg player_2_collision =0
);

reg [15:0] distance_X;
reg [15:0] distance_Y;
reg [15:0] distance_squared;

wire CLK_20Hz;

CustomClock clk20hz(.CLOCK_IN(clk),.COUNT_STOP(2500000),.CLOCK_OUT(CLK_20Hz));
always @(posedge CLK_20Hz)begin
    distance_X <= player_1x - player_2x;
    distance_Y <= player_1y - player_2y;
    distance_squared <= (distance_X * distance_X) + (distance_Y * distance_Y);
    
    if  (distance_squared < (15 * 15)) begin
        player_1_collision <= 1;
        player_2_collision <= 1;
    end
    else begin
        player_1_collision <= 0;
        player_2_collision <= 0;
    end     
end


endmodule

