module status_bar_update(
    input clk,
    input [4:0] curr_health_l,
    input [4:0] curr_health_r,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour,
    
    output [4:0] final_health_l,
    output [4:0] final_health_r 
);  

    reg [15:0] COLOUR_WHITE  = 16'hFFFF;
    reg [15:0] COLOUR_YELLOW = 16'b11111_111111_00000;
    reg [15:0] COLOUR_RED    = 16'b11111_000000_00000;
    reg [15:0] COLOUR_BLUE   = 16'b00000_000000_11111;

    wire CLOCK_ANIMATE; //1Hz                    
    CustomClock clk10hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd50_000_000 - 1),
                        .CLOCK_OUT(CLOCK_ANIMATE));

    wire [15:0] hb_right_col;
    health_bar hb_r(.health_drop_clk(CLOCK_ANIMATE),
                    .curr_health(curr_health_r),
                    .pixel_index(pixel_index),
                    .oled_colour(hb_right_col),
                    .prev_health(final_health_r));


    reg [12:0] mirror_pixel_index;
    always @(pixel_index)
    begin 
        mirror_pixel_index = pixel_index - 2*((pixel_index%96) - 48);
    end

    wire [15:0] hb_left_col;
    health_bar hb_l(.health_drop_clk(CLOCK_ANIMATE),
                    .curr_health(curr_health_l),
                    .pixel_index(mirror_pixel_index),
                    .oled_colour(hb_left_col),
                    .prev_health(final_health_l));    


    //KO Stuff ------------------------------------------------------
    wire KO_Background;
    Draw_Rect kob(.pixel_index(pixel_index),
                  .X_coord_start(42),.Y_coord_start(2),
                  .length(12),.height(8),.draw(KO_Background)); 

    wire [15:0] KO_Text;
    KO_Text kotext(.pixel_index(pixel_index),.oled_colour(KO_Text));
    //----------------------------------------------------------------


    always@(pixel_index)
    begin
        if(KO_Text != 16'h0000)
            oled_colour = KO_Text;
        else if(KO_Background)
            oled_colour = COLOUR_RED; //Debugging
        else if(hb_right_col != 16'h0000)
            oled_colour = hb_right_col;
        else if(hb_left_col  != 16'h0000)
            oled_colour = hb_left_col;
        else
            oled_colour = 16'h0000;
    end                               





endmodule