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
    input [7:0] JA, //slaveMasterController master input signals
    output [7:0] JXADC, //slaveMasterController slave output signals
    output reg [7:0] JC,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output speaker //audioOut pmod, connect to JB
);


    wire CLK_20Hz; //the master TPS clock
    
    wire player1BOT; wire player2BOT;
    assign player1BOT = ~winner[0] && ~winner[1]?sw[8]:0; assign player2BOT = ~winner[0]&&~winner[1]?sw[7]:0;
    
    wire [4:0]random5bitValue1; //our random value. seed is built into the module | ranges from 0 to 31 (inclusive)
    wire [4:0]random5bitValue2; //our random value. seed is built into the module | ranges from 0 to 31 (inclusive) 
    LFSRrandom randomizer1(clk, random5bitValue1); 
    anotherLFSRrandom randomizer2(clk, random5bitValue2);
    
    //player movement ----------------------
    
    //player 1 inputs
    wire player1CharChoice; //3 bit value, can ignore for now if we dont have more char choices
    wire player1IsCrouched;
    wire player1IsInAir;
    wire player1IsStunned;
    wire player1IsPerformingAttackAnimation;
    
    //player 1 outputs
    wire player1Crouching;
    wire player1movingLeft;
    wire player1movingRight;
    wire player1Jumping;
    wire player1Blocking;
    wire [1:0]player1ComboMove; //0 means not attacking, 1 means nornmal attack, 2 means special attack, 3 means super attack
    assign led[9:8] = player1ComboMove[1:0]; //lights up for checking of combo moves
    
    //player 2 controls EDITS HERE TO CONNECT TO BOT/2ND PLAYER
    wire master_cs, master_sdin, master_sclk, master_d_cn, master_resn, master_vccen, master_pmoden;
    wire slave_CLK_6MHz25, slave_cs, slave_sdin, slave_sclk, slave_d_cn, slave_resn, slave_vccen, slave_pmoden;    
    
    reg oled_clock;
    
    wire player2UpBtn;
    wire player2DownBtn;
    wire player2LeftBtn;
    wire player2RightBtn;
    wire player2AttackBtn;
    
    //Slave Master Data Flow Handler
//    slaveMasterSetter myOppressor (.isMaster(sw[1]), .clk(clk), 
//        .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .btnC(btnC)
        
//        //Master inputs:
//        ,.input_player2UpBtn(JA[1]), .input_player2DownBtn(JA[2]), .input_player2LeftBtn(JA[3]), .input_player2RightBtn(JA[4]),
//        .input_player2AttackBtn(JA_attack),
//        .player2UpBtn(player2UpBtn), .player2DownBtn(player2DownBtn), .player2LeftBtn(player2LeftBtn), .player2RightBtn(player2RightBtn), 
//        .player2AttackBtn(player2AttackBtn)
        
