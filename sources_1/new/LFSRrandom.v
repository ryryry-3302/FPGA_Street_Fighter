`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 17:01:00
// Design Name: 
// Module Name: LFSRrandom
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


module LFSRrandom(
    input clk,
    output [4:0]random5bit
    );
    reg [15:0]seed = 35281; //random seed selected
    
    always @ (posedge clk) begin
        seed[15:1] <= seed[14:0];
        seed[0] = seed[4]^seed[12]^seed[15];
    end
    
    assign random5bit = seed[15:11];
endmodule
