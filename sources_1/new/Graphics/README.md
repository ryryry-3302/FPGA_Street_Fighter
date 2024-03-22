# Graphics Documentation
Current sprite used is Guile.

## Documentation

### sprite_control
```verilog
module sprite_control (
    input clk,
    input [6:0] x, //2^7 = 128 > 96 (x_max)
    input [6:0] y, //2^7 = 128 > 63 (y_max)
    input in_air, is_moving,

    input [12:0] pixel_index,
    output reg [15:0] oled_colour
);
```
`input clk`: 100MHz Clock

`input [6:0] x, input [6:0] y`: coordindate of the sprite, where 0,0 is the top left hand of the screen

### background_control
```verilog
module backgroud_control(
    input clk,
    input [12:0] pixel_index,
    output [15:0] oled_colour
);
```
`input clk`: 100MHz Clock, might be using it

## Example Usage
Copy and paste into `Top_Student.v` to show the background and the sprite on the background. 
```verilog
wire [15:0] sprite_col;
sprite_control sp_ctr(.clk(clk),
                        .x(20),.y(20),
                        .in_air(0),
                        .is_moving(1),
                        .pixel_index(pixel_index),
                        .oled_colour(sprite_col));

wire [15:0] background_color;
backgroud_control bck_ctr(.clk(clk),
                            .pixel_index(pixel_index),
                            .oled_colour(background_color));

always@(pixel_index)
begin
    if((sprite_col == 16'h0000) || (sprite_col == 16'hFFFF) )
        //If the sprite is white or black, just use the background colours
        oled_colour = background_color;
    else
        oled_colour = sprite_col;
end
```

## References
- Guile Sprite: https://www.spriters-resource.com/arcade/streetfighter2/sheet/129870/
- Current Background: https://www.youtube.com/playlist?list=PL8_5sYhn3XymSIUz3oio50XvenNZkCeCd