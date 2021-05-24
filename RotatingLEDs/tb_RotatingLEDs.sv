/* File:            tb_RotatingLEDs.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 24, 2021 -> Created
 * Description:     Testbench for LED Rotator module.
 */

`timescale 1ns / 1ps

module tb_RotatingLEDs;

// Local Constants
localparam T        = 10;   // Nanoseconds
localparam nSpeed   = 4;    // Rotation Speed Bits
localparam nLED     = 4;    // Number of LEDs

// Test Signals
logic clk   = 0;
logic reset = 0;  // Active High
logic [nSpeed-1 : 0] rotationSpeed = 0;
logic [nLED-1   : 0] leds;

// Instantiation of Circuit Under Test
RotatingLEDs #(.nSpeed(nSpeed), .nLED(nLED), .counterClkFreq(50e6)) CUT(.*);

// Clock Generation
always begin
    clk = 1'b0; #(T/2);
    clk = 1'b1; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));

    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    for(int i = 0; i < 2**nSpeed; ++i) begin
        rotationSpeed <= i;
        
        wait(leds[nLED-1]);     // Wait for the completion of left rotation
        wait(~leds[nLED-1]);
        
        wait(leds[0]);          // Wait for the completion of right rotation
        wait(~leds[0]);
    end 
    
    #100;
    
    $stop;
end
    
endmodule
