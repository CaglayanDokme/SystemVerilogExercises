/* File:            Adder_Nbit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 13, 2021 -> Created
 * Description:     Adds two N-Bit signals and produces an N-Bit signal and a 1-Bit carry signal 
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.10
 */

`timescale 1ns / 1ps

module Adder_Nbit
#(parameter N = 4)  // Parameter can be changed when instantiating
(
    // Inputs
    input logic [N - 1:0] a,
    input logic [N - 1:0] b,
    
    // Outputs
    output logic [N - 1:0] sum, 
    output logic carryOut
);
    
// Internal Signals
logic [N:0] sumInternal;

// Body
assign sumInternal  = {1'b0, a} + {1'b0, b};
assign sum          = sumInternal[N - 1:0];
assign carryOut     = sumInternal[N];

endmodule
