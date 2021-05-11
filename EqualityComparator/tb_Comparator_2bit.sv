/* File:            tb_Comparator_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 10, 2021 -> Created
 * Description:     Testbench for 2-bit comparator module
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 1.7
 *                  The original code has less test cases.
 */

// The timescale directive specifies that the simulation time unit is 1ns
// and simulation timestep is 10 ps.
`timescale 1ns/10ps 

module tb_Comparator_2bit;
    // Signal Declarations
    logic [1:0] test_in0, test_in1;
    logic test_out;
    
    // Instantiation of the circuit under test
    Comparator_2bit uut(.a(test_in0), .b(test_in1), .eq(test_out));
    
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
