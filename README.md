# EE2026 Final Project

Development of a FPGA Street Fighter Game

**Remember to pull from main before pushing to prevent any merge conflicts.**
- [Expected Behavior](#expected-behaviour)
    - [Controls](#controls)
    - [Switch Mappings](#switch-mappings)
    - [LED Mappings](#led-mapping)
    - [Menu](#menu)
- [Top Module Documentation](#top-module-documentation)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [.gitignore](#gitignore)

## Expected Behaviour

### Controls
| Button Combination       | Action         |
|--------------------------|----------------|
| btnC                     | Attack         |
| btnR                     | Move right     |
| btnL                     | Move Left      |
| btnU                     | Jump Up        |
| btnL > btnD > btnR > btnC | Special Combo |


### Switch mappings
- sw[0] reset players positions to start and reset hp to full
- sw[7] player 2 receives AI inputs
- sw[8] player 1 receives AI inputs

### LED mapping
- led[15] Players are colliding and cannot move past each other
- led[14] players within attack range
- led[2:1] = winner; //state 00 fight //state 01 player 1 wins //state 02 player 2 wins
- led[7:6] = player 2 comboMove  //0 means not attacking, 1 means nornmal attack, 2 means special attack, 3 means super attack
- led[9:8] = player 1 comboMove 

### Menu

The menu takes input from the game state to display results on the 7 segment oled and oled display

| Game State             | 7 Segment Display | Screen Rectangle Color |
|------------------------|-------------------|------------------------|
| Game Beginning         | "0000"            | White                  |
| Fight in progress      | "----"            | -                      |
| Player 1 wins          | "WIN "            | Green                  |
| Player 2 wins          | "LOSE"            | Red                    |

To reset the game **AFTER** a player has won, or at the beginning of the game, hold down **btnC** for 2s, and the game should reset.

If you want to force reset the game on your own, leave sw[0] on for at least 2s to reset the game even if the fight is still in progress.


## Top Module Documentation
```verilog
module menu(input clk,
            input [12:0] pixel_index,
            input [1:0] game_state,
            output reg [6:0] seg,
            output reg [3:0] an,
            output reg [15:0] oled_colour);
```

Display the menu based on the game state. A combination of the OLED and the 7 segment display are used. Refer to [menu](#menu)

`clk` 100 Mhz Basys Clock

| `input [1:0] game_state` | Description              |
|--------------------------|--------------------------|
| 2'b00                    | Fight in Progress        |
| 2'b01                    | P1 Win                   |
| 2'b10                    | P2 Win                   |
| 2'b11                    | **Not implemented YET**  |

` [12:0] pixel_index`, ` [15:0] oled_colour` typical OLED input output

`[6:0] seg`, `[3:0] ann` 7 segement display outputs



## Configuration
cd into the MODS folder and clone this repo.
```
cd MODS
git clone https://github.com/ryryry-3302/ee2026_final_project.git
```
Delete the original `MODS.SRCS` file and rename the `ee2026_final_project` file to `MODS.SRCS`, cd into this to access the repo.
```
cd MODS.SRCS /// inside ull find the sources/ constraints and subtasks
```
The files in this repository should have folders for `MODS.SRCS`, importantly, 
1. `constrs_1` which contains the constaints file
2. `sources_1` which contains all the relevant design source files.

## Troubleshooting
There might be some issues where vivado is unable to detect a certain file as a design source. The simplest solution in vivado is to go to `File > Add Sources > Add Files` and select all files in the folder

## .gitignore
- `sources_1\ip` was found to take up 61.6MB by default. Not sure what its for. It also changes each time bitstream is generated so it is added to gitignore. It should be initialised by the host computer when the vivado project is opened for the first time.
