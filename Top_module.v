`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: KHAWAR MURTAZA
// 
// Create Date: 16.01.2024 11:16:52
// Design Name:  
// Module Name: Top_module
// Project Name: SPI MODULE
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


module Top_module#(parameter WIDTH=8)(chip_select,chip_select_rx,serial_data_rx,clock,reset,data_out,data_recevied_flag,data_recevied_overflow,data_recevied_underflow,serial_data,spi_clk,spi_clk_rx);
input clock,reset;
input serial_data_rx,spi_clk_rx,chip_select_rx;
output wire [WIDTH-1:0]data_out;
output wire data_recevied_flag,data_recevied_overflow,data_recevied_underflow,serial_data,spi_clk,chip_select;
wire INIT,transmitter_flag,clk_dvdr_op_clk;
wire [WIDTH-1:0]count_data_in;   
                                                                        
Transmitter  #(.WIDTH(WIDTH)) Transmitter2(.clock(clock),.reset(reset),.data_in(count_data_in),.data_out(serial_data),.done_process(transmitter_flag),.start_process(INIT),.chip_select(chip_select),.spi_clk(spi_clk));
reciver  #(.WIDTH(WIDTH)) reciver3(.clock(clock),.reset(reset),.data_in(serial_data_rx),.data_out(data_out),.done_flag(data_recevied_flag),.spi_clk(spi_clk_rx),.chip_select(chip_select_rx),.over_flow(data_recevied_overflow),.under_flow(data_recevied_underflow));
Main_module  #(.WIDTH(WIDTH)) Main4(.clk(clk_dvdr_op_clk),.clock(clock),.reset(reset),.data_out(count_data_in),.data_tran_flag(transmitter_flag),.init(INIT));
clockdivider clockdivider3(.clk_NEW(clk_dvdr_op_clk),.clk(clock),.rst(reset));
endmodule

 
