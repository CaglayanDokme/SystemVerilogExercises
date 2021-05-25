/* File:            tb_DualEdgeDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 25, 2021 -> Created
 * Description:     Testbench for the Dual Edge Detector module.
 */

`timescale 1ns / 1ps

module tb_DualEdgeDetector;

// Local Constants
localparam T = 10;      // Nanoseconds

// Test Signals
logic clk   = 1'b0; 
logic reset = 1'b0;
logic level = 1'b0;
logic tick; 

// Instantiation of Circuit Under Test
DualEdgeDetector CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));
    
    // Reset Initially
    reset = 1'b1;
    #T;
    reset = 1'b0;
    
    // Begin Test
    
    /* Tick should be asserted at each transaction, whether it is from 1 to 0 or from 0 to 1. */
    
    level = 1'b0;
    #(5*T);
    
    level = 1'b1;
    #(5*T);
    
    level = 1'b0;
    #(5*T);
    
    /* Supplying a one cycle HIGH test signal would make the circuit produce a two-cycle tick. */
    
    level = 1'b1;
    #T;
    
    level = 1'b0;
    #(5*T);
    
    $stop;
end

endmodule
