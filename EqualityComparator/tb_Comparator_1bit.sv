/* File:            tb_Comparator_1bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 10, 2021 -> Created
 * Description:     Testbench for 1-bit comparator module
 */

// The timescale directive specifies that the simulation time unit is 1ns
// and simulation timestep is 10 ps.
`timescale 1ns/10ps 

module tb_Comparator_1bit;
    // Signal Declaration
    logic test_in0, test_in1;
    logic test_out;
    
    // Instantiation of the circuit under test
    Comparator_1bit uut(.a(test_in0), .b(test_in1), .eq(test_out));
    
    // Test Vector Generation
    initial begin
        // Test Case 0
        test_in0 = 1'b0;
        test_in1 = 1'b0;
        #100;
        
        // Test Case 1
        test_in0 = 1'b1;
        test_in1 = 1'b0;
        #100;
        
        // Test Case 2
        test_in0 = 1'b0;
        test_in1 = 1'b1;
        #100;
        
        // Test Case 3
        test_in0 = 1'b1;
        test_in1 = 1'b1;
        #100;
         
    end
endmodule
