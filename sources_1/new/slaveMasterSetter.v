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


module slaveMasterSetter(input isMaster, input clk ,input [7:0] JA, output [7:0] JXADC

    //Master inputs and outputs:
    ,input oled_clk, input cs, input sdin, input sclk, input d_cn, input resn, input vccen, input pmoden
    ,output player2UpBtn, output player2LeftBtn, output player2RightBtn, 
    output player2AttackBtn, output player2DownBtn
    
    //Slave inputs and outputs:
    ,input btnU, input btnD, input btnL, input btnR, input btnC
    , output slave_cs, output slave_sdin, output slave_sclk, output slave_d_cn, output slave_resn, output slave_vccen, output slave_pmoden
    );
        
    assign JXADC[0] = isMaster ? cs     : btnU;
    assign JXADC[1] = isMaster ? sdin   : btnD;
    assign JXADC[2] = isMaster ? sclk   : btnL;
    assign JXADC[3] = isMaster ? d_cn   : btnR;
    assign JXADC[4] = isMaster ? resn   : btnC;
    assign JXADC[5] = isMaster ? vccen  : 0;
    assign JXADC[6] = isMaster ? pmoden : 0;
    
    assign player2UpBtn     = isMaster ? JA[0] :0 ;
    assign player2DownBtn   = isMaster ? JA[1] :0 ;
    assign player2LeftBtn   = isMaster ? JA[2] :0 ;
    assign player2RightBtn  = isMaster ? JA[3] :0 ;
    assign player2AttackBtn = isMaster ? JA[4] :0 ;
    
    assign slave_cs     = ~isMaster ? JA[0] : 0;
    assign slave_sdin   = ~isMaster ? JA[1] : 0;
    assign slave_sclk   = ~isMaster ? JA[2] : 0;
    assign slave_d_cn   = ~isMaster ? JA[3] : 0;
    assign slave_resn   = ~isMaster ? JA[4] : 0;
    assign slave_vccen  = ~isMaster ? JA[5] : 0;
    assign slave_pmoden = ~isMaster ? JA[6] : 0;
    
endmodule