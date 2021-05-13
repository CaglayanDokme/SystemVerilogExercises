/* File:            ReducedXorGen.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 13, 2021 -> Created
 * Description:     Applies XOR operations over all bits of the given input signal.
 *                  The output must be 1 if the number of bits is odd and vice versa.
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.12
 */

`timescale 1ns / 1ps

module ReducedXorGen
#(parameter N = 8)
(
    input [N-1 : 0] a,
    output y
);

// Internal Signals
logic [N-1 : 0] xorInternal;

// Body
assign xorInternal[0] = a[0];

generate
    genvar i;
    for(i = 1; i < N; ++i) begin
        assign xorInternal[i] = a[i] ^ xorInternal[i-1];
    end    
endgenerate

// Output Logic
assign y = xorInternal[N - 1];

endmodule
