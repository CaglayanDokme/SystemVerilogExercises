/* File:            tb_ReducedXorGen.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 13, 2021 -> Created
 * Description:     Testbench for Reduced Xor Generator module
 */

`timescale 1ns / 1ps

module tb_ReducedXorGen;

// Local Constants
localparam N = 5;

// Test Signals
logic [N-1 : 0] test_in;    // The output must be 1 if the number of bits are odd and vice versa.
logic test_out;

// Instantiation of Circuit Under Test
ReducedXorGen #(.N(N)) xorGen(.a(test_in), .y(test_out));

// Test Scenario
initial begin
    for(int i = 0; i < 2**N; ++i) begin
        test_in = i;
        #20;
    end
    
    $stop;
end
endmodule
