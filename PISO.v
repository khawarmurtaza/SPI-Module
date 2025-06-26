`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BCube
// Engineer: Khawar Murtaza
// 
// Create Date: 10.01.2024 11:11:25
// Design Name: 
// Module Name: PISO
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
module PISO #(parameter WIDTH=8  )
(

     input clk,rst,INIT,clock,
     input wire [WIDTH-1:0] parallel_in,
     output reg serial_out=0,DONE_flag=0,latch=0,
     output reg spi_clk=0   
 );
      localparam[1:0]   IDLE=2'b00,
                        LOAD=2'b01,
                        SHIFT=2'b10,
                        DONE=2'b11;
    reg transfer=0;
    reg [WIDTH-1:0]count=0;
    reg [WIDTH-1:0]SHIFT_register=0;
    reg [1:0]state=0;
    reg [1:0]edge_current=0,prev_edge=0;
    
    // states transition control logic
    
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
                  count<=0;
                  SHIFT_register<=0;
                  serial_out<=0;           
                  latch<=1;
                  
                      if(parallel_in)
                        begin
                        DONE_flag<=0;
                          begin
                          if(INIT)
                          begin
                            state<=LOAD;                     
                          end
                          else
                            state<=IDLE;
                          end
                          end
                      else
                          state<=IDLE; 
               end 
        LOAD:
               begin
                  latch<=0;
                  SHIFT_register<=parallel_in;                  
                  state<=SHIFT;
               end
        SHIFT:
               begin
                  serial_out<=SHIFT_register[WIDTH-1];
                  SHIFT_register<=SHIFT_register<<1;
                  count<=count+1;
                    if(count==WIDTH)
                         begin
                         transfer<=1;       
                         count<=0;
                         end
                    else
                         begin
                         transfer<=0;
                         end                           
                      if(transfer)
                          begin
                          state<=DONE;                                   
                          end
                      else
                          state<=SHIFT;
               end
        DONE:
               begin
                  latch<=1;
                  DONE_flag<=1;
                  count<=0;
                  state<=IDLE;
               end 
        default state<=IDLE;       
      endcase
     end
    end
            
 //spi clock logic   
  
      always@(posedge clock)
        begin
         edge_current<=clk;
         prev_edge<=edge_current;
         case(state)
         SHIFT:
                begin
                if(count>=1&&count<=WIDTH)
                      begin
                      if(edge_current==0&&prev_edge==1)
                          begin
                          spi_clk<=1;
                          end
                      else if(edge_current==1&&prev_edge==0)
                          begin
                          spi_clk<=0;
                          end
                      else
                          spi_clk<=spi_clk;
                      end 
                else
                spi_clk<=0;      
                end
          default count<=count;      
         endcase
        end    
      endmodule
