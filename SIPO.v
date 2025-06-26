`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2024 11:38:15
// Design Name: 
// Module Name: SIPO
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


module SIPO #(
parameter WIDTH=8

)(
input clk,rst,spi_clk,
input wire serial_in,latch,
output reg [WIDTH-1:0]parallel_out=0,   
output reg DONE_flag=0,under_flow=0,over_flow=0
    );
    localparam [1:0]IDLE=2'b00,LOAD=2'b01,DONE=2'b10,ERROR=2'b11;
    reg [WIDTH-1:0]count=0;
    reg [WIDTH-1:0]shift_register=0;    
    reg [1:0]state=0;
    reg [1:0]edge_current=0,prev_edge=0;
    reg [WIDTH-1:0]delay_count=0;
    //states transition control logic
    always@(posedge clk)
    begin
          if(rst)
             begin
             state<=IDLE;
             end
          else
          begin
          case(state)
    IDLE:
          begin
               if (latch==0)
                   begin
                   state<=LOAD;
                   end
               else
                   state<=IDLE;
          end
    LOAD:
          begin
               if (latch==1)
               state<=DONE;
               else
               state<=LOAD;
          end
     DONE:
          begin
               if (DONE_flag)
                   begin
                   state<=IDLE;
                   end
               else if(under_flow)
                   begin
                   state<=ERROR;
                   end
               else if(over_flow)
                   begin
                   state<=ERROR;
                   end
               else
                    state<=DONE;
          end
    ERROR:
          state<=IDLE;
    default state<=IDLE;      
    endcase            
    end
    end  
 //states datapath logic   
    always@(posedge clk)
    begin
    case(state)
    IDLE:
          begin
          shift_register<=0;
          count<=0;
          DONE_flag<=0;
          parallel_out<=parallel_out;
          over_flow<=0;
          under_flow<=0;
          end
    LOAD:
          begin
            if(edge_current==1&&prev_edge==0)
               begin
               shift_register<={shift_register[WIDTH-2:0],serial_in};
               count<=count+1;
               end
            else
               count<=count;
          end
    
    DONE:
          begin
            parallel_out<=shift_register;
            if(count==WIDTH)
               begin
               DONE_flag<=1;
               end
            else if(count<WIDTH)
               begin
               under_flow<=1;
               end
            else if (count>WIDTH)
               over_flow<=1;  
            else
               DONE_flag<=DONE_flag;
          end
   ERROR:
          parallel_out<=parallel_out;   
     endcase
     end  
      always@(posedge clk)
        begin
           edge_current<=spi_clk;   
           prev_edge<=edge_current;
        end
      
endmodule
