/* File:            tb_SquareWaveGenerator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Testbench for square wave generator
 */

`timescale 1ns / 1ps

module tb_SquareWaveGenerator;

// Local Constants
localparam N = 4;
localparam T = 10;  // Nanoseconds

// Test Signals
logic clk;
logic reset = 0;  // Active High(Sync)
logic [N-1 : 0] highCycles = 0;
logic [N-1 : 0] lowCycles  = 0;
logic wave;

// Instantiation of Circuit Under Test
SquareWaveGenerator #(.N(N)) SWG(.*);

// Clock Generation
always begin
    clk = 1'b0; #(T/2);
    clk = 1'b1; #(T/2);
end

// Test Scenario
initial begin
    @(posedge(clk));    // Clock synchronization
    
    #100;
    
    // Reset initially
    reset = 1'b1;
    #T;
    reset = 1'b0;
    #T;
    
    // %50 Duty Cycle (Period = T * 2**N )
    highCycles  = 2**(N-1) - 1;
    lowCycles   = 2**(N-1) - 1;
    
    #((T * 2**N) * 3);  // Wait for 3 complete waves
    
    $stop;
end

endmodule
