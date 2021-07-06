`timescale 1ns / 1ps

module tb_Celsius2Fahrenheit;

// Local Constants
localparam T = 10; // Clock period(ns)

// Test Signals
logic clk = 0;             
logic reset = 0;           
logic [7:0] celsius = 0;   
logic [7:0] fahrenheit;

// Instantiation of Circuit Under Test
Celsius2Fahrenheit CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    $display("Test started!");

    // Clock Synchronization
    @(posedge(clk));
    
    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    #T;

    for(int i = 0; i < 100; ++i) begin
        @(negedge(clk));
    
        celsius <= i;
        #T;
        
        if((celsius*9)/5 + 32 != fahrenheit)
            $display("%dC != %dF ERROR", celsius, fahrenheit);
        else
            $display("%dC = %dF", celsius, fahrenheit);
    end
    
    
    $display("Test finished!");
    $stop;    
end

endmodule
