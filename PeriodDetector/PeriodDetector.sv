/* File:            PeriodDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     Period Detector module. Detects period of a signal in cycles.
 */
 
`timescale 1ns / 1ps

module PeriodDetector
(
    input  logic clk,
    input  logic reset,
    input  logic enable,
    input  logic signal,
    output logic [31:00] period,
    output logic valid
);

// States
enum {IDLE, WAIT_EDGE, COUNT} state;

// Internal Signals
logic risingEdge;

// Module Instantiations
RisingEdgeDetector RED(.level(signal), .tick(risingEdge), .*);

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        valid <= 1'b0;    
    end
    else begin
        valid <= 1'b0;
        
        case(state)
            IDLE:
                if(enable) begin
                    period  <= 0;
                    state   <= WAIT_EDGE;                
                end
                
            WAIT_EDGE:
                if(risingEdge) begin
                    period  <= 0;
                    state   <= COUNT;
                end
                
            COUNT: begin
                period <= period + 1;
                
                if(risingEdge) begin    // Catch the next rising edge
                    valid <= 1'b1;
                    state <= IDLE;
                end
            end
            
            default:
                state <= IDLE;
        endcase    
    end 
end

endmodule
