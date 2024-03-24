module rgb_to_hsv(
    input [15:0] rgb,
    output reg [8:0] h, //h ranges from 0 to 360
    output reg [7:0] s, //out of 255
    output reg [7:0] v
);
    //0>1
    reg [8:0] r_norm;
    reg [8:0] g_norm; 
    reg [8:0] b_norm;

    reg [8:0] maxc;
    reg [8:0] minc;
    reg [8:0] delta;

    reg [8:0] rc;
    reg [8:0] gc;
    reg [8:0] bc;

    always @(rgb)
    begin
        //Normalise all to 255
        r_norm = rgb[15:11] * 255 / 31;
        g_norm = rgb[10:5] * 255 / 63;
        b_norm = rgb[4:0] *255 / 31;
        
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

        delta = maxc - minc;
    
        v = maxc; //0 to 25
    
        if(delta == 0)
            begin
            h = 0;
            s = 0;
            end
        else
            begin
            rc = (maxc-r_norm);
            gc = (maxc-g_norm);
            bc = (maxc-b_norm);

            if(r_norm == maxc)
                h = 60*(bc-gc)/delta;
            else if(g_norm == maxc)
                h = 60*(rc-bc)/delta + 120;
            else
                h = 60*(rc-gc)/delta + 240;

            s = (delta / maxc * 255);
            end   
    end

endmodule