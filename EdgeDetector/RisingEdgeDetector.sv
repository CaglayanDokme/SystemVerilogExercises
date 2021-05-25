/* File:            RisingEdgeDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 23, 2021 -> Created
 * Description:     Rising Edge Detector module.
 */

`timescale 1ns / 1ps

module RisingEdgeDetector
(
    input  logic clk,
    input  logic reset,     // Active High
    input  logic level,
    output logic tick
);

// States
enum {zero, one} state;

// Logic
always_ff @ (posedge(clk)) begin
    if(reset) begin
        state   <= zero;
        tick    <= 1'b0;
    end    
    else begin
        tick <= 1'b0;   // Default value of output is 0
    
        case(state)
            zero:
                if(level) begin
                    state   <= one;
                    tick    <= 1'b1;    // Edge detected, assert for one clock
                end
                
            one:
                if(~level)
                    state <= zero;
            
            default:
                state <= level ? one : zero; 
            
        endcase       
    end    
end

endmodule
