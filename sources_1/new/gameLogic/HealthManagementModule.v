//, input damageTo1, input damageTo2, 

module HealthManagement (input clk, input reset,
                         input player_1_hitrangewire, 
                         input [1:0] attack_statex, input [1:0] attack_statey,
                         output reg [8:0] health_1 = 0, output reg [8:0] health_2 = 0, 
                         output reg [2:0] state,output reg hit1 = 0, output reg hit2 = 0,input bullethit1, input bullethit2);
    
//state 00 fight
//state 01 player 1 wins
//state 02 player 2 wins
   


  //add invincibility below`
    

  always @(posedge clk)begin
       if (reset)begin
          health_2 <= 400;
          health_1 <= 400;
          state <= 2'b00;
          
       end
       
       if (bullethit2 && health_2>0 && state == 2'b00)begin
                    
         health_2 <= (health_2 > 15)? health_2 - 15:0;
                    hit2 <= 1;
              end
       else if (player_1_hitrangewire && attack_statex == 2'b10 && health_2>0 && state == 2'b00)begin
                            health_2 <= health_2 >10? health_2 -10: 0;
                          //  immunity_frames2 <= 1;
                                              hit2 <= 1;

                     end
       
       else if (  player_1_hitrangewire && attack_statex == 2'b01 && health_2>0 && state == 2'b00)begin
              health_2 <= health_2>5?health_2 -5:0;
              //immunity_frames2 <= 1;
                                  hit2 <= 1;

       end
       else begin
                                hit2 <= 0;

       end
        
       
       
       
       if (bullethit1 && health_1>0 && state == 2'b00)begin
         health_1 <= (health_1 > 15)? health_1 - 15:0;
                                         hit1 <= 1;

                  //   immunity_frames1 <= 1;
              end
       else if (player_1_hitrangewire && attack_statey == 2'b10 && health_1>0 && state == 2'b00)begin
                            health_1 <= health_1 > 10? health_1 -10: 0;
                                                hit1 <= 1;

                            //immunity_frames1 <= 1;
                     end

       else if (player_1_hitrangewire && attack_statey == 2'b01 && health_1>0 && state == 2'b00)begin
              health_1 <= health_1 > 5? health_1 -5:0;
                                  hit1 <= 1;

           //   immunity_frames1 <= 1;
     end
             else begin
                        hit1 <= 0;

       end
       
       
       if(health_1==0 && health_2==0) //Game just started
          state <= 2'b11; 
       else if(health_2 == 0)
          state <= 2'b01;
       else if(health_1 == 0)
          state <= 2'b10;
       else 
          state <= 2'b00;
       
                       
   end
  


endmodule

