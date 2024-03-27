`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:02:47
// Design Name: 
// Module Name: comboWindow
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


module comboWindow(
    input clk,
    
    input playerInput,
    input cancel, // it is a OR of all the inputs. 
    
    output windowOpenWire
    );
    
    reg windowOpen = 0;
    assign windowOpenWire = windowOpen;
    
    reg [31:0]count = 0;
    
    
    
    //if press button, window remains open for 0.5 seconds before closing
    always @ (posedge clk) begin
        if (playerInput) begin
            count = 1;
            windowOpen = 1;
        end
        if (cancel && !playerInput) begin 
            count = 24888888; //instead of ending the counter immedietly, we set the count to very high to avoid race condition with the next combo detection
        end
        //window remains open for 0.5 seconds
        count = ((count > 24999999) || !windowOpen)? 0: count + 1;
        if (count == 0) begin
            windowOpen = 0;
        end  
    end
//    always @ (posedge playerInput or  posedge timerExpired) begin
//     windowOpen = playerInput? 1:0;
//    end
    
//    always @ (posedge gameTicks) begin
//     counter = (counter < upperLimit) && windowOpen ? counter+1:0;
//     timerExpired = counter == 0 && windowOpen? 1:0;
//    end
    
   
endmodule
