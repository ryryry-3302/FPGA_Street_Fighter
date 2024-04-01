`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 20:42:29
// Design Name: 
// Module Name: in_game_music_mod
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


module punchSoundMod(input clk, output speaker);

//// <Creation of Frequencies> ////
wire F3, G3, A3, B3, C4, D4, E4, G4;
reg music_reg;

CustomClock F3_gen (clk, 286351, F3);
CustomClock G3_gen (clk, 255101, G3);
CustomClock A3_gen (clk, 227272, A3);
CustomClock B3_gen (clk, 202477, B3);
CustomClock C4_gen (clk, 191109, C4);
CustomClock D4_gen (clk, 170258, D4);
CustomClock E4_gen (clk, 151684, E4);
CustomClock G4_gen (clk, 127550, G4);
//// </ Creation of Frequencies> ////

//// <Duration Counters> ////
wire quaver_dur, stacc_quaver_dur, stacc_break_dur;
wire stacc_signal;
reg [4:0] music_state = 0; //32 states
//CustomClock quaver_timer (clk, 5357140, quaver_dur);
CustomClock quaver_timer (clk, 5357141, quaver_dur);
//CustomClock stacc_quaver_timer (clk, 3571428, stacc_quaver_dur);
//CustomClock stacc_break_timer (clk, 1785713, stacc_break_dur);
stacc_quav_clock stacc_clock(clk, stacc_signal);
//// </Duration Counters> ////

always @ (posedge quaver_dur) begin
        music_state <= music_state + 1;
end 
    
always @ (posedge clk) begin
    //Music State Counter 31 states)
    
    if (stacc_signal == 0) begin
        music_reg = 0;
    end
    
    else begin
        if (music_state == 0 || music_state == 1 || music_state == 3 || music_state == 5 || (music_state == 26)) begin
            music_reg <= A3;
        end
        
        else if (music_state == 2 || music_state == 8 || music_state == 9 || music_state == 11 ||
            music_state == 13 || music_state == 15 || music_state == 20 || music_state == 23 ||
            music_state == 28 || music_state == 30) begin
            music_reg <= C4;
        end
        
        else if (music_state == 4 || music_state == 7 || music_state == 22) begin
            music_reg <= D4;
        end
        
        else if (music_state == 6 || music_state == 10 || music_state == 14) begin
            music_reg <= E4;
        end   
                    
        else if (music_state == 12) begin
            music_reg <= G4;
        end   
        
        else if (music_state == 16 || music_state == 17 || music_state == 19 || music_state == 21) begin
            music_reg <= G3;
        end   
        
        else if (music_state == 24 || music_state == 25 || music_state == 27 || music_state == 29) begin
            music_reg <= F3;
        end         
        
        else if (music_state == 18 || music_state == 31) begin
            music_reg <= B3;
        end  
                        
    end
end

    assign speaker = G4;
endmodule