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
    input btnC, btnL, btnR, btnU, btnD,
    output [7:0] JC
);

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