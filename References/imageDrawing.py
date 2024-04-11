# Scales image down to desired dimension
# Convert scaled down image to pixel array
# Write the picture as a verilog module to a .txt file 
# Adapted from https://github.com/BenedictChannn/EE2026-Project/tree/main

import numpy as np
from PIL import Image

# For PNG, sets color to (0,0,0) for transparent pixel
# Every other color +1 (Cap at 255)

# MODIFY filename and size. Should be in images directory.
filename = "Background.png"
size = (96,64)
REMOVE_WHITE = False 


file = open("data/" + filename.split(".")[0] + ".txt", "w")
img = Image.open("images/" + filename)
print("Original size: ", end="")
print(img.size)

#Scale image and save it
img.thumbnail(size, Image.LANCZOS)
img.save('images/small/small_' + filename)
arr = np.array(img)
print(np.shape(arr))

count = 0
file.write("module " + filename.split(".")[0] + "(\n")
file.write("    input [12:0] pixel_index, \n")
file.write("    output reg [15:0] oled_colour \n")
file.write("); \n\n")

#Utility for showing the colours that were ploted
dict_colours = {}
def add_colour(col):
    if col in dict_colours:
        dict_colours[col] += 1
    else:
        dict_colours[col] = 1

def print_sorted_dict(dict):
    print(filename + " >> DONE")
    print("Printing the Top 5 Colours in rgb form")
    if(REMOVE_WHITE):
        print("All white colours (r,g,b = 255,255,255) have been converted to black (0,0,0)")
    res = list(dict.items())
    res.sort(key = lambda x: x[1], reverse = True)
    print(res[:5])

def check_white(r,g,b):
    return (r==31) and (g==63) and (b==31)

file.write("always@(pixel_index) \n")
file.write("begin\n")
file.write("\tcase(pixel_index)\n")


for i in range(len(arr)):
    for j in range(len(arr[i])):
        if len(arr[i][j]) == 4:
            r, g, b, a = arr[i][j]            
            if (a < 200 and REMOVE_WHITE):
                #file.write("16'b00000_000000_00000;\n")
                add_colour((0,0,0))
            else:
                new_r = (r//8)+1
                new_g = (g//4)+1
                new_b = (b//8)+1

                new_r = 31 if (r//8)+1 > 31 else (r//8)+1 
                new_g = 63 if (g//4)+1 > 63 else (g//4)+1
                new_b = 31 if (b//8)+1 > 31 else (b//8)+1

                

                if(check_white(new_r,new_g,new_b) and REMOVE_WHITE):
                    add_colour((0,0,0))
                else:
                    add_colour((r,g,b))
                    file.write("\t\t" + str(count)+": oled_colour = ")
                    file.write("16'b" + '{0:05b}'.format(new_r) + "_" + '{0:06b}'.format(new_g) + "_" + '{0:05b}'.format(new_b) + "; \n")
                
        elif len(arr[i][j]) == 3:
            r, g, b = arr[i][j]

            new_r = (r//8)+1
            new_g = (g//4)+1
            new_b = (b//8)+1

            new_r = 31 if (r//8)+1 > 31 else (r//8)+1 
            new_g = 63 if (g//4)+1 > 63 else (g//4)+1
            new_b = 31 if (b//8)+1 > 31 else (b//8)+1

            if(check_white(r,g,b) and REMOVE_WHITE):
                file.write("16'b00000_000000_00000;\n")
                add_colour((0,0,0))
            else:
                add_colour((r,g,b))
                file.write("\t\t" + str(count)+": oled_colour = ")
                file.write("16'b" + '{0:05b}'.format(new_r) + "_" + '{0:06b}'.format(new_g) + "_" + '{0:05b}'.format(new_b) + "; \n")
            
        count += 1
file.write("\t\tdefault: oled_colour = 16'b00000_000000_00000; \n")
file.write("\tendcase\n")
file.write("end\n\n")
file.write("endmodule")
file.close()

print_sorted_dict(dict_colours)

