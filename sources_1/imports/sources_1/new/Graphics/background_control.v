module backgroud_control(
    input clk,
    input [12:0] pixel_index,
    output [15:0] oled_colour
);

    wire [15:0] background_colour_orig;
    Background bg(pixel_index, background_colour_orig);
    
    assign oled_colour = background_colour_orig; 

/*
    wire CLOCK_BG;                    
    CustomClock clk5hz(.CLOCK_IN(clk),
                        .COUNT_STOP(32'd10_000_000 - 1),
                        .CLOCK_OUT(CLOCK_BG));

    wire [8:0] h;
    wire [7:0] s;
    wire [7:0] v;
    rgb_to_hsv rth(.rgb(background_colour_orig),.h(h),.s(s),.v(v));
    
    reg [8:0] adder = 0;
    //wire [15:0] new_background_colour;
    hsv_to_rgb htr(.rgb(oled_colour),.h(h+adder),.s(s),.v(v));
    
    always @(posedge CLOCK_BG)
    begin
        adder = adder + 1;
    end
*/    



endmodule