/* File:            tb_Debouncer_EarlyDetection.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 25, 2021 -> Created
 * Description:     Testbench for parametrical debouncer module with early detection mechanism.
 */

`timescale 1ns / 1ps

module tb_Debouncer_EarlyDetection;

// Local Constants
localparam T = 10;  // Nanoseconds
localparam COVER_CYCLES = 4;

// Test Signals
logic clk;
logic reset             = 1'b0;     // Active High
logic bouncingSignal    = 1'b0;
logic debounced;

// Instantiation of Circuit Under Test
Debouncer_EarlyDetection #(.COVER_CYCLES(COVER_CYCLES)) CUT(.*);

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
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    // Swing Every Cycle
    for(int i = 0; i < COVER_CYCLES*2; ++i) begin
        bouncingSignal = (i % 2) ? 1'b1 : 1'b0;
        #T;
    end
    
    bouncingSignal <= 1'b0;
    #(T * (COVER_CYCLES + 1));
    
    // Swing for 2 cycles
    bouncingSignal <= 1'b1;
    #T;
    bouncingSignal <= 1'b0;
    #T;
    bouncingSignal <= 1'b1;
    #(T * (COVER_CYCLES + 1));
    
    $stop;    
end
endmodule
