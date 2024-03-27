module sprite_control (
    input clk,
    input modify_col,input mirror,
    
    input [6:0] x, //2^7 = 128 > 96 (x_max)
    input [6:0] y, //2^7 = 128 > 63 (y_max)
    
    input in_air,
    input [1:0] move_state,
    input [2:0] character_state,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour
);  


    //All the clocks. Share common clock
    /*
    wire clk_2hz;
    CustomClock clk2hz(.CLOCK_IN(clk),
                       .COUNT_STOP(32'd25_000_000 - 1),
                       .CLOCK_OUT(clk_2hz)); */ 

    wire clk_4hz;
    CustomClock clk4hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd12_500_000 - 1),
                        .CLOCK_OUT(clk_4hz));                               
    

    // Translation and Mirroring based on mirror and x,y ----------------------------
    reg [12:0] translated_pixel_index;
    always@(pixel_index) //Note that middle x = 48, middle y = 32
    begin        
        if(mirror)
            begin
            translated_pixel_index = pixel_index - 2*(pixel_index%96 - 48);
            translated_pixel_index = translated_pixel_index + (x-48);
            translated_pixel_index = translated_pixel_index - (y-32)*96; 
            end
        
        else
            begin
            translated_pixel_index = pixel_index - (x-48);
            translated_pixel_index = translated_pixel_index - (y-32)*96;
            end
    end
    //------------------------------------------------------------------------------


    // Moving/Normal State-----------------------------------------------
    reg [1:0] sprite_norm = 2'b00;
    wire [15:0] Gui_1_col; Gui_State1 gs1(translated_pixel_index,Gui_1_col);
    wire [15:0] Gui_2_col; Gui_State2 gs2(translated_pixel_index,Gui_2_col);
    wire [15:0] Gui_3_col; Gui_State3 gs3(translated_pixel_index,Gui_3_col);

    always@(posedge clk_4hz)
    begin
        case(move_state)
        2'b00: sprite_norm = 2'b00;
        2'b01: sprite_norm = (sprite_norm == 2'b01)? 2'b00: 2'b01; //Move forward  0/1/0/1
        2'b10: sprite_norm = (sprite_norm == 2'b10)? 2'b00: 2'b10; //Move backward 0/2/0/2
        default sprite_norm = 2'b00;
        endcase
    end
    //------------------------------------------------------------------------------   


    // Normal Attack State -------------------------------------------------------- 
    reg [1:0] sprite_punch = 2'b00;
    wire [15:0] Gui_p1_col; Gui_Punch1 gp1(translated_pixel_index,Gui_p1_col);
    wire [15:0] Gui_p2_col; Gui_Punch2 gp2(translated_pixel_index,Gui_p2_col);   
    wire [15:0] Gui_p3_col; Gui_Punch3 gp3(translated_pixel_index,Gui_p3_col);              

    always@(posedge clk_4hz)
    begin
        if(character_state != 3'b001)
            sprite_punch = 2'b00;
        else
            sprite_punch = (sprite_punch >= 2'b10) ? 2'b11 : sprite_punch + 1;
    end
    //------------------------------------------------------------------------------     

    // Getting Hit State
    //Reverse the order cause module named wrongly
    reg [1:0] sprite_inj = 2'b00;
    wire [15:0] Gui_i1_col; Gui_Inj3 gi1(translated_pixel_index,Gui_i1_col);
    wire [15:0] Gui_i2_col; Gui_Inj2 gi2(translated_pixel_index,Gui_i2_col);
    wire [15:0] Gui_i3_col; Gui_Inj1 gi3(translated_pixel_index,Gui_i3_col);     

    always@(posedge clk_4hz)
    begin
        if(character_state != 3'b010)
            sprite_inj = 2'b00;
        else
            sprite_inj = (sprite_inj >= 2'b10) ? 2'b11 : sprite_inj + 1;
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
        if(character_state == 3'b000) //Not Attacking
            begin        
            case(sprite_norm)
                2'b00: oled_colour = Gui_1_col;
                2'b01: oled_colour = Gui_2_col;
                2'b10: oled_colour = Gui_3_col;
                default: oled_colour = 16'hFFFF;
            endcase
            end
        else if (character_state == 3'b001)  //Normal Attack
            begin        
            case(sprite_punch)
                2'b00: oled_colour = Gui_p1_col;
                2'b01: oled_colour = Gui_p2_col;
                2'b10: oled_colour = Gui_p3_col;
                2'b11: oled_colour = Gui_1_col; //Return to normal state after action finished
            endcase
            end
        else if (character_state == 2'b010)
            begin
                case(sprite_inj)
                2'b00: oled_colour = Gui_i1_col;
                2'b01: oled_colour = Gui_i2_col;
                2'b10: oled_colour = Gui_i3_col;
                2'b11: oled_colour = Gui_1_col; //Return to normal state after action finished                
                endcase
            end
        //----------------------------------        
        
        //Color transform for diff sprite for non black
        if(modify_col && oled_colour != 16'hFFFF)
            begin
                oled_colour [10:5] = oled_colour[10:5] >> 1;
            end
        
    end    

endmodule