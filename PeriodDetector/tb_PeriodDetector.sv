/* File:            tb_PeriodDetector.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     Testbench for the Period Detector module. 
 */

`timescale 1ns / 1ps

module tb_PeriodDetector;

// Local Constants
localparam T = 10;  // Clock Period(ns)

// Test Signals
logic clk;            
logic reset     = 0;          
logic enable    = 0;         
logic signal    = 0;         
logic [31:00] period; 
logic valid;           

// Instantiation of Circuit Under Test
PeriodDetector CUT(.*);

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
    
    // Test Input (Period = 10T)
    enable <= 1'b1;
    #(T*3);
    
    signal <= 1'b1;
    #T;
    signal <= 1'b0;
    enable <= 1'b0;
    
    #(T*9);
    signal <= 1'b1;
    #T;
    signal <= 1'b0;
    
    wait(1'b1 == valid);
    wait(1'b0 == valid);
    
    // Test Input (Period = 5T)
    enable <= 1'b1;
    #(T*3);
    
    signal <= 1'b1;
    #T;
    signal <= 1'b0;
    enable <= 1'b0;
    
    #(T*4);
    signal <= 1'b1;
    #T;
    signal <= 1'b0;
    
    wait(1'b1 == valid);
    wait(1'b0 == valid);
    
    $stop;    
end
    
endmodule
