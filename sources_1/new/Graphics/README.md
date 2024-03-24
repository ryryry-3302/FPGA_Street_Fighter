# Graphics Documentation
Current sprite used is Guile.

- [Current Features](#current-features-implemented) 
- [Example Usage](#example-usage)
- [References](#references)

### Modules Within the Folder
These modules should be used in `Top_Student.v`

- [status_bar_update](#status_bar_update)
- [sprite_control](#sprite_control)
- [background_control](#background_control)

[CustomClock](#customclock-from-previous-task) is a global module for generating clocks, and its documentation here is just as a reminder for usage for modules.

## Current Features Implemented
- Sprite moving, still and basic attack animation.
- Coordinate translation and mirroring of the sprite.
- Static Background image.
- Option to generate 2 sprites with one in original colour and one reddish.
- Health bar (KO bar) with dropping health animation.

## Documentation

### status_bar_update
Updates the top KO/Status bar based on the current health of both sprites. Animation to show health dropping towards the current value has been implemented.
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
    input [6:0] x, //2^7 = 128 > 96 (x_max)
    input [6:0] y, //2^7 = 128 > 63 (y_max)
    input in_air, is_moving,
    input [1:0] character_state,
    input [12:0] pixel_index,
    output reg [15:0] oled_colour
);
```
`input clk`: 100MHz Clock

` input modify_col` : Write 1 to change the sprite colour to redish. This was done by bit shifting the green component.

`input mirror` : Write 1 to mirror the sprite

`input [6:0] x, input [6:0] y`: coordindate of the sprite, where 0,0 is the top left hand of the screen


| `input [1:0] character_state`  | Description             |
|--------------------------------|-------------------------|
| 2'b00                          | Not attacking  **DONE** |
| 2'b01                          | Normal attack  **DONE** |
| 2'b10                          | Special attack          |
| 2'b11                          | Super special attack    |

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