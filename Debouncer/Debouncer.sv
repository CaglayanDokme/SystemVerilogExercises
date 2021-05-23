/* File:            Debouncer.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 23, 2021 -> Created
 * Description:     Parametrical debouncer module.
 */

`timescale 1ns / 1ps

module Debouncer
#(parameter SAFE_CYCLES = 4)
(
    input  logic clk,
    input  logic reset,             // Active High
    input  logic bouncingSignal,
    output logic debounced
);

// Local Constants
localparam COUNTER_BITS = $clog2(SAFE_CYCLES + 1);

// States
enum {IDLE, COUNT} state;

// Internal Signals
logic [COUNTER_BITS-1 : 0] counter = 0;
logic lastSafeSignal = 0;

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        state           <= IDLE;
        counter         <= 0;
        lastSafeSignal  <= 0;    
    end
    else begin
        case(state) 
            IDLE: begin
                if(bouncingSignal == ~lastSafeSignal) begin
                    state   <= COUNT;
                    counter <= 0;
                end
            end            
            
            COUNT:
                if(bouncingSignal == ~lastSafeSignal) begin
                    counter <= counter + 1;
                    
                    if(counter >= SAFE_CYCLES-1) begin
                        lastSafeSignal  <= ~lastSafeSignal;
                        counter         <= 0;
                        state           <= IDLE;
                    end
                end
                else begin
                    state           <= IDLE;
                    counter         <= 0;
                end                
                
            default:     
                state <= IDLE;       
            
        endcase
    end
end

assign debounced = lastSafeSignal;

endmodule
