`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clk,
    input [15:0]sw,
    input btnC, btnL, btnR, btnU, btnD,
    output [7:0] JC,
    output [15:0] led
);

    //Physics Engine ---------------------------------
    wire[6:0] sprite1_x_out;
    wire[6:0] sprite1_y_out;
    wire[6:0] sprite2_x_out;
    wire[6:0] sprite2_y_out;
     
   wire player1isColliding;
   wire player2isColliding;

    PhysicsEngine PhysicsEngine1(.velocityUp(led[7:0]),.player_no(0),.clk(clk),.reset(sw[0]),.isColliding(player1isColliding),.movingLeft(btnL),.movingRight(btnR),.isJumping(btnU),.sprite_x_out(sprite1_x_out),.sprite_y_out( sprite1_y_out), .sprite2_x(sprite2_x_out),.sprite2_y(sprite2_y_out));
    PhysicsEngine PhysicsEngine2(.velocityUp(0),.player_no(1),.clk(clk),.reset(sw[0]),.isColliding(player2isColliding),.movingLeft(sw[15]),.movingRight(sw[14]),.isJumping(sw[13]),.sprite_x_out(sprite2_x_out),.sprite_y_out( sprite2_y_out), .sprite2_x(sprite1_x_out),.sprite2_y(sprite1_y_out));

    CollisionDetection CollisionDetection(.clk(clk),.reset(sw[0]), .player_1x(sprite1_x_out), .player_1y(sprite1_y_out), .player_2x(sprite2_x_out), .player_2y(sprite2_y_out), .player_1_collision(player1isColliding), .player_2_collision(player2isColliding));
    assign led[15] = player1isColliding;
    //OLED Driver -----------------------------------
    reg [15:0] oled_colour;
    
    wire frame_begin;
    wire [12:0] pixel_index;
    wire sending_pixels, sample_pixel;

    wire CLK_6MHz25;
    CustomClock clk6p25m(.CLOCK_IN(clk),
                         .COUNT_STOP(32'd7),
                         .CLOCK_OUT(CLK_6MHz25));

    //------------------------------------------------
    //Status Bar -------------------------------------------
        wire [15:0] status_bar_col;
        wire [4:0] health_l;
        wire [4:0] health_r;
        status_bar_update sbu(.clk(clk),
                              .curr_health_l(31),
                              .curr_health_r(0),
                              .pixel_index(pixel_index),
                              .oled_colour(status_bar_col),
                              .final_health_l(health_l),
                              .final_health_r(health_r));
    
    //2 Sprites -------------------------------------------
        integer ground_height = 48;
        
        wire [15:0] sprite_1_col;
        sprite_control sp1_ctr(.clk(clk),
                                .modify_col(0), .mirror(0),
                                .x(sprite1_x_out), .y(sprite1_y_out),
                                .in_air(0), .move_state({btnL,btnR}),
                                .character_state({0,btnD,btnC} ),
                                .pixel_index(pixel_index),
                                .oled_colour(sprite_1_col));
                                
        wire [15:0] sprite_2_col;
        sprite_control sp2_ctr(.clk(clk),
                                .modify_col(1), .mirror(1),
                                .x(sprite2_x_out), .y(sprite2_y_out),
                                .in_air(0), .is_moving(1),
                                .character_state({0,btnR}),
                                .pixel_index(pixel_index),
                                .oled_colour(sprite_2_col));                             
                              
    //Background -------------------------------------------  
        wire [15:0] background_color;
        backgroud_control bck_ctr(.clk(clk),
                                  .pixel_index(pixel_index),
                                  .oled_colour(background_color));
    
    // Oled colour mux -------------------------------------------    
        always@(pixel_index)
        begin
            if(status_bar_col != 16'h0000)
                oled_colour = status_bar_col;
            else if(sprite_2_col != 16'h0000)
                oled_colour = sprite_2_col;
            else if(sprite_1_col != 16'h0000)
                oled_colour = sprite_1_col;           
            else
                oled_colour = background_color;
        end
   
            
    //Insantiate Imported Modules -----------------------
    Oled_Display myoled(
        .clk(CLK_6MHz25), 
        .reset(0),
        .frame_begin(frame_begin),
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index),
        .pixel_data(oled_colour),
        .cs(JC[0]),
        .sdin(JC[1]),
        .sclk(JC[3]),
        .d_cn(JC[4]),
        .resn(JC[5]),
        .vccen(JC[6]),
        .pmoden(JC[7]));

endmodule