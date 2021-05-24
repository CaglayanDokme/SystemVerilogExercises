/* File:            tb_ClockDivider.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 24, 2021 -> Created
 * Description:     Testbench for the parametrical clock divider module. 
 */

`timescale 1ns / 1ps

module tb_ClockDivider;

// Local Constants
localparam T                = 10;                   // Nanoseconds
localparam rawClockFreq     = 1e9 / T;              // Hz
localparam desiredClockFreq = rawClockFreq / 10;    // Hz

// Test Signals
logic clk;
logic dividedClock;

// Instantiation of Circuit Under Test
ClockDivider #(.rawClockFreq(rawClockFreq), .desiredClockFreq(desiredClockFreq)) ClkGen(.*);

// Clock Generator
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

initial begin
    // Wait for 10 coomplete decelerated clocks
    for(int i = 0; i < 10; ++i) begin
        wait(dividedClock == 1'b0);
        wait(dividedClock == 1'b1);
    end
    
    $stop;
end

endmodule
