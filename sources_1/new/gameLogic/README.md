

## Current Features Implemented
- Collision detection
- Hit range detection
- Gravity
- Movement
- Health management
- facing states

## Documentation

### status_bar_update
Updates the top KO/Status bar based on the current health of both sprites. Animation to show health dropping towards the current value has been implemented.
```verilog
module CollisionDetection (
    input clk,
    input [6:0]player_1x,
    input [6:0]player_1y,
    input [6:0]player_2x,
    input [6:0]player_2y,
    input reset,
    output reg player_1_collision =0,
    output reg player_1_hitrange =0,
    output reg player_2_collision =0
);
```
`output reg player_1_collision`: High when players centres are within 15 pixels
`output reg player_1_hitrange` : High when players are within 20 pixels

### sprite_control
For showing sprite attack and moving animations.
```verilog
module HealthManagement (input clk,input reset, input player_1_hitrangewire, input [1:0] attack_statex,
input [1:0] attack_statey, output reg [8:0]health_1=200, output reg [8:0] health_2 =200, output reg [2:0]state);
```
state used by gamestate module to change between fight to end screen
//state 00 fight
//state 01 player 1 wins
//state 02 player 2 wins
attack_statex is mapped to comboMove (x = player 1)




