module health_bar(
    input health_drop_clk,
    input [4:0] curr_health,
    input [12:0] pixel_index,
    output reg [15:0] oled_colour,
    output reg [4:0] prev_health = 31
);

    reg [15:0] COLOUR_YELLOW = 16'b11111_111111_00000;
    reg [15:0] COLOUR_RED    = 16'b11111_000000_00000;
    reg [15:0] COLOUR_WHITE    = 16'hFFFF;
    
    parameter FULL_HEALTH = 31;

    always@(posedge health_drop_clk)
    begin
        if( (prev_health > curr_health) && (prev_health > 0) )
            prev_health = prev_health - 1;

    end    

    integer X_HEALTH_START = 55;
    integer Y_HEALTH_BORDER_START = 2;
    integer Y_HEALTH_ACT_START = 3;
    integer FULL_HEALTH_HEIGHT = 8;
    integer FULL_HEALTH_LEN = 40;
    integer ACT_HEALTH_HEIGHT = 6; 

    wire draw_health_box;
    Draw_Rect dhb(.pixel_index(pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_BORDER_START),
                  .length(FULL_HEALTH_LEN),.height(FULL_HEALTH_HEIGHT),
                  .draw(draw_health_box));

    wire draw_rem_health;
    Draw_Rect drh(.pixel_index(pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_ACT_START),
                  .length(FULL_HEALTH_LEN-1),.height(ACT_HEALTH_HEIGHT),
                  .draw(draw_rem_health));                  

    wire [7:0] health_length;
    assign health_length = prev_health * FULL_HEALTH_LEN / FULL_HEALTH;

    wire draw_cur_health;
    Draw_Rect dch(.pixel_index(pixel_index),
                  .X_coord_start(X_HEALTH_START),.Y_coord_start(Y_HEALTH_ACT_START),
                  .length(health_length),.height(ACT_HEALTH_HEIGHT),
                  .draw(draw_cur_health));

    always @(pixel_index)
    begin
        if(draw_cur_health)
            oled_colour = COLOUR_YELLOW;
        else if(draw_rem_health)
            oled_colour = COLOUR_RED;
        else if(draw_health_box)
            oled_colour = COLOUR_WHITE;
        else 
            oled_colour = 16'h0000;
    end

endmodule