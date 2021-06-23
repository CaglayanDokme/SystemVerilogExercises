/* File:            tb_DualPort_RAM.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 23, 2021 -> Created
 * Description:     Testbench for the Dual-Port Random Access Memory module.
 */

`timescale 1ns / 1ps

module tb_DualPort_RAM;

// Local Constants
localparam DATA_W = 8;
localparam ADDR_W = 6;
localparam T = 10;  // Clock period(ns)

// Test Signals
logic clk;
logic reset;  // Active High
logic writeEnable_0 = 0;
logic writeEnable_1 = 0;
logic [ADDR_W-1 : 0] address_0   = 0;
logic [ADDR_W-1 : 0] address_1   = 0;
logic [DATA_W-1 : 0] writeData_0 = 0;
logic [DATA_W-1 : 0] writeData_1 = 0;
logic [DATA_W-1 : 0] readData_0;
logic [DATA_W-1 : 0] readData_1;

// Instantiation of Circuit Under Test
DualPort_RAM #(.DATA_W(DATA_W), .ADDR_W(ADDR_W)) DP_RAM(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Derived Constants
localparam HIGH_ADDR = 2**ADDR_W - 1;

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));

    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    #T;

    // Fill all adress space incrementally
    // Each cell will have its address as its value
    for(int i = 0; i < (HIGH_ADDR+1) / 2; ++i) begin
        writeEnable_0 <= 1'b1;
        writeEnable_1 <= 1'b1;

        address_0 <= 2*i;
        address_1 <= 2*i + 1;

        writeData_0 <= 2*i;
        writeData_1 <= 2*i + 1;

        #T;
    end
    writeEnable_0 <= 0;
    writeEnable_1 <= 0;
    #T;
    
    // Sample the data at the middle of each cycle
    @(negedge(clk));
    
    // Read all address space, starting from opposite directions
    for(int i = 0; i < (HIGH_ADDR+1) / 2; ++i) begin
        address_0 <= i;
        address_1 <= HIGH_ADDR - i;
        
        #T;
        
        if(readData_0 != i) begin
            $display("Data corrupted at index %d! Expected: %d Fetched: %d", i, i, readData_0);
            $stop;
        end
        
        if(readData_1 != HIGH_ADDR-i) begin
            $display("Data corrupted at index %d! Expected: %d Fetched: %d", HIGH_ADDR-i, HIGH_ADDR-i, readData_1);
            $stop;
        end
    end
    
    // Clock Synchronization
    @(posedge(clk));
    #T;

    $stop;
end

endmodule
