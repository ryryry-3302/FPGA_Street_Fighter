module sprite_control (
    input clk,
    //0,0 is top left!!!
    input [6:0] x, //2^7 = 128 > 96 (x_max)
    input [6:0] y, //2^7 = 128 > 63 (y_max)
    input in_air, is_moving,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour
);
    wire animate_clk; //Lets do 2Hz for now
    CustomClock clk2hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd25_000_000),
                        .CLOCK_OUT(animate_clk));

    //Note that middle x = 48, middle y = 32
    reg [12:0] translated_pixel_index;
    always@(pixel_index)
    begin
        translated_pixel_index = pixel_index - (x-48);
        translated_pixel_index = translated_pixel_index - (y-32)*96;
    end


    wire [15:0] Gui_1_col;
    Gui_State1 gs1(translated_pixel_index,Gui_1_col);

    wire [15:0] Gui_2_col;
    Gui_State2 gs2(translated_pixel_index,Gui_2_col);

    wire [15:0] Gui_3_col;
    Gui_State3 gs3(translated_pixel_index,Gui_3_col);

    reg [1:0] gui_state = 2'b00;    
    always@(posedge animate_clk)
    begin
        if(is_moving)
            gui_state = (gui_state >= 2'b10) ? 2'b00 : gui_state + 1;
        else
            gui_state = 2'b00;
    end


    
    always@(pixel_index)
    begin        
        case(gui_state)
            2'b00: oled_colour = Gui_1_col;
            2'b01: oled_colour = Gui_2_col;
            2'b10: oled_colour = Gui_3_col;
            default: oled_colour = 16'hFFFF;
        endcase
    end    

endmodule