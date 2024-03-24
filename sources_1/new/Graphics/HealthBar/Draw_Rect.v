
module Draw_Rect(
    input [12:0] pixel_index,
    input [7:0] X_coord_start,
    input [7:0] Y_coord_start,
    input [7:0] length,
    input [7:0] height,
    output draw
    );

    wire [7:0] curr_X;
    wire [7:0] curr_Y;
    
    indexToXY curr_coord(.pixel_index(pixel_index),
                         .X_coord(curr_X),
                         .Y_coord(curr_Y));

    assign draw = ( (curr_X >= X_coord_start) && (curr_X <= X_coord_start + length)
                 && (curr_Y >= Y_coord_start) && (curr_Y <= Y_coord_start + height)  );     

endmodule