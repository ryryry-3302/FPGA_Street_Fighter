`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 17:45:03
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input button,
    
    output buttonSignal
    );
    
    wire debounce2000HzSig; 
    CustomClock debouncer(clk, 249,debounce2000HzSig);
    
    reg buttonSignalReg;
    assign buttonSignal = buttonSignalReg;
    
    always @ (posedge debounce2000HzSig)begin 
        buttonSignalReg = button;
    end
endmodule
