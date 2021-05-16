/* File:            tb_BinaryCounter_Basic.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Testbench for Simple binary counter
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 4.11
 */

`timescale 1ns / 1ps

module tb_BinaryCounter_Basic;

// Local Constants
localparam N = 4;       // Circuit Width
localparam T = 10;      // Nanoseconds

// Test Signals
logic clk;
logic reset;
logic maxTick;
logic [N-1 : 0] counterValue;

// Instantiation of Circuit Under Test
BinaryCounter_Basic #(.N(N)) BinaryCounter(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T / 2);
    clk = 1'b0; #(T / 2);
end

// Test Scenario
initial begin
    // Synchronization with Clock
    @(posedge(clk));

    // Reset Initially
    reset = 1'b1;
    #T;
    reset = 1'b0;
    
    // Wait For MaxTick Signal (2 Times)
    #(2**(N + 1) * T);
    
    $stop;      
end

endmodule
