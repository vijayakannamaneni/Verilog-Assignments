`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2023 18:04:09
// Design Name: 
// Module Name: wn_skid_buffer1_tb
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


module wn_skid_buffer_tb () ;
parameter DW = 8 ;
reg clk,reset ;
reg input_tvalid ;
logic input_tready ;
reg [DW-1:0] input_tdata ;
reg [7:0] input_tuser ;
reg input_tlast ;
logic output_tvalid ;
reg output_tready ;
wire [DW-1:0] output_tdata ;
logic [7:0] output_tuser;
wire output_tlast ;

parameter no_cycles = 10 ;
parameter cycle_period  = 10 ;

wn_skid_buffer dut ( 
    .clock (clk ),
    .reset (reset),
    .input_tvalid(input_tvalid ),
    .input_tready(input_tready ),
    .input_tdata (input_tdata ),
    .input_tuser (input_tuser ),
    .input_tlast(input_tlast) ,
    .output_tvalid (output_tvalid ),
    .output_tready (output_tready) ,
    .output_tdata (output_tdata ),
    .output_tuser (output_tuser ),
    .output_tlast (output_tlast ) 

) ;
initial clk = 0 ;
always #(cycle_period/2)  clk=  ~ clk ; 


  // Task for reset
  task reset_task;
       input polarity ;
    begin
      reset <= polarity ;
      #100;
      reset <= ~polarity ;
    end
  endtask

  // Task for generating input_tdata values
  task input_tdata_task;
      
    begin
     @(posedge clk ) 
      input_tdata <= 8'd10 ;
      input_tvalid <= 1'b1 ;
      output_tready <= 1'b1 ;
      wait(input_tready );
      @(posedge clk);
      input_tdata <= 8'd11 ;
      output_tready <= 1'b1 ;        
      @(posedge clk);
      input_tdata <= 8'd12 ;
      output_tready <=1'b1 ;
     
      @(posedge clk);
      output_tready <= 1'b1 ;
      input_tdata <= 8'd13 ;
      @(posedge clk );
      wait(input_tready ) ;
      @(posedge clk);
      input_tdata <= 8'd14;
      output_tready <=1'b1 ;
      @(posedge clk);
      output_tready <= 1'b0 ;
      input_tdata <= 8'd15;   
      @(posedge clk ) 
      wait(input_tready )    
      @(posedge clk);
      input_tdata <= 8'd16;
      output_tready <= 1'b1 ;
      @(posedge clk ) ;
      wait(input_tready ) ;
      @(posedge clk ) ;
      input_tdata<=8'd17 ;
      input_tlast <= 1'b1 ;
      @(posedge clk )
      input_tlast <=1'b0 ;
      @(posedge clk )
      $stop ;
    
      
  
    end 
  endtask
 
    task t_user  ;
    begin 
    @(posedge clk)
    input_tuser <= $random ;
    end
    endtask 
    
  initial begin  
    clk = 0;
    reset = 0;
    input_tvalid = 0;
    output_tready = 0;
    input_tuser = 0;
    input_tdata = 0;
    input_tlast = 0;

    // Call reset task
    reset_task(1);

    // Call input_tdata task
    input_tdata_task;
    t_user ;
  end
endmodule

    






































