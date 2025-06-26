module Main_module#(

parameter WIDTH=8)

(
input clock,reset,clk,
output reg init=1,
output reg [WIDTH-1:0] data_out=0,
input wire data_tran_flag
);
reg [WIDTH-1:0]count=0;
reg start_process=0;
reg [1:0]edge_current=0,prev_edge=0;
 always@(posedge clock)
  begin
        if(reset)
                begin
                start_process<=0;
                count<=0;
                data_out<=0;
               
                end
        else
                begin
                if(data_tran_flag==1)
                     begin
                     start_process<=0;
                     data_out<=data_out;
                     end 
                else
                     begin
                     if(start_process==0)
                           begin
                           if(&count==1)
                           count<=0;
                           else
                           begin
                           count<=count+1;
                           start_process<=1;
                           data_out<=count+1;
                           end
                           end
                     else
                          begin
                          start_process<=start_process;
                          end
                     end
                end
 end
//  always@(negedge clk)
//    begin
//    if(reset)
//    init<=0;
//    else
//    begin
//    if(start_process)
//    init<=0;
//     else if(data_tran_flag)
//       init<=1;
//       else
//       init<=init;
//     end 
//     end 
     always@(posedge clk)
        begin
           edge_current<=start_process;   
           prev_edge<=edge_current;
           if(edge_current==0&&prev_edge==1)
           init<=1;
           else
           init<=0;
        end

endmodule
