# Graphics Documentation
Current sprite used is Guile.

- [Current Features](#current-features-implemented) 
- [Example Usage](#example-usage)
- [References](#references)

### Modules Within the Folder
These modules should be used in `Top_Student.v`

- [bullet](#bullet)
- [status_bar_update](#status_bar_update)
- [sprite_control](#sprite_control)
- [background_control](#background_control)

### Other Utility/Useful Modules
- [RGB-HSV](#rgb-to-hsv-conversions)

[CustomClock](#customclock-from-previous-task) is a global module for generating clocks, and its documentation here is just as a reminder for usage for modules.

## Current Features Implemented
- Sprite moving, still, basic attack and getting hit animation.
- Coordinate translation and mirroring of the sprite.
- Background image that changes its hue over time.
- Option to generate 2 sprites with one in original colour and one reddish.
- Health bar (KO bar) with dropping health animation. Reset health bar available.

## Documentation

### bullet
Shoots out a bullet each time the special combo is done.

```verilog
module bullet(
    input clk,
    input [1:0] attack_state,
    input mirrored,
    input [6:0] player_1x,
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
```
`player_1` refers to the player throwing the bullet while `player_2` is the enemy that the bullet will head towards. `Mirrored` is used to determine the direction of the bullet.

`random_5bit_val` is taken from the `LSFSRrandom.v`. It is used to randommize the colour of the bullet coming out.

**CURRENT PROBLEM** for some reason when the sprite jumps, the y value of the bullet will change which is not ideal.


### status_bar_update
Updates the top KO/Status bar based on the current health of both sprites. Animation to show health dropping towards the current value has been implemented. To reset the health bar, write the desired heatlh value to `curr_health_l` and/or `curr_health_r`.
```verilog
module status_bar_update(
    input clk,
    input [4:0] curr_health_l,
    input [4:0] curr_health_r,
    input [12:0] pixel_index,
    output reg [15:0] oled_colour,
    output [4:0] final_health_l,
    output [4:0] final_health_r 
);  
```
`input clk`: 100MHz Clock

`input [4:0] curr_health_l, input [4:0] curr_health_r` : The current health of each sprite

`output [4:0] final_health_l, output [4:0] final_health_r` : Outputs of the final health. Animation of the status bar dropping is implemented so it will be good to check that the animation has finished by checking that the final health parameter drops to zero before finishing the game.


`input [12:0] pixel_index` and `output reg [15:0] oled_colour` are typical oled input and outputs.

### sprite_control
For showing sprite attack and moving animations.
```verilog
module sprite_control (
    input clk,
    input modify_col,input mirror,
    input [6:0] x, 
    input [6:0] y, 
    input in_air,
    input [1:0] move_state,
    input [2:0] character_state,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour
);  
```
`input clk`: 100MHz Clock

` input modify_col` : Write 1 to change the sprite colour to redish. This was done by bit shifting the green component.

`input mirror` : Write 1 to mirror the sprite

`input [6:0] x, input [6:0] y`: coordindate of the sprite, where 0,0 is the top left hand of the screen



| `input [1:0] move_state` | Description    |
|--------------------------|----------------|
| 2'b00                    | Not Moving     |
| 2'b01                    | Moving Right   |
| 2'b10                    | Moving Left    |

Note that `move_state` animations will only show if `character_state` is set to `0`.

| `input [2:0] character_state`   | Description             | Done  | 
|-------------------------------- |-------------------------|-------| 
| 3'b000                          | Not attacking           |   Y   | 
| 3'b001                          | Normal attack           |   Y   | 
| 3'b010                          | Special attack          |   Y   | 
| 3'b011                          | Super special attack    |   Y   | 
| 3'b100                          | Got hit/injured         |   Y   | 

NOTE: For attacks and getting injured, `character_state` is read. If it changes, the animation runs to the end, and does not reset unless `character_state` changes. This is to ensure that animations are run for only one hit.


`input [12:0] pixel_index` and `output reg [15:0] oled_colour` are typical oled input and outputs.


### background_control
```verilog
module backgroud_control(
    input clk,
    input [12:0] pixel_index,
    output [15:0] oled_colour
);
```
`input clk`: 100MHz Clock, might be using it to change the background as the fight progresses.

## Example Usage
Copy and paste into `Top_Student.v` to show the background and 2 sprites. Press BtnC for the left sprite to show its normal attack and press BtnR for the right sprite to show its normal attack. The right sprite is reddish in colour. The right status bar will move slowly towards the centre.
```verilog
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
                            .x(20), .y(ground_height),
                            .in_air(0), .is_moving(1),
                            .character_state({0,btnC} ),
                            .pixel_index(pixel_index),
                            .oled_colour(sprite_1_col));
                            
    wire [15:0] sprite_2_col;
    sprite_control sp2_ctr(.clk(clk),
                            .modify_col(1), .mirror(1),
                            .x(70), .y(ground_height),
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
```

### RGB to HSV conversions
Code was ported from Cpp to do RGB to HSV conversion and vice versa using integer math. This is currently being used in `background_control.v` to change the colour of the background as the fight progresses.

```verilog
module hsv_to_rgb(
    input [7:0] h,
    input [7:0] s,
    input [7:0] v,
    output [15:0] rgb 
);

module rgb_to_hsv(
    input [15:0] rgb,
    output reg [7:0] h,
    output reg [7:0] s,
    output reg [7:0] v
);
```
Where hsv values range from 0 to 255, and the rgb value is the 16 bit oled colour value.



### CustomClock (From previous task)
Create a clock that runs at frequency Fd. COUNT_STOP or CS can be calculated by 
$CS=\frac{100*10^6}{2*Fd} - 1$

```verilog
module CustomClock(
    input CLOCK_IN,
    input [31:0] COUNT_STOP,
    output reg CLOCK_OUT = 0);
```

## References
- Guile Sprite: https://www.spriters-resource.com/arcade/streetfighter2/sheet/129870/
- Current Background: https://www.youtube.com/playlist?list=PL8_5sYhn3XymSIUz3oio50XvenNZkCeCd
- RGB to HSV and HSV to RGB conversion https://github.com/monkbroc/particle-hsv/blob/master/src/hsv.cpp 