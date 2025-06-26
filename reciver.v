`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 10:54:55
// Design Name: 
// Module Name: reciver
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


module reciver #(parameter WIDTH=8)(clock,reset,spi_clk,data_in,data_out,chip_select,done_flag,under_flow,over_flow);
input wire clock,reset,chip_select,spi_clk;
input wire  data_in;
output wire [WIDTH-1:0]data_out;
output wire done_flag,under_flow,over_flow;


SIPO  #(.WIDTH(WIDTH))       SIPO2(.clk(clock),.rst(reset),.serial_in(data_in),.parallel_out(data_out),.latch(chip_select),.DONE_flag(done_flag),.under_flow(under_flow),.over_flow(over_flow),.spi_clk(spi_clk));

endmodule
