/* File:            tb_RegisterFile.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 31, 2021 -> Created
 * Description:     Testbench for the parametrical Register File module. 
 */
 
`timescale 1ns / 1ps

module tb_RegisterFile;

// Local Constants
localparam T        = 10;       // Clock Period(ns)
localparam WIDTH    = 32;       // Individual register width
localparam DEPTH    = 5;        // Address width (2**DEPTH registers in total)

// Test Signals
logic clk;            
logic reset             = 0;          
logic writeEnable       = 0;    
logic [DEPTH-1 : 0] readAddr    = 0; 
logic [DEPTH-1 : 0] writeAddr   = 0;
logic [WIDTH-1 : 0] writeData   = 0;
logic [WIDTH-1 : 0] readData;

// Instantiation of Circuit Under Test
RegisterFile #(.WIDTH(WIDTH), .DEPTH(DEPTH)) CUT(.*);

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
    
    // Write to each register
    writeEnable <= 1'b1;
    for(int i = 0; i < 2**DEPTH; ++i) begin
        writeAddr <= i;
        writeData <= i + 1;
        #T;
    end
    writeEnable <= 1'b0;
    
    // Read each register and compare
    for(int i = 0; i < 2**DEPTH; ++i) begin
        readAddr <= i;
        #T;
                
        if(readData != i+1) begin
            $display("Data Corrupted! Expected: %d Read: %d", i+1, readData);
            $stop;
        end
        
        #T;
    end
    
    $stop;
end

endmodule
