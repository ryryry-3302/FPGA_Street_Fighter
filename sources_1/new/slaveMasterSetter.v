`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 15:18:38
// Design Name: 
// Module Name: slaveMasterSetter
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


module slaveMasterSetter(input isMaster, input clk ,input [7:0] JA, output reg [7:0] JXADC

    //Master inputs and outputs:
    ,input oled_clk, input cs, input sdin, input sclk, input d_cn, input resn, input vccen, input pmoden
    ,output reg player2UpBtn, output reg player2DownBtn, output reg player2LeftBtn, output reg player2RightBtn, 
    output reg player2AttackBtn
    
    //Slave inputs and outputs:
    ,input btnU, input btnD, input btnL, input btnR, input btnC
    ,output slave_CLK_6MHz25, output reg slave_cs, output reg slave_sdin, output reg slave_sclk, output reg slave_d_cn, output reg slave_resn, output reg slave_vccen, output reg slave_pmoden
    );
    
    assign slave_CLK_6MHz25 = oled_clk;
    
    always @ (posedge clk) begin
        if (isMaster == 1) begin
        //Master Mode
            //Input pmod connector JA
            player2UpBtn     <= JA[0];
//            player2DownBtn   <= JA[1];
            player2LeftBtn   <= JA[2];
            player2RightBtn  <= JA[3];
            player2AttackBtn <= JA[4];

            //Output pmod connector JXADC
            JXADC[0] <= cs;
            JXADC[1] <= sdin;
            JXADC[2] <= sclk;
            JXADC[3] <= d_cn;
            JXADC[4] <= resn;
            JXADC[5] <= vccen;
            JXADC[6] <= pmoden;
            
//            //Set other outputs as LOW (0)
//            slave_cs    <= 0;
//            slave_sdin  <= 0;
//            slave_sclk  <= 0;
//            slave_d_cn  <= 0;
//            slave_resn  <= 0; 
//            slave_vccen <= 0;
//            slave_pmoden <= 0;
        end
        
        else begin
        //Slave Mode
            //Input pmod connector JA
            slave_cs    <= JA[0];
            slave_sdin  <= JA[1];
            slave_sclk  <= JA[2];
            slave_d_cn  <= JA[3];
            slave_resn  <= JA[4]; 
            slave_vccen <= JA[5];
            slave_pmoden <= JA[6];

            //Output pmod connector JXADC
            JXADC[0]  <= btnU;
//            JXADC[1]  <= btnD;
            JXADC[2]  <= btnL;
            JXADC[3]  <= btnR;
            JXADC[4] <= btnC;
            
            //Set other outputs as LOW (0)
            player2UpBtn     <= 0;
//            player2DownBtn   <= 0;
            player2LeftBtn   <= 0;
            player2RightBtn  <= 0;
            player2AttackBtn <= 0;            
        end
    end
endmodule