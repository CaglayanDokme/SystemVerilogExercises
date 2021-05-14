/* File:            tb_BarrelShifer_8bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Testbench for 8-Bit Barrel Shifter module
 */

`timescale 1ns / 1ps

module tb_BarrelShifer_8bit;

// Test Signals
logic [7:0] test_a;
logic [2:0] test_shiftAmount;
logic [7:0] test_shifted;

// Instantiation of Circuit Under Test
BarrelShifer_8bit BarrelShifter(.a(test_a), .shiftAmount(test_shiftAmount), .shifted(test_shifted));

// Test Scenario
initial begin
    for(int i = 0; i < 2**8; ++i) begin   // Iterate for each 8-bit signal
        for(int k = 0; k < 2**3; ++k) begin // Iterate for each shift amount
            test_a              = i;
            test_shiftAmount    = k;
            
            #10;
        end
    end    
    
    $stop;
end
endmodule
