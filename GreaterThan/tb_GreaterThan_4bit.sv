/* File:            tb_GreaterThan_4bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Testbench for 4-bit Greater Than module
 */

`timescale 1ns / 1ps

module tb_GreaterThan_4bit;

// Signal Declarations
logic [3:0] test_in0, test_in1;
logic test_out;

// Instantiation of the circuit under test
GreaterThan_4bit UUT(.a(test_in0), .b(test_in1), .greater(test_out));

// Test Vector Generation
initial begin
    for(int i = 0; i < 16; ++i) begin
        for(int k = 0; k < 16; ++k) begin
            test_in0 = i;
            test_in1 = k;
            #100;
        end
    end
    
    $stop;  // Stop the simulation
end
endmodule
