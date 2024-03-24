module rgb_to_hsv(
    input [15:0] rgb,
    output reg [7:0] h, //h ranges from 0 to 360
    output reg [7:0] s, //out of 255
    output reg [7:0] v
);
    reg [7:0] r_norm;
    reg [7:0] g_norm; 
    reg [7:0] b_norm;

    reg [7:0] maxc;
    reg [7:0] minc;
    

    always @(rgb)
    begin
        //Normalise all to 255
        r_norm = rgb[15:11] * 255 / 31;
        g_norm = rgb[10:5]  * 255 / 63;
        b_norm = rgb[4:0]   * 255 / 31;
        
        //maxc
        if(r_norm >= g_norm && r_norm >= b_norm)    
            maxc = r_norm;
        else if(g_norm >= r_norm && g_norm >= b_norm)
            maxc = g_norm;
        else
            maxc = b_norm;

        //minc
        if(r_norm <= g_norm && r_norm <= b_norm)    
            minc = r_norm;
        else if(g_norm <= r_norm && g_norm <= b_norm)
            minc = g_norm;
        else
            minc = b_norm;

    
        v = maxc; //0 to 25    
        if(v == 0)
            begin
            h = 0;
            s = 0;
            end
        else
            s = 255 * (maxc - minc) / v;
            if(s==0)
                h = 0;
            else
                begin
    
                if(r_norm == maxc)
                    h = 0 + 43   * (g_norm - b_norm) / (maxc - minc);
                else if(g_norm == maxc)
                    h = 85 + 43  * (b_norm - r_norm) / (maxc - minc);
                else
                    h = 171 + 43 * (r_norm - g_norm) / (maxc - minc);
    
                end   
    end

endmodule