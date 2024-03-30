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


module slaveMasterSetter(input isMaster, input clk,
    input btnU, input btnD, input btnL, input btnR, input btnC
    
    //Master inputs:
    ,input input_player2UpBtn, input input_player2DownBtn, input input_player2LeftBtn, input input_player2RightBtn,
    input input_player2AttackBtn,
    output player2UpBtn, output player2DownBtn, output player2LeftBtn, output player2RightBtn, 
    output player2AttackBtn
    
    //Slave outputs:
    ,output slaveOut_player2UpBtn, output slaveOut_player2DownBtn, output slaveOut_player2LeftBtn, output slaveOut_player2RightBtn,
    output slaveOut_player2AttackBtn
    );
    
    reg inputReg_player2UpBtn, inputReg_player2DownBtn, inputReg_player2LeftBtn, inputReg_player2RightBtn, inputReg_player2AttackBtn;
//    wire debounced_player2UpBtn,debounced_player2DownBtn, debounced_player2LeftBtn, debounced_player2RightBtn, debounced_player2AttackBtn;
//    debouncer(.clk(clk), .button(btnU), .buttonSignal(debounced_player2UpBtn));
//    debouncer(.clk(clk), .button(btnD), .buttonSignal(debounced_player2DownBtn));
//    debouncer(.clk(clk), .button(btnL), .buttonSignal(debounced_player2LeftBtn));
//    debouncer(.clk(clk), .button(btnR), .buttonSignal(debounced_player2RightBtn));
//    debouncer(.clk(clk), .button(btnC), .buttonSignal(debounced_player2AttackBtn)); 
    
    always @ (posedge clk) begin
        if (isMaster == 1) begin
            inputReg_player2UpBtn <= input_player2UpBtn;
            inputReg_player2DownBtn <= input_player2DownBtn;
            inputReg_player2LeftBtn <= input_player2LeftBtn;
            inputReg_player2RightBtn <= input_player2RightBtn;
            inputReg_player2AttackBtn <= input_player2AttackBtn;        
        end
        
        else begin
            inputReg_player2UpBtn <= 0;
            inputReg_player2DownBtn <= 0;
            inputReg_player2LeftBtn <= 0;
            inputReg_player2RightBtn <= 0;
            inputReg_player2AttackBtn <= 0;   
         end
    end
    
    assign player2UpBtn = inputReg_player2UpBtn;
    assign player2DownBtn = inputReg_player2DownBtn;
    assign player2LeftBtn = inputReg_player2LeftBtn;
    assign player2RightBtn = inputReg_player2RightBtn;
    assign player2AttackBtn = inputReg_player2AttackBtn;
    
//    assign slaveOut_player2UpBtn = ~isMaster & debounced_player2UpBtn;
//    assign slaveOut_player2DownBtn = ~isMaster & debounced_player2DownBtn;
//    assign slaveOut_player2LeftBtn = ~isMaster & debounced_player2LeftBtn;
//    assign slaveOut_player2RightBtn = ~isMaster & debounced_player2RightBtn;
//    assign slaveOut_player2AttackBtn = ~isMaster & debounced_player2AttackBtn;
    
    assign slaveOut_player2UpBtn = ~isMaster & btnU;
    assign slaveOut_player2DownBtn = ~isMaster & btnD;
    assign slaveOut_player2LeftBtn = ~isMaster & btnL;
    assign slaveOut_player2RightBtn = ~isMaster & btnR;
    assign slaveOut_player2AttackBtn = ~isMaster & btnC;      
    
endmodule