//        //Slave outputs:
//        ,.slaveOut_player2UpBtn(JXADC[1]), .slaveOut_player2DownBtn(JXADC[2]), .slaveOut_player2LeftBtn(JXADC[3]), .slaveOut_player2RightBtn(JXADC[4]),
//        .slaveOut_player2AttackBtn(JXADC_attack)
//        );
        
    slaveMasterSetter(.isMaster(sw[1]), .clk(clk),.JA(JA), .JXADC(JXADC)
        
            //Master inputs and outputs:
            ,.cs(master_cs), .sdin(master_cs), .sclk(master_sclk), .d_cn(master_d_cn), .resn(master_resn), .vccen(master_vccen), .pmoden(master_pmoden)
            ,.player2UpBtn(player2UpBtn), .player2DownBtn(player2DownBtn), .player2LeftBtn(player2LeftBtn), .player2RightBtn(player2RightBtn), 
            .player2AttackBtn(player2AttackBtn)
            
            //Slave inputs and outputs:
            ,.btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .btnC(btnC)
            , .slave_CLK_6MHz25(slave_CLK_6MHz25), .slave_cs(slave_cs), .slave_sdin(slave_sdin), .slave_sclk(slave_sclk), .slave_d_cn(slave_d_cn), .slave_resn(slave_resn), .slave_vccen(slave_vccen), .slave_pmoden(slave_pmoden)
            );
    
    assign led[10] = player2UpBtn;
    assign led[11] = player2LeftBtn;
    assign led[12] = player2RightBtn;
    assign led[13] = player2AttackBtn;

    //player 2 inputs
    wire player2CharChoice; //3 bit value, can ignore for now if we dont have more char choices
    wire player2IsCrouched;
    wire player2IsInAir;
    wire player2IsStunned;
    wire player2IsPerformingAttackAnimation;
    
    //player 2 outputs
    wire player2Crouching;
    wire player2movingLeft;
    wire player2movingRight;
    wire player2Jumping;
    wire player2Blocking;
    wire [1:0]player2ComboMove; //0 means not attacking, 1 means nornmal attack, 2 means special attack, 3 means super attack
    assign led[7:6] = player2ComboMove[1:0]; //lights up for checking of combo moves
    
    playerMovementHandler player1MovementHandler(
        //for AI
        .random5bit(random5bitValue1),
        .BYPASS(player1BOT),
        //raw inputs
        .clk(clk), 
        .gameTicks(CLK_20Hz), 
        .playerNumber(0), 
        .upButtonRaw(btnU), 
        .downButtonRaw(btnD), 
        .leftButtonRaw(btnL), 
        .rightButtonRaw(btnR), 
        .attackButtonRaw(btnC), 
        .blockButtonRaw(0), 
        //outputs
        .isCrouching(player1Crouching),
        .movingLeft(player1movingLeft),
        .movingRight(player1movingRight),
        .isJumping(player1Jumping),
        .isBlocking(0),
        .comboMove(player1ComboMove),
        //gamestate inputs
        .playerChar(player1CharChoice),
        .isCrouched(player1IsCrouched),
        .isInAir(player1IsInAir),
        .isStunned(player1IsStunned),
        .isPerformingAttackAnimation(player1IsPerformingAttackAnimation)
        );
       
    playerMovementHandler player2MovementHandler(
        //for AI
        .random5bit(random5bitValue2),
        .BYPASS(player2BOT),
        //raw inputs
        .clk(clk), 
        .gameTicks(CLK_20Hz), 
        .playerNumber(1), 
        .upButtonRaw(player2UpBtn), 
        .downButtonRaw(player2DownBtn), 
        .leftButtonRaw(player2LeftBtn), 
        .rightButtonRaw(player2RightBtn), 
        .attackButtonRaw(player2AttackBtn), 
        .blockButtonRaw(0), 
        //outputs
        .isCrouching(player2Crouching),
        .movingLeft(player2movingLeft),
        .movingRight(player2movingRight),
        .isJumping(player2Jumping),
        .isBlocking(0),
        .comboMove(player2ComboMove),
        //gamestate inputs
        .playerChar(player2CharChoice),
        .isCrouched(player2IsCrouched),
        .isInAir(player2IsInAir),
        .isStunned(player2IsStunned),
        .isPerformingAttackAnimation(player2IsPerformingAttackAnimation)
        );

    
    //player2 AI
    
    
    //Physics Engine ---------------------------------
    CustomClock clk20hz(.CLOCK_IN(clk),.COUNT_STOP(2500000),.CLOCK_OUT(CLK_20Hz));
    wire[6:0] sprite1_x_out;
    wire[6:0] sprite1_y_out;
    wire[6:0] sprite2_x_out;
    wire[6:0] sprite2_y_out;
     
    wire player1isColliding;
    wire player2isColliding;
    
    wire [2:0] winner; //Used in health management
    
    // Reset Cond: sw[0] or btnC + winnner defined must be held for 2s or more before reset_cond goes high
    reg reset_cond = 1;
    reg [5:0] timer = 0;
    always@(posedge CLK_20Hz)
    begin
        if((btnC && (winner != 2'b00) ) || sw[0] )
            timer <= timer + 1;
        else
            timer <= 0;
        
        reset_cond <= (timer >= 40) ? 1 : 0;
    end

    PhysicsEngine PhysicsEngine1(.velocityUp(0),.player_no(0),.clk(CLK_20Hz),.reset(reset_cond),.isColliding(player1isColliding),.movingLeft(player1movingLeft),.movingRight(player1movingRight),.isJumping(player1Jumping),.sprite_x_out(sprite1_x_out),.sprite_y_out( sprite1_y_out), .sprite2_x(sprite2_x_out),.sprite2_y(sprite2_y_out));
    PhysicsEngine PhysicsEngine2(.velocityUp(0),.player_no(1),.clk(CLK_20Hz),.reset(reset_cond),.isColliding(player2isColliding),.movingLeft(player2movingLeft),.movingRight(player2movingRight),.isJumping(player2Jumping),.sprite_x_out(sprite2_x_out),.sprite_y_out( sprite2_y_out), .sprite2_x(sprite1_x_out),.sprite2_y(sprite1_y_out));
    
    
    wire sprite1_facing_right;
    wire player_1_hitrangewire;

    CollisionDetection CollisionDetection(.clk(CLK_20Hz),.reset(reset_cond), .player_1x(sprite1_x_out), .player_1y(sprite1_y_out), .player_2x(sprite2_x_out), .player_2y(sprite2_y_out), .player_1_collision(player1isColliding), .player_2_collision(player2isColliding),.player_1_hitrange(player_1_hitrangewire));
    FacingState FacingState(.clk(CLK_20Hz), .sprite1_x(sprite1_x_out),.sprite1_y(sprite1_y_out),.sprite2_x(sprite2_x_out),.sprite2_y(sprite2_y_out),.sprite1_facing_right(sprite1_facing_right));
    
    assign led[14] = player_1_hitrangewire;
    assign led[15] = player1isColliding;
    
    //Hp management----------------------------------
    wire [8:0] health_1;
    wire [8:0] health_2;
    

    HealthManagement HealthManagement(.clk(CLK_20Hz),.reset(reset_cond),
                     .player_1_hitrangewire(player_1_hitrangewire),
                     .attack_statex(player1ComboMove),.attack_statey(player2ComboMove),
                     .health_1(health_1),.health_2(health_2), .state(winner),.hit1(player1IsStunned),.hit2(player2IsStunned),.bullethit1(bullethit1),.bullethit2(bullethit2));

    assign led[2:1] = winner;
    //------------------------------------------------
    
    //Background Music Controller -------------------
    musicController(.enableAudio(sw[2]), .clk(clk), .attackButtonRaw_1(player1ComboMove), .attackButtonRaw_2(player2ComboMove), .jumpButtonRaw_1(player1Jumping), .jumpButtonRaw_2(player2Jumping), .player1Health(health_1), .player2Health(health_2), .state(winner), .audioOut(speaker));
    //------------------------------------------------

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


    //Menu using 7 Seg Displays -------------------------
    assign dp = 1; //Keep it off
    wire [15:0] menu_col;

    menu menu_dis(.clk(clk),
                .pixel_index(pixel_index), .game_state(winner),
                .seg(seg), .an(an), .oled_colour(menu_col));
    //------------------------------------------------
    

    //Status Bar -------------------------------------------
        wire [15:0] status_bar_col;
        wire [4:0] health_l;
        wire [4:0] health_r;
        status_bar_update sbu(.clk(clk),
                              .curr_health_l(health_1),
                              .curr_health_r(health_2),
                              .pixel_index(pixel_index),
                              .oled_colour(status_bar_col),
                              .final_health_l(health_l),
                              .final_health_r(health_r));
    //------------------------------------------------                          
    

    //2 Sprites -------------------------------------------
        integer ground_height = 48;
        
        wire [15:0] sprite_1_col;
        sprite_control sp1_ctr(.clk(clk),
                                .modify_col(0), .mirror(~sprite1_facing_right),
                                .x(sprite1_x_out), .y(sprite1_y_out),
                                .in_air(0), .move_state({btnL,btnR}),
                                .character_state({player1IsStunned,player1ComboMove[1:0]}),
                                .pixel_index(pixel_index),
                                .oled_colour(sprite_1_col));
                                
        wire [15:0] sprite_2_col;
        sprite_control sp2_ctr(.clk(clk),
                                .modify_col(1), .mirror(sprite1_facing_right),
                                .x(sprite2_x_out), .y(sprite2_y_out),
                                .in_air(0), .move_state({sw[15],sw[13]}),
                                .character_state({player2IsStunned,player2ComboMove[1:0]}),
                                .pixel_index(pixel_index),
                                .oled_colour(sprite_2_col));                             
                              
    //Background -------------------------------------------  
        
        wire [15:0] background_color;
        backgroud_control bck_ctr(.clk(clk),
                                  .pixel_index(pixel_index),
                                  .oled_colour(background_color));
                                  
    //------------------------------------------------  

    //Bullet
    wire [15:0] bullet_col_1;
    wire [6:0] bullet_x1; wire [6:0] bullet_y1;
    wire bullet_en1;
    wire bullethit2;
    bullet bul(.clk(clk),.attack_state(player1ComboMove[1:0]),
                .mirrored(~sprite1_facing_right),
                .player_1x(sprite1_x_out), .player_1y(sprite1_y_out),
                .player_2x(sprite2_x_out), .player_2y(sprite2_y_out),
                .pixel_index(pixel_index), .random_5bit_val(random5bitValue1),
                .bullet_x(bullet_x1), .bullet_y(bullet_y1),
                .bullet_en(bullet_en1),
                .oled_colour(bullet_col_1),.hit_player(bullethit2),.clk20hz(CLK_20Hz));
    wire bullethit1;
    wire [15:0] bullet_col_2;
    wire [6:0] bullet_x2; wire [6:0] bullet_y2;
    wire bullet_en2;
    bullet bu2(.clk(clk),.attack_state(player2ComboMove[1:0]),
                .mirrored(sprite1_facing_right),
                .player_1x(sprite2_x_out), .player_1y(sprite2_y_out),
                .player_2x(sprite1_x_out), .player_2y(sprite1_y_out),
                .pixel_index(pixel_index), .random_5bit_val(random5bitValue2),
                .bullet_x(bullet_x2), .bullet_y(bullet_y2),
                .bullet_en(bullet_en2),
                .oled_colour(bullet_col_2),.hit_player(bullethit1),.clk20hz(CLK_20Hz));                


    // Oled colour mux -------------------------------------------
    parameter COLOUR_BLACK = 16'h0000;    
        always@(pixel_index)
        begin
            if(menu_col != COLOUR_BLACK)
                oled_colour = menu_col;
            else if(status_bar_col != COLOUR_BLACK)
                oled_colour = status_bar_col;
            else if(bullet_col_1 != COLOUR_BLACK)
                oled_colour = bullet_col_1;
            else if(bullet_col_2 != COLOUR_BLACK)
                    oled_colour = bullet_col_2;                
            else if(sprite_2_col != COLOUR_BLACK)
                oled_colour = sprite_2_col;
            else if(sprite_1_col != COLOUR_BLACK)
                oled_colour = sprite_1_col;           
            else
                oled_colour = background_color;
                //oled_colour = COLOUR_BLACK;
        end
   //------------------------------------------------  

            
    //Insantiate Imported Modules -----------------------
    Oled_Display myoled(
        .clk(CLK_6MHz25), 
        .reset(0),
        .frame_begin(frame_begin),
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index),
        .pixel_data(oled_colour),
        .cs(master_cs),
        .sdin(master_sdin),
        .sclk(master_sclk),
        .d_cn(master_d_cn),
        .resn(master_resn),
        .vccen(master_vccen),
        .pmoden(master_pmoden));
        
        always @ (posedge clk) begin
//            oled_clock <= sw[1] ? CLK_6MHz25 : slave_CLK_6MHz25;
            JC[0] <= sw[1] ? master_cs : slave_cs;
            JC[1] <= sw[1] ? master_sdin : slave_sdin;
            JC[3] <= sw[1] ? master_sclk : slave_sclk;
            JC[4] <= sw[1] ? master_d_cn : slave_d_cn;
            JC[5] <= sw[1] ? master_resn : slave_resn;
            JC[6] <= sw[1] ? master_vccen : slave_vccen;
            JC[7] <= sw[1] ? master_pmoden : slave_pmoden;
        end

endmodule