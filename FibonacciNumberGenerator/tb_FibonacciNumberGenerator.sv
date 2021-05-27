/* File:            tb_FibonacciNumberGenerator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 27, 2021 -> Created
 * Description:     Testbench for parametrical width Fibonacci Nubmer Generator module.
 *                  Test results can be seen at TCL Console.
 */

`timescale 1ns / 1ps

module tb_FibonacciNumberGenerator;

// Local Constans
localparam T = 10;      // Clock Period(ns)
localparam WIDTH = 8;   // Circuit Width

// Test Signals
logic clk;                   
logic reset = 1'b0;                 
logic start = 1'b0;                 
logic valid;     
logic overflowed;            
logic [WIDTH-1 : 0] fibNumber;

// Instantiation of Circuit Under Test
FibonacciNumberGenerator #(.WIDTH(WIDTH)) CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Variables
int i = 0;

// Test Scenario
initial begin
    // Clock Synhronization
    @(posedge(clk));
    
    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    // Start Generation
    $display("Starting..");
    
    start <= 1'b1;    
    wait(valid == 1'b1);
    
    // Display results until overflows
    while(1) begin
        #(T/2); // Sample the signal at its mid-point
        
        if(valid) 
            $write("Index %d: %d", i++, fibNumber);
        
        if(overflowed) begin
            $display("Overflow!");
            break;
        end
        else begin
            $display("");
        end
        
        #(T/2);
    end
    
    wait(overflowed == 1'b0); // Wait until overflow deasserts
    
    // Display results until overflows
    while(1) begin
        #(T/2); // Sample the signal at its mid-point
        
        if(valid) 
            $write("Index %d: %d", i++, fibNumber);
        
        if(overflowed) begin
            $display("Overflow!");
            break;
        end
        else begin
            $display("");
        end
        
        #(T/2);
    end
    
    $display("Test finished!");
    
    $stop;
end

endmodule
