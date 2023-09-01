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
* Module for standalone RU testing data generator 
* I/O Information:
* ------------------
* Data generator AXIS output
*
* Change List
* --------------
* Date (dd/mm/yy)       Author                 Description of Change
* ------------------------------------------------------------------
* 
* 
*
/************************************************************************************************/

module datagen_cplane #(
    parameter string FILENAME        = "/home/sekhar/Downloads/c_plane_input_dl.txt",
    parameter int    DATA_WIDTH      = 32,
    parameter int    DEPTH           = 12 ,
    parameter int    NO_OF_PACKETS   = 8 
) (
    input                         clock,
    input                         reset_n,
    output logic [DATA_WIDTH-1:0] data,
    output logic                  valid,
    input                         ready,
    input                         start ,
    input                         stop ,
    input                         continue_1 ,
    input                         pause ,
    output logic                  sop,
    output logic                  eop 
);

    // Internal variables
    integer                  read_index;
    logic   [DATA_WIDTH-1:0] mem_arr [DEPTH];
    integer                  counter = 0  ; 
    static int k =(NO_OF_PACKETS * DEPTH);

    // Initializing the mem with configuration
    initial begin
        $readmemh(FILENAME, mem_arr);
        if($isunknown(mem_arr)) begin
            $display("ERROR: %s not found", FILENAME);
            $stop;
        end
    end
 
    // FSM 
    parameter state_0=2'b00 ;
    parameter state_1=2'b01 ;
    parameter state_2=2'b10 ;
    parameter state_3=2'b11 ;

    reg[1:0] state,next_state;

    always@(posedge clock)begin
        if(~reset_n)begin 
            state <= state_0;
        end
        else state <= next_state ;
    end

    always@(posedge clock)begin
        case(state)
            state_0 :begin               
                        next_state <= (start)?state_1:state_0; 
                    end 
                    
            state_1 :begin               
                        if(pause) next_state <= state_2 ;
                        else if(stop) next_state <= state_3;
                        else if (counter <= k) begin 
                            counter = counter +1 ;
                            next_state <= state_1;
                        end 
                        else state <= state_3;                           
                    end  
                            
            state_2 :begin                                        
                        if(continue_1) next_state <= state_1 ;
                        else if(stop) next_state <= state_3 ;
                        else next_state <= state_2;
                    end

            state_3 :begin                                         
                        if(start) next_state <= state_1 ;
                        else next_state <= state_3 ;
                    end 
                    default : next_state <= state_0;
        endcase 
    end 

    // Loading configuration
    always_ff @(posedge clock) begin
        if (!reset_n) begin
            data <= 0;
        end else if (state==state_1) begin
            if (ready) begin
                data [DATA_WIDTH-1:0] <= mem_arr[read_index];
            end
        end  else if (state==state_3)begin
              ////
        end
    end
    
    // Incrementing the configuration read address
    always_ff @(posedge clock) begin       
        if (~reset_n) begin
            read_index <= 'd0;
        end else if (state == state_1) begin
            if (ready) begin                            
                read_index <= read_index == (DEPTH-1) ? 'd0 : read_index+1;
            end else begin
                read_index <= read_index;
            end
        end  else if(state == state_3)begin
         
        end
    end
   
    // eop (end of packet) and sop (start of the packet) declaration  
    always_ff @(posedge clock) begin 
          if(read_index == DEPTH-1 && ready) eop <= 1 ;
          else eop <= 0 ; 
          if(read_index == 0 && ready && state == state_1) sop <= 1 ;
          else sop <= 0 ;
    end 
    
    // valid signal 
    always_ff @(posedge clock) begin
        if (!reset_n) begin
            valid <= 0;
        end else begin
            if(state == state_1 ) begin
            valid <= 1;
            end
        end
    end

endmodule