/* File:            Debouncer_EarlyDetection.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 25, 2021 -> Created
 * Description:     Parametrical debouncer module with early detection algorithm.
 */

`timescale 1ns / 1ps

module Debouncer_EarlyDetection
#(parameter COVER_CYCLES = 4)  // The circuit covers its state for this amount of cycles after a transition 
(
    input  logic clk,
    input  logic reset,
    input  logic bouncingSignal,
    output logic debounced
);

// Local Constants
localparam COUNTER_BITS = $clog2(COVER_CYCLES + 1);

// States
enum {ZERO, ONE, IDLE} state;

// Internal Signals
logic [COUNTER_BITS-1 : 0] coverCounter = 0;

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        state           <= ZERO;
        coverCounter    <= 0;
        debounced       <= 1'b0;
    end
    else begin
        case(state)
            ZERO:
                if(bouncingSignal) begin
                    coverCounter    <= 0;
                    debounced       <= 1;
                    state           <= IDLE;
                end
                
            ONE:
                if(~bouncingSignal) begin
                    coverCounter    <= 0;
                    debounced       <= 0;
                    state           <= IDLE;
                end
            
            IDLE: begin
                coverCounter <= coverCounter + 1;
                
                if(coverCounter >= COVER_CYCLES) begin
                    state <= debounced ? ONE : ZERO;
                end     
            end                  
            
            default:
                state <= ZERO;
            
        endcase
    end    
end

endmodule
