`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 09:06:31
// Design Name: 
// Module Name: criticalmusic_gen
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


module criticalmusic_gen(input clk, output speaker);
//Mortal Combat Theme

//// <Creation of Frequencies> ////
//wire E2, G2, A2, C3, E3;
wire E3, G3, A3, C4, E4;

reg music_reg;

//CustomClock E2_gen (clk, 606744, E2);
//CustomClock G2_gen (clk, 510208, G2);
//CustomClock A2_gen (clk, 454544, A2);
//CustomClock C3_gen (clk, 382233, C3);
//CustomClock E3_gen (clk, 303379, E3);

CustomClock E3_gen (clk, 303379, E3);
CustomClock G3_gen (clk, 255101, G3);
CustomClock A3_gen (clk, 227272, A3);
CustomClock C4_gen (clk, 191109, C4);
CustomClock E4_gen (clk, 151684, E4);
//// </ Creation of Frequencies> ////

//// <Duration Counters> ////
wire quaver_dur, stacc_quaver_dur, stacc_break_dur;
wire stacc_signal;
reg [4:0] music_state = 0; //32 states
//CustomClock quaver_timer (clk, 10714281, quaver_dur); //10714281
//stacc_quav_clock stacc_clock(clk, 3571427, stacc_signal); //3571427


CustomClock quaver_timer (clk, 10714284, quaver_dur); //10714281
stacc_quav_clock stacc_clock(clk, 1785714, stacc_signal); //1785714
//// </Duration Counters> ////

always @ (posedge quaver_dur) begin
        music_state <= music_state + 1;
        if (music_state == 23) begin
            music_state <= 0;
        end
end 
    
always @ (posedge clk) begin
    //Music State Counter 31 states)
    
    if (stacc_signal == 0) begin
        music_reg = 0;
    end
    
    else begin
        if (music_state == 0 || music_state == 1 || music_state == 2 || music_state == 3 ||
            music_state == 6 || music_state == 7 || music_state == 8 || music_state == 9 ||
            music_state == 12 || music_state == 13 || music_state == 14 || music_state == 15 ||
            music_state == 18 || music_state == 19 || music_state == 20 || music_state == 21 ||
            music_state == 23) begin
            music_reg <= A3;
        end
        
        else if (music_state == 4 || music_state == 10 || music_state == 16 || music_state == 22) begin
            music_reg <= G3;
        end
        
        else if (music_state == 5 || music_state == 17) begin
            music_reg <= C4;
        end
        
        else if (music_state == 11) begin
            music_reg <= E4;
        end   
                        
    end
end

    assign speaker = music_reg;
endmodule