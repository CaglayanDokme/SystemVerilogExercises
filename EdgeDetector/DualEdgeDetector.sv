/* File:            DualEdgeDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 25, 2021 -> Created
 * Description:     Dual Edge Detector module, detects both the rising and falling edges.
 */

`timescale 1ns / 1ps

module DualEdgeDetector
(
    input  logic clk,
    input  logic reset,     // Active High
    input  logic level,
    output logic tick
);

// States
enum {ZERO, ONE} state = ZERO;

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        tick    <= 1'b0;
        state   <= ZERO;
    end
    else begin
        tick <= 1'b0;
    
        case(state)
            ZERO:
                if(level) begin
                    tick    <= 1'b1;
                    state   <= ONE;        
                end                
            ONE:
                if(~level) begin
                    tick    <= 1'b1;
                    state   <= ZERO;        
                end
            
            default: begin
                tick    <= 1'b0;
                state   <= ZERO; 
            end
        endcase    
    end
end

endmodule
