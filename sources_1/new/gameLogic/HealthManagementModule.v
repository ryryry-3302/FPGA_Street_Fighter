//, input damageTo1, input damageTo2, 

module HealthManagement (input clk, input reset,
                         input player_1_hitrangewire, 
                         input [1:0] attack_statex, input [1:0] attack_statey,
                         output reg [8:0] health_1 = 0, output reg [8:0] health_2 = 0, 
                         output reg [2:0] state);
    
//state 00 fight
//state 01 player 1 wins
//state 02 player 2 wins
      
    

  always @(posedge clk)begin
       if (reset)begin
          health_2 <= 400;
          health_1 <= 400;
          state <= 2'b00;
       end
       
       if (player_1_hitrangewire && attack_statex == 2'b11 && health_2>0 && state == 2'b00)begin
                     health_2 <= (health_2 > 20)? health_2 - 20:0;
              end
       else if (player_1_hitrangewire && attack_statex == 2'b10 && health_2>0 && state == 2'b00)begin
                            health_2 <= health_2 > 10? health_2 -10: 0;
                     end
       
       else if (player_1_hitrangewire && attack_statex == 2'b01 && health_2>0 && state == 2'b00)begin
              health_2 <= health_2 -4;
       end
       
       
       
       
       if (player_1_hitrangewire && attack_statey && health_1>0)begin
             health_1 <= health_1 -1;
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

