module backgroud_control(
    input clk,
    input [12:0] pixel_index,
    output [15:0] oled_colour
);

    Background bg(pixel_index, oled_colour); 


endmodule