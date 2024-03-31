module hsv_to_rgb(
    input [7:0] h,
    output [15:0] rgb 
);
    
    parameter s = 255; //set as brightest values
    parameter v = 255;
    
    reg [7:0] region;
    reg [7:0] remainder;

    reg [7:0] P;
    reg [7:0] Q;
    reg [7:0] T;

    reg [7:0] r;
    reg [7:0] g;
    reg [7:0] b;

    always@(h)
    begin
        region = h/43;
        remainder = (h - (region * 43)) * 6;

        P = (v * (255 - s)) >> 8;
        Q = (v * (255 - ((s * remainder) >> 8))) >> 8;
        T = (v * (255 - ((s * (255 - remainder)) >> 8))) >> 8;

        case(region)
        0: begin r = v; g = T; b = P; end
        1: begin r = Q; g = v; b = P; end
        2: begin r = P; g = v; b = T; end
        3: begin r = P; g = Q; b = v; end
        4: begin r = T; g = P; b = v; end
        5: begin r = v; g = P; b = Q; end
        endcase

    end

    wire [4:0] bit_r; assign bit_r = r * 31/255;
    wire [5:0] bit_g; assign bit_g = g * 63/255;
    wire [4:0] bit_b; assign bit_b = b * 31/255;

    assign rgb = {bit_r,bit_g,bit_b};

endmodule