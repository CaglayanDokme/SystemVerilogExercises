/* File:            Comparator_1bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 10, 2021 -> Created
 * Description:     Compares 1-bit signals and detects equality.
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 1.1
 */
 
`timescale 1ns / 1ps

// IO Ports
module Comparator_1bit(
    input a,
    input b,
    output eq);

// Signal Declaration
logic p0, p1;

// Body
assign eq = p0 | p1;    // Sum of two product terms

// Product terms 
assign p0 = ~a & ~b;
assign p1 = a & b;

endmodule
