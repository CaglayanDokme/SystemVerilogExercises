/* File:            tb_Debouncer.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 23, 2021 -> Created
 * Description:     Testbench for parametrical debouncer module.
 */

`timescale 1ns / 1ps

module tb_Debouncer;

// Local Constants
localparam T = 10;  // Nanoseconds
localparam SAFE_CYCLES = 1;

// Test Signals
logic clk;
logic reset             = 1'b0;     // Active High
logic bouncingSignal    = 1'b0;
logic debounced;

// Instantiation of Circuit Under Test
Debouncer #(.SAFE_CYCLES(SAFE_CYCLES)) CUT(.*);

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
    
    #100;
    
    // Bounce Every Cycle
    for(int i = 0; i < SAFE_CYCLES * 2; ++i) begin
        bouncingSignal <= ~bouncingSignal;
        
        #T;
    end
    
    bouncingSignal <= 1'b0;
    #100;
    
    // Bounce Every 2 Cycles
    for(int i = 0; i < SAFE_CYCLES * 2; ++i) begin
        if(i % 2)
            bouncingSignal <= ~bouncingSignal;
        
        #T;
    end
    
    bouncingSignal <= 1'b0;
    #100;
    
    // Bounce at the end
    for(int i = 0; i < SAFE_CYCLES-1; ++i) begin
        bouncingSignal <= 1'b1;
        #T;
    end
    bouncingSignal <= 1'b0;
    #T;
        
    bouncingSignal <= 1'b0;
    #100;
    
    // Do not bounce
    for(int i = 0; i < SAFE_CYCLES*2; ++i) begin
        bouncingSignal <= 1'b1;
        #T;
    end    
    
    // Bounce Every Cycle
    for(int i = 0; i < SAFE_CYCLES * 2; ++i) begin
        bouncingSignal <= ~bouncingSignal;
        
        #T;
    end
    
    bouncingSignal <= 1'b1;
    #100;
    
    // Bounce Every 2 Cycles
    for(int i = 0; i < SAFE_CYCLES * 2; ++i) begin
        if(i % 2)
            bouncingSignal <= ~bouncingSignal;
        
        #T;
    end
    
    bouncingSignal <= 1'b1;
    #100;
    
    // Do not bounce
    for(int i = 0; i < SAFE_CYCLES*2; ++i) begin
        bouncingSignal <= 1'b0;
        #T;
    end    
    
    $stop;
end

endmodule
