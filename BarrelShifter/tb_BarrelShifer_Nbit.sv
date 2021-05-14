/* File:            tb_BarrelShifer_Nbit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Testbench for N-Bit Barrel Shifter module
 */

`timescale 1ns / 1ps

module tb_BarrelShifer_Nbit;

// Local Constants
localparam N    = 32;
localparam logN = $clog2(N);

// Test Signals
logic [N - 1    : 0] test_a;
logic [logN - 1 : 0] test_shiftAmount;
logic [N - 1    : 0] test_shifted;

// Instantiation of Circuit Under Test
BarrelShifer_Nbit #(.N(N)) BarrelShifter(.a(test_a), .shiftAmount(test_shiftAmount), .shifted(test_shifted));

// Test Scenario
initial begin
    if(N >= 32) begin
        $display("Testing a signal of width greater than 32-Bits is not possible using the 'int' data type.");
        $display("Because of that the 'int' has 32 bits, hence it doesn't cover the full range of test inputs.");
        $display("Bit size longint: %0d", $bits(longint));
        $display("Bit size int:     %0d", $bits(int));
    end

    for(longint i = 0; i < 2**N; ++i) begin   // Iterate for each N-bit signal
        for(int k = 0; k < 2**logN; ++k) begin // Iterate for each shift amount(0 to log2N)
            test_a              = i;
            test_shiftAmount    = k;
            
            #10;
        end
    end    
    
    $stop;
end
endmodule
