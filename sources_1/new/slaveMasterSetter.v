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
    ,input [2:0] winState
    ,output player2UpBtn, output player2LeftBtn, output player2RightBtn, 
    output player2AttackBtn, output player2DownBtn
    
    //Slave inputs and outputs:
    ,input btnU, input btnD, input btnL, input btnR, input btnC
    , output [2:0] slave_winState
    );
        
    assign JXADC[0] = isMaster ? winState[0] : btnU;
    assign JXADC[1] = isMaster ? winState[1] : btnD;
    assign JXADC[2] = isMaster ? winState[2]   : btnL;
    assign JXADC[3] = isMaster ? 0   : btnR;
    assign JXADC[4] = isMaster ? 0   : btnC;

    
    assign player2UpBtn     = isMaster ? JA[0] :0 ;
    assign player2DownBtn   = isMaster ? JA[1] :0 ;
    assign player2LeftBtn   = isMaster ? JA[2] :0 ;
    assign player2RightBtn  = isMaster ? JA[3] :0 ;
    assign player2AttackBtn = isMaster ? JA[4] :0 ;
    
    assign slave_winState[0] = (~(JA[0] == 0 && JA[1] == 0) & ~isMaster) ? ~JA[0] : 0;
    assign slave_winState[1] = (~(JA[0] == 0 && JA[1] == 0) & ~isMaster) ? ~JA[1] : 0;
    assign slave_winState[2] = 0;
    
endmodule