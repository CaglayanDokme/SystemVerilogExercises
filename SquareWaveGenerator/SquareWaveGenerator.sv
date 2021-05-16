/* File:            SquareWaveGenerator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 16, 2021 -> Created
 * Description:     Basic, programmable square wave generator
 */

`timescale 1ns / 1ps

module SquareWaveGenerator
#(parameter N = 4)
(
    input  logic clk,
    input  logic reset,  // Active High(Sync)
    input  logic [N-1 : 0] highCycles,
    input  logic [N-1 : 0] lowCycles,
    output logic wave
);

// Internal Signals
logic [N:0] counterReg = 0, counterReg_next;

// Body
always_ff @(posedge(clk))   // Register Logic
    if(reset)
        counterReg <= 0;
    else
        counterReg <= counterReg_next;
        
always_comb
    if((highCycles + lowCycles - 1) > counterReg)
        counterReg_next = counterReg + 1;
    else
        counterReg_next = 0;
    
// Output Logic
assign wave = ({1'b0, highCycles} > counterReg) ? 1 : 0;          

endmodule
