/* File:            tb_SimpleDualPort_RAM.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 25, 2021 -> Created
 * Description:     Testbench for the Simple Dual-Port Random Access Memory module.
 */
 
`timescale 1ns / 1ps

module tb_SimpleDualPort_RAM;

// Local Constants
localparam T        = 10;  // Clock Period(ns)
localparam DATA_W   = 8;
localparam ADDR_W   = 6;

// Test Signals
logic clk;                       
logic reset = 0; // Active High      
logic writeEnable = 0;               
logic [ADDR_W-1 : 0]readAddress     = 0; 
logic [ADDR_W-1 : 0]writeAddress    = 0;
logic [DATA_W-1 : 0]writeData       = 0;   
logic [DATA_W-1 : 0]readData;   

// Instantiation of Circuit Under Test
SimpleDualPort_RAM #(.DATA_W(DATA_W), .ADDR_W(ADDR_W)) CUT(.*);

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
    #T;
    
    // Fill all cells incrementally
    for(int i = 0; i < 2**ADDR_W; ++i) begin
        writeEnable     <= 1'b1;
        writeAddress    <= i;
        writeData       <= i;
        
        #T;
    end
    writeEnable <= 1'b0;
    #T;
        
    $stop;
end

initial begin
    wait(1'b1 == writeEnable);
    #(T * 2);   
    
    @(negedge(clk));    // Sample the signal at the middle of the current cycle
    for(int i = 0; i < 2**ADDR_W; ++i) begin
        readAddress <= i;        
        #T;
        
        if(readData != i) begin
            $display("Data corrupted at address %d! Expected: %d Read: %d", i, i, readData);
            
            $stop;
        end
    end
end

endmodule
