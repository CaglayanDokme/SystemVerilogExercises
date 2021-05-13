/* File:            tb_Adder_Nbit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 13, 2021 -> Created
 * Description:     Testbench for N-Bit adder module
 */

`timescale 1ns / 1ps

module tb_Adder_Nbit;

// Local Constants
localparam N = 4;

// Test Signals
logic [N - 1 : 0] test_in0, test_in1;
logic [N - 1 : 0] test_out;
logic carryOut;

// Instantiation of Circuit Under Test
Adder_Nbit #(.N(N)) adder(.a(test_in0), .b(test_in1), .sum(test_out), .carryOut(carryOut));

initial begin
    for(int i = 0; i < (2**N); ++i) begin
        for(int k = 0; k < (2**N); ++k) begin
            test_in0 = i;
            test_in1 = k;
            #20;        
        end
    end
    
    $stop;
end
endmodule
