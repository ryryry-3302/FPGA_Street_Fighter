module sprite_control (
    input clk,
    input modify_col,input mirror,
    
    input [6:0] x, //2^7 = 128 > 96 (x_max)
    input [6:0] y, //2^7 = 128 > 63 (y_max)
    
    input in_air, is_moving,
    input [1:0] character_state,

    input [12:0] pixel_index,
    
    
    output reg [15:0] oled_colour
);
    wire punch_clk;
    CustomClock clk4hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd12_500_000 - 1),
                        .CLOCK_OUT(punch_clk));

    wire walk_clk;
    CustomClock clk2hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd25_000_000 - 1),
                        .CLOCK_OUT(walk_clk));

    //Note that middle x = 48, middle y = 32
    reg [12:0] translated_pixel_index;
    reg [7:0] X_coord;
    always@(pixel_index)
    begin
        translated_pixel_index = pixel_index;
        
        if(mirror)
        begin
            X_coord = pixel_index%96;
            translated_pixel_index = pixel_index - 2*(X_coord - 48);
            translated_pixel_index = translated_pixel_index + (x-48);
            translated_pixel_index = translated_pixel_index - (y-32)*96; 
        end
        
        else
        begin
            translated_pixel_index = translated_pixel_index - (x-48);
            translated_pixel_index = translated_pixel_index - (y-32)*96;
        end
    end


    // Moving/Normal State
    reg [1:0] sprite_norm = 2'b00;
    wire [15:0] Gui_1_col; Gui_State1 gs1(translated_pixel_index,Gui_1_col);
    wire [15:0] Gui_2_col; Gui_State2 gs2(translated_pixel_index,Gui_2_col);
    wire [15:0] Gui_3_col; Gui_State3 gs3(translated_pixel_index,Gui_3_col);
     
    //Attack State
    reg [1:0] sprite_punch = 2'b00;
    wire [15:0] Gui_p1_col; Gui_Punch1 gp1(translated_pixel_index,Gui_p1_col);
    wire [15:0] Gui_p2_col; Gui_Punch2 gp2(translated_pixel_index,Gui_p2_col);   
    wire [15:0] Gui_p3_col; Gui_Punch3 gp3(translated_pixel_index,Gui_p3_col);              
         
    always@(posedge walk_clk)
    begin
        if(is_moving)
            sprite_norm = (sprite_norm >= 2'b10) ? 2'b00 : sprite_norm + 1;
        else
            sprite_norm = 2'b00;
    end

    always@(posedge punch_clk)
    begin
        sprite_punch = (sprite_punch >= 2'b10) ? 2'b00 : sprite_punch + 1;
    end

    
    
    /*
    comboMove value refers to:
    0: not attacking
    1: normal attack
    2: special attack (left > down > right > attack)
    3: super special attack (up >down >up >down >left >right >left >right >attack)
    */
    
    always@(pixel_index)
    begin
        //State Animations------------------
        if(character_state == 2'b00) //Not Attacking
            begin        
            case(sprite_norm)
                2'b00: oled_colour = Gui_1_col;
                2'b01: oled_colour = Gui_2_col;
                2'b10: oled_colour = Gui_3_col;
                default: oled_colour = 16'hFFFF;
            endcase
            end
        else if (character_state == 2'b01)  //Normal Attack
            begin        
            case(sprite_punch)
                2'b00: oled_colour = Gui_p1_col;
                2'b01: oled_colour = Gui_p2_col;
                2'b10: oled_colour = Gui_p3_col;
                default: oled_colour = 16'hFFFF;
            endcase
            end
        //----------------------------------        
        
        if(oled_colour == 16'hFFFF)
            oled_colour = 16'h0000; //Just convert to black
        
        //Color transform for diff sprite
        if(modify_col && oled_colour != 16'hFFFF)
            begin
                oled_colour [10:5] = oled_colour[10:5] >> 1;
            end
        
    end    

endmodule