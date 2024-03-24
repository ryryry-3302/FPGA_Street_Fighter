module hsv_to_rgb(
    input [8:0] h,
    input [7:0] s,
    input [7:0] v,
    
    output [15:0] rgb 
);

    reg [7:0] new_hue;

    reg [7:0] chroma;
    reg [7:0] hue_sector;
    reg [7:0] remainder;

    reg [7:0] delta;
    reg [7:0] m;
    
    //255
    reg [7:0] r;
    reg [7:0] g;
    reg [7:0] b;

    always @(*)
    begin
        new_hue = h*255/360;  

        chroma = v*s /255;
        hue_sector = new_hue/43;
        remainder = new_hue%43 * 6;     

        delta = v-chroma;
        m = v - ((remainder * chroma) / 255);        

        case(hue_sector)
        0: begin r = v;         g = m + delta; b = delta; end
        1: begin r = m;         g = v;         b = delta; end
        2: begin r = delta;     g = v;         b = m + delta; end
        3: begin r = delta;     g = m;         b = v; end
        4: begin r = m + delta; g = delta;     b = v; end
        // hue_sector == 5 
        default: begin r = v; g = delta; b = m; end
        endcase
    end

    wire [4:0] new_r;
    assign new_r = r * 31 / 255;
    wire [5:0] new_g;
    assign new_g = g * 63 / 255;
    wire [4:0] new_b;
    assign new_b = b * 31 / 255;

    assign rgb = {new_r,new_g,new_b};        

endmodule