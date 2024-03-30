module Gui_Sp1(
    input [12:0] pixel_index, 
    output reg [15:0] oled_colour 
); 

always@(pixel_index) 
begin
	case(pixel_index)
		1875: oled_colour = 16'b11110_110010_01011; 
		1876: oled_colour = 16'b11101_110100_01010; 
		1877: oled_colour = 16'b11100_110001_01011; 
		1878: oled_colour = 16'b11101_110010_01011; 
		1968: oled_colour = 16'b11101_101010_01100; 
		1969: oled_colour = 16'b11110_110010_01011; 
		1970: oled_colour = 16'b11111_111001_00110; 
		1971: oled_colour = 16'b11101_110010_01010; 
		1972: oled_colour = 16'b11110_110101_01010; 
		1973: oled_colour = 16'b11111_111010_00101; 
		1974: oled_colour = 16'b11110_110011_01001; 
		2061: oled_colour = 16'b11011_100011_01101; 
		2062: oled_colour = 16'b10110_100011_01100; 
		2063: oled_colour = 16'b10000_100000_01010; 
		2064: oled_colour = 16'b10011_011110_01011; 
		2065: oled_colour = 16'b11101_101100_01110; 
		2066: oled_colour = 16'b11110_110100_01001; 
		2067: oled_colour = 16'b11101_110000_01001; 
		2068: oled_colour = 16'b11100_101011_01111; 
		2069: oled_colour = 16'b11111_111001_10000; 
		2156: oled_colour = 16'b11111_110010_10101; 
		2157: oled_colour = 16'b11110_110110_11000; 
		2158: oled_colour = 16'b10001_100100_01100; 
		2159: oled_colour = 16'b01010_011011_01000; 
		2160: oled_colour = 16'b11010_101001_10000; 
		2161: oled_colour = 16'b11101_101110_01111; 
		2162: oled_colour = 16'b11011_101001_01110; 
		2163: oled_colour = 16'b11011_100111_01110; 
		2164: oled_colour = 16'b11001_101100_10011; 
		2165: oled_colour = 16'b11010_101011_10010; 
		2250: oled_colour = 16'b11100_100100_01100; 
		2251: oled_colour = 16'b11001_011010_01000; 
		2252: oled_colour = 16'b11011_110100_11000; 
		2253: oled_colour = 16'b11111_111010_11010; 
		2254: oled_colour = 16'b11100_110011_10011; 
		2255: oled_colour = 16'b10101_110100_10011; 
		2256: oled_colour = 16'b11000_100111_01111; 
		2257: oled_colour = 16'b11101_110000_10011; 
		2258: oled_colour = 16'b10111_100001_01101; 
		2259: oled_colour = 16'b11011_100111_01111; 
		2260: oled_colour = 16'b11110_110011_10100; 
		2342: oled_colour = 16'b11111_110100_10100; 
		2343: oled_colour = 16'b11110_101110_10010; 
		2344: oled_colour = 16'b11101_101011_10000; 
		2345: oled_colour = 16'b11111_110011_10100; 
		2346: oled_colour = 16'b11111_111000_10111; 
		2347: oled_colour = 16'b11010_011110_01011; 
		2348: oled_colour = 16'b11010_101000_10001; 
		2349: oled_colour = 16'b11111_111010_11001; 
		2350: oled_colour = 16'b11101_110000_10100; 
		2351: oled_colour = 16'b10011_101100_10000; 
		2352: oled_colour = 16'b11000_100101_01110; 
		2353: oled_colour = 16'b11001_100101_01111; 
		2354: oled_colour = 16'b10111_100010_01101; 
		2355: oled_colour = 16'b10110_011110_01011; 
		2356: oled_colour = 16'b11011_101010_01111; 
		2437: oled_colour = 16'b11111_110100_10100; 
		2438: oled_colour = 16'b11110_110111_11000; 
		2439: oled_colour = 16'b11110_110110_10111; 
		2440: oled_colour = 16'b11100_101000_10000; 
		2441: oled_colour = 16'b11100_101010_10000; 
		2442: oled_colour = 16'b11111_110111_10111; 
		2443: oled_colour = 16'b11111_110010_10101; 
		2444: oled_colour = 16'b11100_100110_01110; 
		2445: oled_colour = 16'b11100_110000_10011; 
		2446: oled_colour = 16'b11101_101011_10001; 
		2447: oled_colour = 16'b11010_110101_10101; 
		2448: oled_colour = 16'b10110_110111_10011; 
		2449: oled_colour = 16'b11001_101000_01110; 
		2450: oled_colour = 16'b11000_100011_01110; 
		2451: oled_colour = 16'b10101_011111_01011; 
		2532: oled_colour = 16'b11011_100110_01110; 
		2533: oled_colour = 16'b11111_110010_10011; 
		2534: oled_colour = 16'b11110_110101_10110; 
		2535: oled_colour = 16'b11101_101000_01111; 
		2536: oled_colour = 16'b10110_011110_01011; 
		2537: oled_colour = 16'b10101_011101_01011; 
		2538: oled_colour = 16'b11010_100111_10000; 
		2539: oled_colour = 16'b10111_100011_01101; 
		2540: oled_colour = 16'b10001_010110_00110; 
		2541: oled_colour = 16'b10100_011000_01000; 
		2542: oled_colour = 16'b11101_101001_10000; 
		2543: oled_colour = 16'b10110_101110_10010; 
		2544: oled_colour = 16'b10000_110100_10010; 
		2545: oled_colour = 16'b10101_111001_10101; 
		2546: oled_colour = 16'b11010_101101_10010; 
		2547: oled_colour = 16'b10100_100011_01100; 
		2628: oled_colour = 16'b10011_011010_01001; 
		2629: oled_colour = 16'b11100_101000_01111; 
		2630: oled_colour = 16'b11101_101101_10001; 
		2631: oled_colour = 16'b10101_011011_01010; 
		2634: oled_colour = 16'b00110_010111_00011; 
		2635: oled_colour = 16'b00100_010100_00001; 
		2636: oled_colour = 16'b01000_010101_00010; 
		2637: oled_colour = 16'b10011_011101_01010; 
		2638: oled_colour = 16'b01101_011100_00111; 
		2639: oled_colour = 16'b01100_100001_01100; 
		2640: oled_colour = 16'b01111_101010_10000; 
		2641: oled_colour = 16'b10000_110000_10010; 
		2642: oled_colour = 16'b01111_101001_01111; 
		2643: oled_colour = 16'b01000_011011_00111; 
		2724: oled_colour = 16'b10101_011101_01010; 
		2725: oled_colour = 16'b11100_101011_10001; 
		2726: oled_colour = 16'b11100_101010_10000; 
		2727: oled_colour = 16'b11001_100001_01101; 
		2729: oled_colour = 16'b00110_010101_00010; 
		2730: oled_colour = 16'b00011_010110_00001; 
		2731: oled_colour = 16'b00010_010101_00001; 
		2732: oled_colour = 16'b00101_011000_00100; 
		2733: oled_colour = 16'b00111_011010_00110; 
		2734: oled_colour = 16'b00100_010111_00100; 
		2735: oled_colour = 16'b00111_011011_00110; 
		2736: oled_colour = 16'b01001_011100_01000; 
		2737: oled_colour = 16'b01000_011010_00111; 
		2820: oled_colour = 16'b11101_101100_10000; 
		2821: oled_colour = 16'b11100_101100_10000; 
		2822: oled_colour = 16'b11011_100111_01111; 
		2823: oled_colour = 16'b11100_100110_01111; 
		2824: oled_colour = 16'b01101_011010_00110; 
		2825: oled_colour = 16'b01010_010001_00010; 
		2826: oled_colour = 16'b01110_011000_00101; 
		2827: oled_colour = 16'b00111_010110_00011; 
		2828: oled_colour = 16'b00110_010111_00011; 
		2829: oled_colour = 16'b00111_011001_00100; 
		2830: oled_colour = 16'b01010_011011_00110; 
		2920: oled_colour = 16'b00111_011001_00110; 
		2921: oled_colour = 16'b10000_100001_01010; 
		2922: oled_colour = 16'b10011_011000_00111; 
		2923: oled_colour = 16'b10001_011011_01000; 
		2924: oled_colour = 16'b10000_010111_00101; 
		2925: oled_colour = 16'b10010_100000_01011; 
		2926: oled_colour = 16'b10110_101001_10000; 
		3016: oled_colour = 16'b01111_011001_01000; 
		3017: oled_colour = 16'b10100_101000_01110; 
		3018: oled_colour = 16'b10000_100001_01011; 
		3019: oled_colour = 16'b11100_110101_10110; 
		3020: oled_colour = 16'b11000_100110_01110; 
		3021: oled_colour = 16'b01101_011000_00101; 
		3022: oled_colour = 16'b01001_011001_00110; 
		3023: oled_colour = 16'b10101_100001_01100; 
		3024: oled_colour = 16'b01110_100110_01101; 
		3112: oled_colour = 16'b01110_100111_01100; 
		3113: oled_colour = 16'b10101_110001_10110; 
		3114: oled_colour = 16'b10000_101101_10000; 
		3115: oled_colour = 16'b11101_111110_11011; 
		3116: oled_colour = 16'b11010_110110_10110; 
		3117: oled_colour = 16'b01111_100010_01010; 
		3118: oled_colour = 16'b00111_010110_00100; 
		3119: oled_colour = 16'b10010_011100_01010; 
		3120: oled_colour = 16'b11000_110100_10100; 
		3121: oled_colour = 16'b11111_110111_11000; 
		3122: oled_colour = 16'b11110_110000_10100; 
		3123: oled_colour = 16'b11001_100010_01101; 
		3208: oled_colour = 16'b10001_101101_10001; 
		3209: oled_colour = 16'b11001_111001_11000; 
		3210: oled_colour = 16'b11011_110110_10111; 
		3211: oled_colour = 16'b11101_110100_10110; 
		3212: oled_colour = 16'b11111_111011_11011; 
		3213: oled_colour = 16'b11000_110100_10101; 
		3214: oled_colour = 16'b01001_010111_00101; 
		3215: oled_colour = 16'b01101_011110_01010; 
		3216: oled_colour = 16'b10111_110111_10110; 
		3217: oled_colour = 16'b11101_111011_10111; 
		3218: oled_colour = 16'b11101_110100_10010; 
		3219: oled_colour = 16'b11111_101101_10001; 
		3220: oled_colour = 16'b11111_110000_10010; 
		3221: oled_colour = 16'b10110_101000_01110; 
		3305: oled_colour = 16'b11111_111000_11001; 
		3306: oled_colour = 16'b11111_110101_10111; 
		3307: oled_colour = 16'b11101_101111_10100; 
		3308: oled_colour = 16'b11111_110011_10100; 
		3309: oled_colour = 16'b11100_111011_10111; 
		3310: oled_colour = 16'b01011_100011_01010; 
		3311: oled_colour = 16'b00111_011001_00101; 
		3312: oled_colour = 16'b10001_101011_10001; 
		3313: oled_colour = 16'b10100_110100_10100; 
		3314: oled_colour = 16'b11000_110001_10010; 
		3315: oled_colour = 16'b11000_110011_10010; 
		3316: oled_colour = 16'b10011_110000_10000; 
		3317: oled_colour = 16'b11001_111100_10101; 
		3318: oled_colour = 16'b10110_111001_10011; 
		3401: oled_colour = 16'b11011_110000_10100; 
		3402: oled_colour = 16'b11100_111111_11011; 
		3403: oled_colour = 16'b10100_110000_10011; 
		3404: oled_colour = 16'b11010_110010_10010; 
		3405: oled_colour = 16'b11111_111000_10111; 
		3406: oled_colour = 16'b10000_100111_01101; 
		3408: oled_colour = 16'b10100_100100_01110; 
		3409: oled_colour = 16'b01010_011110_01001; 
		3410: oled_colour = 16'b01001_011011_00111; 
		3411: oled_colour = 16'b01100_011111_01001; 
		3412: oled_colour = 16'b01111_101100_01111; 
		3413: oled_colour = 16'b11011_111011_10100; 
		3414: oled_colour = 16'b11001_110001_10001; 
		3498: oled_colour = 16'b01011_100011_01010; 
		3499: oled_colour = 16'b10100_110110_10100; 
		3500: oled_colour = 16'b11100_111101_11010; 
		3501: oled_colour = 16'b11111_111101_11110; 
		3502: oled_colour = 16'b10101_110001_10010; 
		3506: oled_colour = 16'b10011_100000_01010; 
		3507: oled_colour = 16'b11101_101101_10011; 
		3508: oled_colour = 16'b11100_111011_10110; 
		3509: oled_colour = 16'b11011_111101_10101; 
		3510: oled_colour = 16'b10000_101000_01110; 
		3592: oled_colour = 16'b10101_100010_01101; 
		3593: oled_colour = 16'b10101_011110_01010; 
		3594: oled_colour = 16'b01101_011001_00110; 
		3595: oled_colour = 16'b10000_101000_01110; 
		3596: oled_colour = 16'b11101_111010_11100; 
		3598: oled_colour = 16'b10101_110110_10100; 
		3601: oled_colour = 16'b01010_010111_00101; 
		3602: oled_colour = 16'b01010_100011_01011; 
		3603: oled_colour = 16'b10110_110101_10100; 
		3604: oled_colour = 16'b11101_110100_11000; 
		3605: oled_colour = 16'b11011_110011_10101; 
		3687: oled_colour = 16'b01010_010001_00010; 
		3688: oled_colour = 16'b10011_101001_01111; 
		3689: oled_colour = 16'b11111_111101_11100; 
		3690: oled_colour = 16'b11101_111001_11000; 
		3691: oled_colour = 16'b11000_110010_10010; 
		3692: oled_colour = 16'b11010_111001_10101; 
		3693: oled_colour = 16'b11010_111100_10111; 
		3694: oled_colour = 16'b01101_100110_01101; 
		3697: oled_colour = 16'b10011_011010_01000; 
		3698: oled_colour = 16'b10001_011101_01001; 
		3699: oled_colour = 16'b01011_011101_01000; 
		3700: oled_colour = 16'b01011_011101_01000; 
		3782: oled_colour = 16'b10001_010111_00110; 
		3783: oled_colour = 16'b10101_100011_01011; 
		3784: oled_colour = 16'b01010_011000_00100; 
		3785: oled_colour = 16'b11010_110000_10010; 
		3786: oled_colour = 16'b11111_111000_11000; 
		3787: oled_colour = 16'b11011_101110_10010; 
		3788: oled_colour = 16'b10011_101010_01111; 
		3793: oled_colour = 16'b01100_010001_00001; 
		3794: oled_colour = 16'b10010_011001_00110; 
		3795: oled_colour = 16'b10111_011111_01010; 
		3876: oled_colour = 16'b10111_011111_01011; 
		3877: oled_colour = 16'b01111_010101_00011; 
		3878: oled_colour = 16'b01110_010011_00011; 
		3879: oled_colour = 16'b10110_011111_01011; 
		3880: oled_colour = 16'b01101_011000_00110; 
		3888: oled_colour = 16'b10011_011011_01001; 
		3889: oled_colour = 16'b01100_010001_00001; 
		3890: oled_colour = 16'b10110_011111_01010; 
		3972: oled_colour = 16'b10010_011001_00110; 
		3973: oled_colour = 16'b01011_010000_00001; 
		3974: oled_colour = 16'b10100_011101_01000; 
		3983: oled_colour = 16'b10111_100000_01100; 
		3984: oled_colour = 16'b10101_011100_01000; 
		3985: oled_colour = 16'b01011_001111_00001; 
		3986: oled_colour = 16'b10100_011101_01000; 
		4069: oled_colour = 16'b01110_010011_00010; 
		4070: oled_colour = 16'b11000_100111_01101; 
		4071: oled_colour = 16'b11011_101010_10000; 
		4081: oled_colour = 16'b01101_010010_00010; 
		4082: oled_colour = 16'b10101_011011_01000; 
		4083: oled_colour = 16'b11011_101001_10000; 
		4084: oled_colour = 16'b11010_100111_01111; 
		4166: oled_colour = 16'b11011_101100_10010; 
		4167: oled_colour = 16'b11011_101100_10001; 
		4168: oled_colour = 16'b10100_011011_01010; 
		default: oled_colour = 16'b00000_000000_00000; 
	endcase
end

endmodule