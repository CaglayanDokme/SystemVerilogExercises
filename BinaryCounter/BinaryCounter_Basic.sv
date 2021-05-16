/* File:            BinaryCounter_Basic.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Simple binary counter
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 4.11
 */

`timescale 1ns / 1ps

module BinaryCounter_Basic
#(parameter N = 8)
(
    input  logic clk, 
    input  logic reset,
    output logic maxTick,
    output logic [N-1 : 0] counterValue
);

// Internal Signals
logic [N-1 : 0] counterReg, counterReg_next;

// Body
always_ff @(posedge(clk), posedge(reset))   // Register Logic
    if(reset)
        counterReg <= 0;
    else
        counterReg <= counterReg_next;

always_comb     // Next-State Logic
    counterReg_next = counterReg + 1; 
        
// Output Logic
assign counterValue = counterReg;
assign maxTick      = (2**N - 1 == counterReg) ? 1 : 0;

endmodule
