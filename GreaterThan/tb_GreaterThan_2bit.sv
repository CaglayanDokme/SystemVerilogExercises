/* File:            tb_GreaterThan_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Testbench for 2-bit Greater Than module
 */

`timescale 1ns / 1ps

module tb_GreaterThan_2bit;

// Signal Declarations
logic [1:0] test_in0, test_in1;
logic test_out;

// Instantiation of the circuit under test
GreaterThan_2bit UUT(.a(test_in0), .b(test_in1), .greater(test_out));

// Test Vector Generation
initial begin
    // Test Case 0
    test_in0 = 2'b00;
    test_in1 = 2'b00;
    #100;
    
    // Test Case 1
    test_in0 = 2'b01;
    test_in1 = 2'b00;
    #100;
    
    // Test Case 2
    test_in0 = 2'b10;
    test_in1 = 2'b00;
    #100;
    
    // Test Case 3
    test_in0 = 2'b11;
    test_in1 = 2'b00;
    #100;
    
    // Test Case 4
    test_in0 = 2'b00;
    test_in1 = 2'b01;
    #100;
    
    // Test Case 5
    test_in0 = 2'b01;
    test_in1 = 2'b01;
    #100;
    
    // Test Case 6
    test_in0 = 2'b10;
    test_in1 = 2'b01;
    #100;
    
    // Test Case 7
    test_in0 = 2'b11;
    test_in1 = 2'b01;
    #100;
     
    // Test Case 8
    test_in0 = 2'b00;
    test_in1 = 2'b10;
    #100;
    
    // Test Case 9
    test_in0 = 2'b01;
    test_in1 = 2'b10;
    #100;
    
    // Test Case 10
    test_in0 = 2'b10;
    test_in1 = 2'b10;
    #100;
    
    // Test Case 11
    test_in0 = 2'b11;
    test_in1 = 2'b10;
    #100;
     
    // Test Case 12
    test_in0 = 2'b00;
    test_in1 = 2'b11;
    #100;
    
    // Test Case 13
    test_in0 = 2'b01;
    test_in1 = 2'b11;
    #100;
    
    // Test Case 14
    test_in0 = 2'b10;
    test_in1 = 2'b11;
    #100;
    
    // Test Case 15
    test_in0 = 2'b11;
    test_in1 = 2'b11;
    #100;
    
    $stop;  // Stop the simulation
end
endmodule
