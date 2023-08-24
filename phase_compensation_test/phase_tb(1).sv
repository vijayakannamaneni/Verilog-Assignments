`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2023 18:47:54
// Design Name: 
// Module Name: phases_tb
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



`ifndef __HEADER_INCLUDE__
`define __HEADER_INCLUDE__
`include "wn_phase_compensation_header.svh"
`endif

module phases_tb ( );
logic clock;
logic [$bits(config_phaseCompensation)-1:0] config_in_tdata;
reg config_in_tready;
logic  config_in_tvalid;
logic  [31:0] data_in_0_tdata;
logic  data_in_0_tlast;
reg data_in_0_tready;
logic  data_in_0_tvalid;
wire  [31:0] data_in_1_tdata;
wire  data_in_1_tlast;
reg data_in_1_tready;
wire  data_in_1_tvalid;
reg [31:0] data_out_0_tdata;
logic  data_out_0_tready;
logic data_out_0_tvalid;
reg [31:0] data_out_1_tdata;
wire  data_out_1_tready;
reg data_out_1_tvalid;
logic  reset_n;
logic  [7:0] slot_num_in_0_tdata;
wire  slot_num_in_0_tlast;
reg slot_num_in_0_tready;
logic  slot_num_in_0_tvalid;
wire  [7:0] slot_num_in_1_tdata;
wire  slot_num_in_1_tlast;
reg slot_num_in_1_tready;
config_phaseCompensation rd_config ;
parameter clock_period = 10 ;

wn_phase_compensation_top dut ( 
    .clock(clock),
    .config_in_tdata (config_in_tdata) ,
    .config_in_tready (config_in_tready),
    .config_in_tvalid (config_in_tvalid),
    .data_in_0_tdata (data_in_0_tdata),
    .data_in_0_tlast (data_in_0_tlast) ,
    .data_in_0_tready (data_in_0_tready) ,
    .data_in_0_tvalid (data_in_0_tvalid) ,
    .data_in_1_tdata  (data_in_1_tdata) ,
    .data_in_1_tready (data_in_1_tready) ,
    .data_in_1_tvalid (data_in_1_tvalid) ,
    .data_in_1_tlast (data_in_1_tlast) ,
    .data_out_0_tdata (data_out_0_tdata) ,
    .data_out_0_tready (data_out_0_tready) ,
    .data_out_0_tvalid (data_out_0_tvalid ), 
    .data_out_1_tdata (data_out_1_tdata ) ,
    .data_out_1_tready (data_out_1_tready) ,
    .data_out_1_tvalid (data_out_1_tvalid ) ,
    .reset_n (reset_n) ,
    .slot_num_in_0_tdata (slot_num_in_0_tdata) ,
    .slot_num_in_0_tlast (slot_num_in_0_tlast ) ,
    .slot_num_in_0_tvalid (slot_num_in_0_tvalid ) ,
    .slot_num_in_0_tready (slot_num_in_0_tready),
    .slot_num_in_1_tdata  (slot_num_in_1_tdata),
    .slot_num_in_1_tlast (slot_num_in_1_tlast ),
    .slot_num_in_1_tvalid (slot_num_in_1_tvalid)
     );
 
initial   clock = 0 ;
always #(clock_period /2 ) clock = ~ clock ;

//reset task 
task reset_task ;
input polarity ;
begin  
reset_n = polarity ;
#50
reset_n = ~polarity ;
end 
endtask 

//configure task 
task configure_1 ;
begin 
config_in_tvalid  <= 1 ;
@(posedge clock )   
rd_config.enable_phase_compensation = 1 ;
rd_config.numerology = 3 ;
rd_config.CF = 32'd 3350700000 ;
rd_config.phase_compensation_mode = 0 ;
config_in_tdata = rd_config ;
if(config_in_tready)  begin 
    @(posedge clock ) 
    config_in_tvalid <= 0 ;
end 
else  begin 
    wait(config_in_tready )
    @(posedge clock ) 
    config_in_tvalid <=0 ;
end   
end 
endtask 

// reading the reference files from the matlab 
reg [31:0] data_temp_out ;
reg [15:0] data_inr ;
reg[15:0] data_ini ;
reg[15:0] datap_inr ;
reg[15:0] datap_ini ;
int fdr ;
int fdi ;
int fdpr ;
int fdpi ;
int count_1 ;
initial begin     
fdr = $fopen ("/home/sekhar/Downloads/ref_rRBdata_file.txt" ,"r") ;
fdi = $fopen ("/home/sekhar/Downloads/ref_iRBdata_file.txt" ,"r") ;
fdpr = $fopen ("/home/sekhar/Downloads/ref_phase_comp_real.txt" ,"r");
fdpi = $fopen ("/home/sekhar/Downloads/ref_phase_comp_imag.txt","r"); 
end 

// task for input data 
task data_1;
begin
while($fscanf(fdr,"%d,",data_inr)==1 | $fscanf(fdi,"%d,",data_ini)==1)
begin
    data_in_0_tvalid = 1;   
    @(posedge clock);          
    data_out_0_tready = 1;
    data_in_0_tdata[15:0]=data_inr ;
    data_in_0_tdata[31:16]=data_ini ;
    count_1 = count_1 + 1 ;
    data_in_0_tlast = (count == 22176 )?1:0; 
    wait(data_in_0_tready ) ;    
 end 
#10
data_in_0_tvalid = 0 ;
data_out_0_tready = 1 ; 
#60
data_out_0_tready = 0; 
end
endtask

// task for slot 
task slot ;
input slot_number ;
begin 
slot_num_in_0_tvalid =1 ;
@(posedge clock )        
slot_num_in_0_tdata = slot_number ; 
if(slot_num_in_0_tready) begin 
    @(posedge clock ) 
    slot_num_in_0_tvalid <= 0 ;
end 
else  begin 
    wait(slot_num_in_0_tready )
    @(posedge clock ) 
    slot_num_in_0_tvalid<=0 ;
end           
end 
endtask 

initial begin
reset_task (0);
fork
    configure_1 ;
//  #19800
    data_1(); 
    slot (1) ;
join
$fclose(out);
$fclose(out1);
//$stop;
end

//writing output_data into files 
int out ;
int out1 ;
int counter ;
logic signed [15:0] out_1;
logic signed [15:0] out_2 ;
assign out_1 = data_out_0_tdata[15:0];
assign out_2 = data_out_0_tdata[31:16];

initial begin 
out = $fopen("/home/sekhar/Downloads/rtl_out_real.txt","w" );
out1= $fopen("/home/sekhar/Downloads/rtl_out_imag.txt","w" );
end
always@(posedge clock)begin
    if(data_out_0_tready && data_out_0_tvalid ) begin 
        $fdisplay(out ,"%d" , out_1);
        $fdisplay(out1,"%d", out_2) ;
        counter = counter +1 ;      
    end
end 

//writing the phase_output from wn_phase_compensation_params into a file
int fp_write;
int count ;
initial begin
fp_write = $fopen("/home/sekhar/Downloads/phase_out_rtl.txt","w");
if(fp_write == 0 )begin
$stop ;
end
end   

always@(posedge clock ) begin 
if(dut.wn_phase_compensation_params_inst.phase_out_tvalid && dut.wn_phase_compensation_params_inst.phase_out_tready)begin
    $fdisplay(fp_write,"%d\n",dut.wn_phase_compensation_params_inst.phase_out_tdata[63:0]);
    $display ("phaseout=%d\n ",dut.wn_phase_compensation_params_inst.phase_out_tdata[63:0] );
end 
if(dut.wn_phase_compensation_params_inst.phase_out_tlast ==1 )begin 
    $fclose(fp_write);
end
end

//writing the input_phase from precompensation into files 
int fr_write ;
int fi_write ;
initial begin 
fr_write = $fopen("/home/sekhar/Downloads/phase_in_real_rtl.txt ","w");
fi_write = $fopen("/home/sekhar/Downloads/phase_in_imag_rtl.txt ","w");
if(fi_write == 0 && fr_write==0 ) begin 
$stop ;
end 
end

always@(posedge clock) begin 
if(dut.wn_phase_pre_compensation.phase_in_tvalid && dut.wn_phase_pre_compensation.phase_in_tready) begin 
    $fdisplay (fr_write ,"%d",dut.wn_phase_pre_compensation.phase_in_tdata[15:0]);
    $fdisplay (fi_write ,"%d ",dut.wn_phase_pre_compensation.phase_in_tdata[31:16]);
    $display ("phase_in=%d\n",dut.wn_phase_pre_compensation.phase_in_tdata[15:0]);
end
//end

if(dut.wn_phase_pre_compensation.phase_in_tlast ==1 ) begin 
    $fclose(fr_write);
    $fclose(fi_write);
    end
end
endmodule 




