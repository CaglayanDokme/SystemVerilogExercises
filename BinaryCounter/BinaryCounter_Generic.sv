/* File:            BinaryCounter_Generic.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Generic binary counter
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 4.12
 */

`timescale 1ns / 1ps

module BinaryCounter_Generic
#(parameter N = 8)
(
    input  logic clk,
    input  logic reset,                 // Active High(Async)
    input  logic syncClear,             // Active High(Sync)
    input  logic load,                  // 1: Load, 0: No operation
    input  logic enable,                // 1: Enable, 0: Disable
    input  logic upCount,               // 1: Upcount, 0: Downcount
    input  logic [N-1 : 0] loadValue,
    output logic maxTick,
    output logic minTick,
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
        
always_comb     // Next State Logic
    if(syncClear)
        counterReg_next = 0;
    else if(load)
        counterReg_next = loadValue;
    else if(enable & upCount)           // Upcount
        counterReg_next = counterReg + 1;
    else if(enable & ~upCount)          // Downcount
        counterReg_next = counterReg - 1;
    else
        counterReg_next = counterReg;   // Save current status
        
// Output Logic
assign maxTick      = ((2**N - 1) == counterReg) ? 1 : 0;
assign minTick      = (0          == counterReg) ? 1 : 0;
assign counterValue = counterReg;      

endmodule
