module KO_Text(
    input [12:0] pixel_index, 
    output reg [15:0] oled_colour 
); 

    reg [15:0] COLOUR_WHITE = 16'hFFFF;

    always @(pixel_index)
    begin
        case(pixel_index)
        331: oled_colour = COLOUR_WHITE;
        334: oled_colour = COLOUR_WHITE;
        335: oled_colour = COLOUR_WHITE;
        337: oled_colour = COLOUR_WHITE;
        338: oled_colour = COLOUR_WHITE;
        339: oled_colour = COLOUR_WHITE;
        340: oled_colour = COLOUR_WHITE;
        341: oled_colour = COLOUR_WHITE;

        427: oled_colour = COLOUR_WHITE;
        429: oled_colour = COLOUR_WHITE;
        430: oled_colour = COLOUR_WHITE;
        433: oled_colour = COLOUR_WHITE;
        437: oled_colour = COLOUR_WHITE;

        523: oled_colour = COLOUR_WHITE;
        524: oled_colour = COLOUR_WHITE;
        525: oled_colour = COLOUR_WHITE;
        529: oled_colour = COLOUR_WHITE;
        533: oled_colour = COLOUR_WHITE;

        619: oled_colour = COLOUR_WHITE;
        620: oled_colour = COLOUR_WHITE;
        621: oled_colour = COLOUR_WHITE;
        625: oled_colour = COLOUR_WHITE;
        629: oled_colour = COLOUR_WHITE;   

        715: oled_colour = COLOUR_WHITE;
        717: oled_colour = COLOUR_WHITE;
        718: oled_colour = COLOUR_WHITE;
        721: oled_colour = COLOUR_WHITE;
        725: oled_colour = COLOUR_WHITE;   

        811: oled_colour = COLOUR_WHITE;
        814: oled_colour = COLOUR_WHITE;
        815: oled_colour = COLOUR_WHITE;
        817: oled_colour = COLOUR_WHITE;
        818: oled_colour = COLOUR_WHITE;   
        819: oled_colour = COLOUR_WHITE;
        820: oled_colour = COLOUR_WHITE;
        821: oled_colour = COLOUR_WHITE;

        default: oled_colour = 16'b00000_000000_00000;     

        endcase
    end 


endmodule