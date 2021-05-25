/* File:            tb_RisingEdgeDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 23, 2021 -> Created
 * Description:     Testbench for Rising Edge Detector module.
 */

`timescale 1ns / 1ps

module tb_RisingEdgeDetector;

// Local Constants
localparam T = 10;  // Nanoseconds

// Test Signals
logic clk   = 1'b0;
logic reset = 1'b0;
logic level = 1'b0;
logic tick;

// Instantiation of Circuit Under Test
RisingEdgeDetector CUT(.*);

// Clock Generation
always begin
    clk <= 1'b0; #(T / 2);
    clk <= 1'b1; #(T / 2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @ (posedge(clk));

    // Reset Initially
    reset <= 1'b1;
    #T;
    reset = 1'b0;
    
    #(T * 4);   // IDLE     
    
    // Produce a high signal for 5 clocks
    level = 1'b1;
    #(T * 5);
    level = 1'b0;
        
    #(T * 4);    // IDLE   
    
    // Produce a high signal for 1 clock
    level = 1'b1;
    #T;
    level = 1'b0;
    
    #(T * 4);    // IDLE   
    
    $stop;     
end

endmodule
