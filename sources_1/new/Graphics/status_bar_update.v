module status_bar_update(
    input clk,
    input [4:0] curr_health_l,
    input [4:0] curr_health_r,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour 
);  

    reg [15:0] COLOUR_WHITE  = 16'hFFFF;
    reg [15:0] COLOUR_YELLOW = 16'b11111_111111_00000;
    reg [15:0] COLOUR_RED    = 16'b11111_000000_00000;
    reg [15:0] COLOUR_BLUE   = 16'b00000_000000_11111;
    
    //Set full health to be max of [4:0] = 31
    parameter full_health = 31;
    reg [4:0] prev_health_l = full_health;
    reg [4:0] prev_health_r = full_health;

    wire CLOCK_ANIMATE; //1Hz                    
    CustomClock clk10hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd50_000_000 - 1),
                        .CLOCK_OUT(CLOCK_ANIMATE));

    //Animate the health bar decreasing
    always@(posedge CLOCK_ANIMATE)
    begin
        if(prev_health_l > curr_health_l)
            prev_health_l = prev_health_l - 1;
        
        if(prev_health_r > curr_health_r)
            prev_health_r = prev_health_r - 1;
    end


    wire [15:0] KO_Text;
    KO_Text kotext(.pixel_index(pixel_index),.oled_colour(KO_Text));

    integer X_HEALTH_START = 55;
    integer Y_HEALTH_BORDER_START = 2;
    integer Y_HEALTH_ACT_START = 3;
    integer FULL_HEALTH_HEIGHT = 8;
    integer FULL_HEALTH_LEN = 40;
    integer AC_HEALTH_HEIGHT = 6;
    
    
    reg [12:0] mirror_pixel_index;
    always @(pixel_index)
    begin 
        mirror_pixel_index = pixel_index - 2*(pixel_index%96 - 48);
    end

    /*
    wire full_health_l; // Need to mirror this (use translated_pixel_index)
    Draw_Rect fhl(.pixel_index(mirror_pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_BORDER_START),
                  .length(FULL_HEALTH_LEN),.height(FULL_HEALTH_HEIGHT),.draw(full_health_l));
    */

    wire draw_full_health_r;
    Draw_Rect fhr(.pixel_index(pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_BORDER_START),
                  .length(FULL_HEALTH_LEN),.height(FULL_HEALTH_HEIGHT),.draw(draw_full_health_r));


    wire [7:0] health_length_l;
    assign health_length_l = (curr_health_l/full_health) * FULL_HEALTH_LEN;
    wire [7:0] health_length_r;
    assign health_length_r = (prev_health_r * FULL_HEALTH_LEN / full_health);

    /*
    wire curr_health_length_l; // Need to mirror this (use translated_pixel_index)
    Draw_Rect ahl(.pixel_index(mirror_pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_ACT_START),
                  .length(health_length_l),.height(AC_HEALTH_HEIGHT),.draw(curr_health_l));*/

    wire draw_curr_health_r;
    Draw_Rect ahr(.pixel_index(pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_ACT_START),
                  .length(health_length_r),.height(AC_HEALTH_HEIGHT),.draw(draw_curr_health_r));


    wire KO_Background;
    Draw_Rect kob(.pixel_index(pixel_index),
                  .X_coord_start(42),.Y_coord_start(2),
                  .length(12),.height(7),.draw(KO_Background)); 


    always@(pixel_index)
    begin
        if(KO_Text != 16'h0000)
            oled_colour = KO_Text;
        else if(KO_Background)
            oled_colour = COLOUR_BLUE; //Debugging
        else if (draw_curr_health_r)
            oled_colour = COLOUR_YELLOW;            
        else if (draw_full_health_r)
            oled_colour = COLOUR_RED;
        else
            oled_colour = 16'h0000;
    end                               





endmodule