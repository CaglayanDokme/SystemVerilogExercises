/* File:            tb_Binary2BCD.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     Testbench for parametrical width Binary Coded Decimal converter module.
 */

`timescale 1ns / 1ps

module tb_Binary2BCD;

// Local Constants
localparam T        = 10;   // Clock Period(ns)
localparam WIDTH    = 20;   // Binary input width
localparam DIGITS   = 6;    // BCD output width in bits

// Test Signals
logic clk;             
logic reset = 0;           
logic start = 0;           
logic [WIDTH-1  : 00] binary = 0;
logic [4*DIGITS-1 : 00] decimal;
logic valid;

// Instantiation of Circuit Under Test
Binary2BCD #(.WIDTH(WIDTH), .DIGITS(DIGITS)) CUT(.*);

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
    for(int i = 0; i < 2**WIDTH; ++i) begin
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
logic [03 : 00] bcdTest [DIGITS-1 : 00];
generate
    for(genvar i = 0; i < DIGITS; ++i) begin
        assign bcdTest[i] = decimal[(4*(i+1))-1 : 4*i];
    end
endgenerate

int value = 0;
always begin
    wait(1'b1 == valid);
    #(T/2);
    
    // Convert current BCD value to an integer
    value = 0;
    for(int i = 0; i < DIGITS; ++i) begin
        value = value + (bcdTest[i] * (10**i));     
    end
            
    // Compare the produced value with the given input
    if(value != binary) begin
        $display("%d(Binary Input) != %d(Decimal Output)", binary, value);
        
        $stop;  // Check the TCL Console and Wave Window if the debugger hits this line
    end
    
    wait(1'b0 == valid);
end

endmodule
