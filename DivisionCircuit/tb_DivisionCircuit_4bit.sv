/* File:            tb_DivisionCircuit_4bit.sv 
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 28, 2021 -> Created
 * Description:     Testbench for the 4-Bit Division Circuit
 */
 
`timescale 1ns / 1ps

module tb_DivisionCircuit_4bit;

// Local Constans
localparam T = 10;      // Clock Period(ns)

// Test Signals
logic clk;            
logic reset = 0;                
logic load = 0;                 
logic [3:0] dividend = 0; 
logic [3:0] divisor = 0;  
logic [3:0] quotient; 
logic [3:0] remainder;
logic valid;          

// Instantiation of Circuit Under Test
DivisionCircuit_4bit CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synhronization
    @(posedge(clk));
    
    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    // Test each dividend with each divisor
    for(int i = 0; i < 2**4; ++i) begin
        for(int k = 1; k < 2**4; ++k) begin
            // Load Input Values
            dividend    <= i;
            divisor     <= k;
            load        <= 1'b1;
            
            #T;
            load        <= 1'b0;
            
            // Wait for the valid result
            wait(1'b1 == valid);
            #(T/2);
            
            // Print the calculation
            $write("%d / %d = %d ", dividend, divisor, quotient);
            $write("(%d)\t", remainder);
            
            // Check the validness of the current result
            if(dividend != (quotient * divisor) + remainder)
                $display("FALSE");
            else
                $display("");
            
            wait(1'b0 == valid);
        end
        $display("");   // Line feed
    end

    $stop;
end
endmodule
