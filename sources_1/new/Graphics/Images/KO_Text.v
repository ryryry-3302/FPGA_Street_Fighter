module KO_Text(
    input [12:0] pixel_index, 
    output reg [15:0] oled_colour 
); 

    reg [15:0] COLOUR_WHITE = 16'hFFFF;

    always @(pixel_index)
    begin
        case(pixel_index)
        330: oled_colour = COLOUR_WHITE;
        333: oled_colour = COLOUR_WHITE;
        334: oled_colour = COLOUR_WHITE;
        338: oled_colour = COLOUR_WHITE;
        339: oled_colour = COLOUR_WHITE;
        340: oled_colour = COLOUR_WHITE;
        341: oled_colour = COLOUR_WHITE;
        342: oled_colour = COLOUR_WHITE;

        426: oled_colour = COLOUR_WHITE;
        428: oled_colour = COLOUR_WHITE;
        429: oled_colour = COLOUR_WHITE;
        434: oled_colour = COLOUR_WHITE;
        438: oled_colour = COLOUR_WHITE;

        522: oled_colour = COLOUR_WHITE;
        523: oled_colour = COLOUR_WHITE;
        524: oled_colour = COLOUR_WHITE;
        530: oled_colour = COLOUR_WHITE;
        534: oled_colour = COLOUR_WHITE;

        618: oled_colour = COLOUR_WHITE;
        619: oled_colour = COLOUR_WHITE;
        620: oled_colour = COLOUR_WHITE;
        626: oled_colour = COLOUR_WHITE;
        630: oled_colour = COLOUR_WHITE;   

        714: oled_colour = COLOUR_WHITE;
        716: oled_colour = COLOUR_WHITE;
        717: oled_colour = COLOUR_WHITE;
        722: oled_colour = COLOUR_WHITE;
        726: oled_colour = COLOUR_WHITE;   

        810: oled_colour = COLOUR_WHITE;
        813: oled_colour = COLOUR_WHITE;
        814: oled_colour = COLOUR_WHITE;
        818: oled_colour = COLOUR_WHITE;
        819: oled_colour = COLOUR_WHITE;   
        820: oled_colour = COLOUR_WHITE;
        821: oled_colour = COLOUR_WHITE;
        822: oled_colour = COLOUR_WHITE;

        default: oled_colour = 16'b00000_000000_00000;     

        endcase
    end 


endmodule