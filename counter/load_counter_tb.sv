`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2023 16:17:07
// Design Name: 
// Module Name: load_counter_tb
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
// wire [WIDTH-1:0] count_1; 

//////////////////////////////////////////////////////////////////////////////////
module load_counter_tb();
parameter WIDTH = 16;
reg clk;
reg upordown_1;
reg load_enable_1;
reg [31:0] load_1;
reg reset;
reg start_1;
reg continue_1;
 
wire[WIDTH -1 :0] count_1;
wire pulse_1;
parameter cycle_period =10 ;
parameter no_cycles = 10 ;

 load_counter #(.BIT_WIDTH(16)) dut(
      .clk(clk),
      .load(load_1),
      .upordown(upordown_1),
      .reset(reset),
      .load_en(load_enable_1),
      .count(count_1),
      .start(start_1),
      .continue_1(continue_1),
      .pulse(pulse_1)
  );

initial clk = 0;
always #(cycle_period/2 ) clk = ~clk;


task reset_counter ;
  input polarity ;
  begin 
    @(negedge clk);
    reset =polarity ; 
    repeat(no_cycles)@(negedge clk );    
    reset = ~polarity ;  
       
  end
  endtask 

task configure_counter ;
    input load_en_value ;
    input [31:0] load ;
    input up_or_down ; 
    begin 
        @(negedge clk );
            load_1 = load ;
            upordown_1 = up_or_down;
            load_enable_1 = load_en_value ;
    end 
endtask 


task control_counter ;
    input stop_value ;
    input start_value ;
    input pause_value ;
    input continue_value ;
    begin 
         @(negedge clk ) ;
          
            start_1 = start_value ;
            continue_1 = continue_value ;
            #100 
            start_1 = stop_value ;
            continue_1 = pause_value ;
            
           
    end 
endtask 

initial 
begin
  #10
  // test_1 : for reset 
  reset_counter (1) ; 
  #100
  // test_2 : for load_en , up_or_down 
  configure_counter (1,32'd100,1);
  #100
  // test_3 : for stop,start,pause signals 
  control_counter  (1,1,0,1 ) ;
  
end

endmodule

