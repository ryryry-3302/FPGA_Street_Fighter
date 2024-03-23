`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2024 20:05:19
// Design Name: 
// Module Name: gameStateController
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GameStateController (
    input clk,
    input reset,
    input user_input,
    // Additional inputs for other events/triggers
    input character_selection_done,


    output reg [3:0] game_state,
    // Additional outputs for control signals
);

// Define game state parameters
parameter MAIN_MENU = 4'b0000;
parameter CHARACTER_SELECTION = 4'b0001;
parameter FIGHT_STATE = 4'b0010;
parameter END_STATE = 4'b0011;

// Define state transition conditions
always @(posedge clk or posedge reset) begin
    if (reset) begin
        game_state <= MAIN_MENU; // Initialize to Main Menu state
    end else begin
        case (game_state)
            MAIN_MENU:
                if (user_input) begin
                    // Transition to Character Selection state upon user input
                    game_state <= CHARACTER_SELECTION;
                end
            CHARACTER_SELECTION:
                // Check for completion of character selection or other triggers
                // If completed, transition to Fight State
                if (character_selection_done) begin
                    game_state <= FIGHT_STATE;
                end
            FIGHT_STATE:
                // Handle transitions to End State based on game conditions
                if (game_over) begin
                    game_state <= END_STATE;
                end
            END_STATE:
                // Handle any end state conditions or transitions
                
            default: // Add a default case to handle unexpected game states
                game_state <= MAIN_MENU;
        endcase
    end
end

// Additional logic for generating control signals based on game state
// Example:
assign main_menu_to_character_selection = (game_state == MAIN_MENU && user_input);
// Define other control signals as needed

endmodule

