`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2023 16:14:15
// Design Name: 
// Module Name: load_counter
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

module load_counter #(parameter BIT_WIDTH=32)
(input clk,
input [31:0] load ,
input upordown ,
input reset ,
input load_en ,
input start ,
input continue_1 ,
output [BIT_WIDTH-1:0]count ,
output pulse 

);

//Internally adding  a maximum and minimum count values for the counter to wrap-around a set of values only.

parameter min=0;
parameter max=32'd750;
reg [BIT_WIDTH-1:0] counter;

// FSM containing the 4 states 
parameter state_1=2'd0 ;
parameter state_2=2'd1;
parameter state_3=2'd2;
parameter state_4=2'd3 ;

reg [1:0] state,next_state ;

//sequntial logic for next_State 
always@(posedge clk )
begin 
    if(reset)
    begin 
        state <= state_1;
       
    end 
    else 
        begin 
            state<=next_state ;
         
        end 
end 

  // state transitions    
always@(*)
begin
    case(state)
    //state_1 : if start signla is high it goes to 2nd state else same state 
    state_1 :begin 
                
                 next_state <= (start)?state_2:state_1; 
            end  
    //state_2: it remains in the state until pause or stop signal is high    
    state_2 :begin  
               
                if(~continue_1) next_state<=state_3 ;
                else if(~start) next_state<=state_4;
                else next_state<=state_2;               
             end  
     //state_3 : if continue is high it goes to state_2 ,else if stop signal is high it goes to stop(state_4) state 
     // else it remains in this pause state                      
    state_3 : begin                                        // pause state 
                if(continue_1) next_state<=state_2 ;
                else if(~start) next_state<=state_4 ;
                else next_state<=state_3;

                end
    // state_4 : it is the stop state  
    state_4 : begin                                         // stopping state 
                if(start) next_state<=state_2 ;
                else next_state<=state_4 ;
                end 
                default : next_state<=state_1;
    endcase 
end 

//counter 
always@(posedge clk )
begin 
    //if reset is high counter value is set to 0 
    if(reset) 
    begin 
        counter <= 0;
    end    
    // else if it is in state_2 if upordown is high  do upcount , else down count      
    else if(state==state_2)
    begin     
        if(upordown)
            begin
                counter<=(counter==max)?min:counter+1 ;
            end 
        else 
               counter<=(counter==min)?max:counter-1 ;
        end 
     //else if load_en is high counter value is set to load .
    else if(state==state_1 && load_en ==1)
        begin 
            counter<=load ;
        end 
     else if(state==state_1 && load_en ==0)
        begin 
            counter<=0;
        end 
    
    end 
    
    //outputs                                  
    assign count =counter ;
    // pulse is high when count reaches maximum value .
    assign pulse =(count==max)?1:0; 
    
endmodule 

  

  
