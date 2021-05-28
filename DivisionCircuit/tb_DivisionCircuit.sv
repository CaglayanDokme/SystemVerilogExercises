/* File:            tb_DivisionCircuit.sv 
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 28, 2021 -> Created
 * Description:     Testbench for parametrical width Division Circuit
 */

`timescale 1ns / 1ps

module tb_DivisionCircuit;

// Local Constans
localparam T        = 10;      // Clock Period(ns)
localparam WIDTH    = 3;

// Test Signals
logic clk;            
logic reset = 0;                
logic load  = 0;                 
logic [WIDTH-1 : 0] dividend    = 0; 
logic [WIDTH-1 : 0] divisor     = 0;  
logic [WIDTH-1 : 0] quotient; 
logic [WIDTH-1 : 0] remainder;
logic valid;          
logic divisionByZero;

// Instantiation of Circuit Under Test
DivisionCircuit #(.WIDTH(WIDTH)) CUT(.*);

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
    for(int i = 0; i < 2**WIDTH; ++i) begin
        for(int k = 0; k < 2**WIDTH; ++k) begin
            // Clock Synhronization
            @(posedge(clk));
            
            // Load Input Values
            dividend    <= i;
            divisor     <= k;
            
            load        <= 1'b1;
            #T;
            load        <= 1'b0;
            
            // Wait for the valid result or Division-by-0 exception
            wait((1'b1 == valid) || (1'b1 == divisionByZero));
            
            // Wait for IDLE state
            wait((1'b0 == valid) && (1'b0 == divisionByZero));
        end
        $display("");   // Line feed
    end

    $stop;
end

// Logger(TCL Console)
always begin
    wait(1'b1 == valid);
    
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

// Division-by-0 Detector(TCL Console)
always begin
    wait(1'b1 == divisionByZero);

    // Check for Division-by-0 error
    if(divisionByZero) begin
        $write("%d / %d = NaN \t", dividend, divisor);
        $display("Divison-by-0 exception!");
    end
    
    wait(1'b0 == divisionByZero);
end

endmodule
