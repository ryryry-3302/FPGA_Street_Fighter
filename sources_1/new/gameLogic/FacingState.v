module FacingState (
    input [6:0] sprite1_x,
    input [6:0] sprite1_y,
    input [6:0] sprite2_x,
    input [6:0] sprite2_y,
    output reg sprite1_facing_right =1

);



    always @(*) begin
        if (sprite1_x > sprite2_x) begin
            sprite1_facing_right = 0;

        end
        else begin
            sprite1_facing_right = 1;

        end
    end

endmodule