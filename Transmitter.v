`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BCube
// Engineer: Khawar Murtaza
// 
// Create Date: 12.01.2024 09:43:10
// Design Name: SPI Transmitter
// Module Name: Transmitter
// Project Name: SPI
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
 
module Transmitter #(parameter WIDTH=8)
(
input clock,reset,start_process,
input wire [WIDTH-1:0] data_in,
output wire data_out,done_process,chip_select,spi_clk
);
wire clk_dvdr_op_clk;                                                                           
         // clock is the input clock frequency which is converted into clk_dvdr_op_clk  
        // 'spi_clock' is the clock frequency at which data will be sent 
       //  refer to clockdivider module for desireable spi_clock frequency
clockdivider clockdivider1(.clk(clock),.rst(reset),.clk_NEW(clk_dvdr_op_clk));
PISO  #(.WIDTH(WIDTH))       PISO2(.clock(clock),.clk(clk_dvdr_op_clk),.rst(reset),.parallel_in(data_in),.serial_out(data_out),.INIT(start_process),.DONE_flag(done_process),.latch(chip_select),.spi_clk(spi_clk));

endmodule
