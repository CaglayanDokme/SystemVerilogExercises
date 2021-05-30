/* File:            tb_Binary2BCD_13Bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     Testbench for 13-Bit Binary Coded Decimal module.
 */
 
`timescale 1ns / 1ps

module tb_Binary2BCD_13Bit;

// Local Constants
localparam T = 10;  // Clock Period(ns)

// Test Signals
logic clk;             
logic reset = 0;           
logic start = 0;           
logic [12 : 00] binary = 0;
logic [15 : 00] decimal;
logic valid;

// Instantiation of Circuit Under Test
Binary2BCD_13Bit CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));
    
    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    // Load Test Value
    for(int i = 0; i < 2**13; ++i) begin
        // Clock Synchronization
        @(posedge(clk));
    
        // Load Test Value
        binary  <= i;
        start   <= 1'b1;
        #T;
        start   <= 1'b0;
        
        wait(1'b1 == valid);
        wait(1'b0 == valid);
    end
    
    $stop;
end

// Logger (TCL Console)
int value = 0;
always begin
    wait(1'b1 == valid);
    
    value   = decimal[15:12] * 1e3 
            + decimal[11:08] * 1e2 
            + decimal[07:04] * 1e1 
            + decimal[03:00] * 1e0;
            
    if(value != binary) begin
        $display("%d(Binary Input) != %d(Decimal Output)", binary, value);
        
        $stop;  // Check the TCL Console and Wave Window if the debugger hits this line
    end
    
    wait(1'b0 == valid);
end

endmodule
