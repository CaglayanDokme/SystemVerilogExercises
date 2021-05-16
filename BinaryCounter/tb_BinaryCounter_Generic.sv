/* File:            tb_BinaryCounter_Generic.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Testbench for generic binary counter module
 */

`timescale 1ns / 1ps

module tb_BinaryCounter_Generic;

// Local Constants
localparam N = 4;       // Circuit Width
localparam T = 10;      // Nanoseconds

// Test Signals
logic clk;                                    
logic reset;                                  
logic syncClear;  
logic load;       
logic enable;     
logic upCount;    
logic [N-1 : 0] loadValue;                    
logic maxTick;                                
logic minTick;                                
logic [N-1 : 0] counterValue;       

// Instantiation of Circuit Under Test
BinaryCounter_Generic #(.N(N)) BinaryCounter(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    // Synchronize with Clock
    @(posedge(clk));
    
    // Initial Values of Signals
    syncClear   = 1'b0;
    load        = 1'b0;   
    enable      = 1'b0; 
    upCount     = 1'b0;
    loadValue   = 0;
    
    // Reset Initially
    reset = 1'b1;
    #T;
    reset = 1'b0;
    
    // Disable Module for a while
    enable = 1'b0;
    #(T * 3);
    
    // Normal Mode(Starts from 0, Upcount)
    syncClear   = 1'b1;     // Clear internal counter
    #T;
    syncClear   = 1'b0;
    
    load        = 1'b1;     // Load the minimum value
    loadValue   = {N{1'b0}};
    #T;   
    load        = 1'b0;
    
    enable  = 1'b1;
    upCount = 1'b1;
    
    wait(1 == maxTick);     // Wait until maxTick asserts
    enable  = 1'b0;
    upCount = 1'b0;
    #T;
    
    // Normal Mode(Starts from maxValue, Downcount)
    syncClear   = 1'b1;     // Clear internal counter
    #T;
    syncClear   = 1'b0;
    
    load        = 1'b1;     // Load the maximum value
    loadValue   = {N{1'b1}};
    #T;  
    load        = 1'b0; 
    
    enable  = 1'b1;
    upCount = 1'b0;
    
    wait(1 == minTick);     // Wait until minTick asserts
    enable  = 1'b0;
    #T;
    
    // Load an Intermediate Value (Upcount)    
    syncClear   = 1'b1;     // Clear internal counter
    #T;
    syncClear   = 1'b0;
    
    load        = 1'b1;     // Load a random value
    loadValue   = {1'b0, {(N-1){1'b1}}};
    #T;  
    load        = 1'b0; 
    
    enable  = 1'b1;
    upCount = 1'b1;
    
    wait(1 == maxTick);     // Wait until maxTick asserts
    enable  = 1'b0;
    upCount = 1'b0;
    #T;
    
    // Load an Intermediate Value (Downcount) 
    syncClear   = 1'b1;     // Clear internal counter
    #T;
    syncClear   = 1'b0;
    
    load        = 1'b1;     // Load a random value
    loadValue   = {1'b0, {(N-1){1'b1}}};
    #T;  
    load        = 1'b0; 
    
    enable  = 1'b1;
    upCount = 1'b0;
    
    wait(1 == minTick);     // Wait until minTick asserts
    enable  = 1'b0;
    #T;
    
    #T;
    $stop;
end

endmodule
