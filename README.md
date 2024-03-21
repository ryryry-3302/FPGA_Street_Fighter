# EE2026 Final Project

Development of a FPGA Street Fighter Game

## Configuration
cd into the MODS folder and clone this repo.
```
cd MODS
git clone https://github.com/ryryry-3302/ee2026.git
```
Delete the original `MODS.SRCS` file and rename the `ee2026` file to `MODS.SRCS`, cd into this to access the repo.
```
cd MODS.SRCS /// inside ull find the sources/ constraints and subtasks
```
The files in this repository should have folders for `MODS.SRCS`, importantly, 
1. `constrs_1` which contains the constaints file
2. `sources_1` which contains all the relevant design source files.
3. `Subtasks` which is meant for personal backup and documentation

## Troubleshooting
There might be some issues where vivado is unable to detect a certain file as a design source. The simplest solution in vivado is to go to `File > Add Sources > Add Files` and select all files in the folder

## REMINDERS
Remember to pull from main before pushing to prevent any merge conflicts.

## .gitignore
- Note that for a free account, the maximum repo size is **50MB**. Hence, the .gitignore folder specifically ignores files that take up high storage. `sources_1\ip` was found to take up 61.6MB by default. Not sure what its for. It also changes each time bitstream is generated so it is added to gitignore.