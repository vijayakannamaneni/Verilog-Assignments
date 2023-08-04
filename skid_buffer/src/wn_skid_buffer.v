//************************************************************************************************//
/*
* Copyright (c) 2016-2022, WiSig Networks Pvt Ltd. All rights reserved.
* www.wisig.com
*
* All information contained herein is property of WiSig Networks Pvt Ltd.
* unless otherwise explicitly mentioned.
*
* The intellectual and technical concepts in this file are proprietary
* to WiSig Networks and may be covered by granted or in process national
* and international patents and are protect by trade secrets and
* copyright law.
*
* Redistribution and use in source and binary forms of the content in
* this file, with or without modification are not permitted unless
* permission is explicitly granted by WiSig Networks.
*
* General Information:
* ----------------------
*
* I/O Information:
* ------------------
*	1. Input data stream
*	2. Output data stream
*
* Change List
* --------------
* Date (dd/mm/yy)    	  Author 		        Description of Change
* ------------------------------------------------------------------
* 10-01-2022            Leorandal              Initial Version
* 02-07-2022            Mahender               Added TUSER signal in input and output ports
*/
//************************************************************************************************//

module wn_skid_buffer #(parameter       DW          = 8) (
	input  wire          clock, reset ,
	input  wire          input_tvalid ,
	output wire          input_tready ,
	input  wire [DW-1:0] input_tdata  ,
    input  wire [7:0]    input_tuser  ,
	input  wire          input_tlast  ,
	output wire          output_tvalid,
	input  wire          output_tready,
	output reg  [DW-1:0] output_tdata ,
    output reg  [   7:0] output_tuser ,
	output reg           output_tlast
);

	wire [DW-1:0] w_data        ;
    wire [7:0]    w_user        ;
	reg           r_valid       ;
	reg  [DW-1:0] r_data        ;
    reg  [7:0]    r_user        ;
	reg           r_last        ;
	reg           routput_tvalid;

	initial begin
		r_valid = 0;
		r_data = 0;
		r_last = 0;
        r_user = 0;
		routput_tvalid = 0;
		output_tdata = 0;
        output_tuser = 0;
		output_tlast = 0;
	end

	always @(posedge clock) begin
		if (reset)
			r_valid <= 0;
		else if ((input_tvalid && input_tready) && (output_tvalid && !output_tready))
			// We have incoming data, but the output is stalled
			r_valid <= 1;
		else if (output_tready)
			r_valid <= 0;
	end

	always @(posedge clock) begin
		if ((input_tvalid) && input_tready) begin
			r_data <= input_tdata;
			r_last <= input_tlast;
            r_user <= input_tuser;
		end
	end

	always @(posedge clock) begin
		if (reset)
			routput_tvalid <= 0;
		else if (!output_tvalid || output_tready)
			routput_tvalid <= (input_tvalid || r_valid);
	end

	always @(posedge clock) begin
		if (!output_tvalid || output_tready) begin
			if (r_valid) begin
				output_tdata <= r_data;
				output_tlast <= r_last;
                output_tuser <= r_user;
			end
			else if (input_tvalid) begin
				output_tdata <= input_tdata;
                output_tuser <= input_tuser;
				output_tlast <= input_tlast;
			end
			else begin
				output_tdata <= 0;
				output_tlast <= 0;
                output_tuser <= 0;
			end
		end
	end

	assign w_data        = r_data;
    assign w_user        = r_user;
	assign output_tvalid = routput_tvalid;
	assign input_tready  = !r_valid && !reset;

endmodule