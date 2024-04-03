`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 07:35:11
// Design Name: 
// Module Name: musicController
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: .
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module musicController(input enableAudio, input clk, input jumpButtonRaw_1, input jumpButtonRaw_2, input [1:0] attackButtonRaw_1, input [1:0] attackButtonRaw_2, input [8:0] player1Health, input [8:0] player2Health, input [1:0] state, output reg audioOut);
    //Module currently restricted to just player 1 Info
    parameter healthThreshold = 154; //Between 9 bits
    wire bgm_output, critical_music_output, punch_sound_output, jump_sound_output;
    bgm_mod bgm_gen (clk, bgm_output);
    criticalmusic_gen critical_music (clk, critical_music_output);
    punchSoundMod punch_sound_gen(clk, punch_sound_output);
    jumpSoundMod jump_sound_gen(clk, jump_sound_output);



    always @ (posedge clk) begin 
        if (enableAudio == 1) begin
            //if win, music stops.
            if (state == 2'b10 || state == 2'b01) begin
                audioOut <= 0;
            end             
            
            else if (attackButtonRaw_1 != 2'b00 || attackButtonRaw_2 != 2'b00) begin //As long as it is doing any attack
                //Play crouching sound effect
                audioOut <= punch_sound_output;
            end
            
            else if (jumpButtonRaw_1 == 1 || jumpButtonRaw_2 == 1) begin
                //Play jumping sound effect
                audioOut <= jump_sound_output;
                
            end
            
            else if (player1Health <= healthThreshold || player2Health <= healthThreshold) begin
                //Play critical health threshold music
                audioOut <= critical_music_output;

            end     
              
            else begin
                //Play bgm
                audioOut <= bgm_output;
            end
        end
        
        else begin
            audioOut <= 0;
        end
    end

endmodule
