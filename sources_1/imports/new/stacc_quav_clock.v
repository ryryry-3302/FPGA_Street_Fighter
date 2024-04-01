`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2024 09:09:07
// Design Name: 
// Module Name: stacc_quav_clock
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


module stacc_quav_clock(input clk, input m_val, output reg signal);
    wire clk_28Hz;
    reg [2:0] count;
    
    //CustomClock(clk ,1339285, clk_28Hz);
    //CustomClock(clk ,21428570, clk_2p3Hz);
    CustomClock(clk ,m_val, stacc_clk);

                     

    always @ (posedge stacc_clk) begin 
        count <= count + 1;
        
        //if (count == 0 || count == 1 || count == 2) begin
        if (count == 0 || count == 1 || count == 2 || count == 3 || count == 4) begin
            signal <= 0;
        end
        
        else if (count == 5) begin
            signal <= 1;
        end
        
        else begin
            count <= 0;
        end
    end

endmodule