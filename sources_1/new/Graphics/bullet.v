module bullet(
    input clk,
    input [1:0] attack_state,
    input mirrored,
    input [6:0] player_1x, //The one throwing the bullet
    input [6:0] player_1y,
    input [6:0] player_2x,
    input [6:0] player_2y,
    input [12:0] pixel_index,
    input [4:0] random_5bit_val,

    output reg [6:0] bullet_x = 0,
    output reg [6:0] bullet_y = 0,
    output reg bullet_en = 0,
    output reg [15:0] oled_colour
);  
    parameter SPECIAL_ATTACK_STATE = 2'b11; //shld be 11 udlrlr attack
    parameter BULLET_RADIUS = 4;
    parameter BULLET_COL = 16'b00000_111111_00000;
    parameter COLOUR_BLACK = 16'h0000;
    parameter RAISE_BULLET = 5;

    wire BULLET_CLK; CustomClock clk40hz(clk, 32'd625_000, BULLET_CLK);
    wire SAMPLE_CLK; CustomClock clk10khz(clk, 32'd50_000-1, SAMPLE_CLK);
    
    wire draw_bullet;
    drawCircle bul(.pixel_index(pixel_index),
                    .center_X(bullet_x), .center_Y(bullet_y),
                    .radius(BULLET_RADIUS),.draw(draw_bullet));
    
    reg updated_mirrored;
    always@(posedge BULLET_CLK)
    begin
        if(bullet_en)
                bullet_x = (updated_mirrored) ? bullet_x - 1: bullet_x + 1;
        else
                bullet_x = player_1x;
    end                

    wire hit_player =  (bullet_x >= player_2x - BULLET_RADIUS)
                    && (bullet_x <= player_2x + BULLET_RADIUS) 
                    && (bullet_y >= player_2y - BULLET_RADIUS - RAISE_BULLET) 
                    && (bullet_y <= player_2y + BULLET_RADIUS - RAISE_BULLET);

    wire hit_screen = (bullet_x <= BULLET_RADIUS) || (bullet_x >= 96 - BULLET_RADIUS);

    always@(posedge SAMPLE_CLK)
    begin
        if(hit_player || hit_screen)
            bullet_en = 0;   
        else if(attack_state==SPECIAL_ATTACK_STATE && bullet_en==0)
        //How to save values in verilog?
            bullet_en = 1;
            bullet_y = player_1y - RAISE_BULLET;
            updated_mirrored = mirrored;
    end
    
    wire [15:0] bullet_col;
    reg [7:0] hue_res = 0;
    hsv_to_rgb bulcol( .h(hue_res), .rgb(bullet_col));
    
    always@(negedge bullet_en)
    begin
        hue_res = random_5bit_val * 10;
    end
    

    always@(pixel_index)
    begin
        if(bullet_en && draw_bullet)
            oled_colour = bullet_col;
        else
            oled_colour = COLOUR_BLACK;
    end
    





endmodule