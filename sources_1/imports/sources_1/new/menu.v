module menu(input clk,
            input [12:0] pixel_index,
            input [1:0] game_state,
             //state 00 fight //state 01 player 1 wins //state 02 player 2 wins state 11 no res

            output reg [6:0] seg,
            output reg [3:0] an,
            output reg [15:0] oled_colour);

    wire CLK_500Hz;
    CustomClock clk500hz(.CLOCK_IN(clk),.COUNT_STOP(100_000 - 1),.CLOCK_OUT(CLK_500Hz));

    wire draw_rect_col;
    Draw_Rect draw_rec(.pixel_index(pixel_index),
                .X_coord_start(0),.Y_coord_start(22),
                .length(96),.height(20),.draw(draw_rect_col));


    parameter LETTER_W = ~7'b0101010;
    parameter LETTER_I = ~7'b0110000;
    parameter LETTER_N = ~7'b0110111;
    parameter NULL     = ~7'b0000000;

    parameter LETTER_L = ~7'b0111000;
    parameter LETTER_O = ~7'b0111111;
    parameter LETTER_S = ~7'b1101101;
    parameter LETTER_E = ~7'b1111001;

    parameter DASH     = ~7'b1000000;

    parameter COLOUR_GREEN = 16'b00000_111111_00000;
    parameter COLOUR_RED   = 16'b11111_000000_00000;
    parameter COLOUR_WHITE = 16'hFFFF;
    parameter COLOUR_BLACK = 16'h0000;

    reg [1:0] annode_now = 2'b00;
    reg [6:0] digit3;
    reg [6:0] digit2;
    reg [6:0] digit1;
    reg [6:0] digit0;

    //Digit Cycling
    always @(posedge CLK_500Hz)
    begin
        case(annode_now)
        0: begin seg = digit3; an = 4'b0111; end
        1: begin seg = digit2; an = 4'b1011; end
        2: begin seg = digit1; an = 4'b1101; end
        3: begin seg = digit0; an = 4'b1110; end
        endcase

        annode_now = annode_now + 1;
    end

    always@(game_state)
    begin
        case(game_state)

        2'b00: begin //fight in progress //Try to make this state blink!
            digit3 = DASH; digit2 = DASH; digit1 = DASH; digit0 = DASH;
            oled_colour = COLOUR_BLACK;
        end
        
        2'b01: begin
            digit3 = LETTER_W; digit2 = LETTER_I; digit1 = LETTER_N; digit0 = NULL; 
            oled_colour = (draw_rect_col) ? COLOUR_GREEN: COLOUR_BLACK;
        end

        2'b10: begin
            digit3 = LETTER_L; digit2 = LETTER_O; digit1 = LETTER_S; digit0 = LETTER_E;
            oled_colour = (draw_rect_col) ? COLOUR_RED: COLOUR_BLACK ;
        end  

        2'b11: begin 
            digit3 = LETTER_O; digit2 = LETTER_O; digit1 = LETTER_O; digit0 = LETTER_O;
            oled_colour = (draw_rect_col) ? COLOUR_WHITE: COLOUR_BLACK;  
        end
   
        endcase
    end


endmodule