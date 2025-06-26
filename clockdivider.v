`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:BCube 
// Engineer: Khawar Murtaza
// 
// Create Date: 09.01.2024 10:11:29
// Design Name: 
// Module Name: clockdivider
// Project Name: SPI Module
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


module clockdivider(
    input clk,
    input rst,
    output reg clk_NEW=0
    );    
//Possible range of achiveable frequencies for any input frequency is equal to input/2^n where n=0,1,2,3,4.....   
// so for 100MHz Possible frequencies are (50M,25M,10M,12.5M,6.25M,3.125M,1.56M......)Hz    
   
    parameter              
             input_clk=100000000,   //Enter Input Clock Frequency here  
             req_clk = 6250000,   //Enter required frequency here from possible range 
             Count_N= input_clk/req_clk,
             N=Count_N/2;
    reg [27:0] count;
  
    always@(posedge clk)
    begin
    if(rst)
    count<=0;
    else if(count==N-1)
    count<=0;
    else
    count<=count+1;
    end
    always@(posedge clk)
    begin
    if(rst)
    clk_NEW<=0;
    else if (count==N-1)
    clk_NEW=!clk_NEW;
    else
    clk_NEW<=clk_NEW;
    end
endmodule
