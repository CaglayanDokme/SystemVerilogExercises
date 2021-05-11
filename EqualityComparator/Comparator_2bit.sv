/* File:            Comparator_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 10, 2021 -> Created
 * Description:     Compares 2-bit signals and detects equality.
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 1.2 and 1.3
 */
 
`timescale 1ns / 1ps

// IO Ports
module Comparator_2bit(
    input [1:0] a,
    input [1:0] b,
    output eq);

/** Gate Level Design **/ 
/* // Signal Declarations
logic p0, p1, p2, p3;

// Body
assign eq = p0 | p1 | p2 | p3;    // Sum of four product terms

// Product terms 
assign p0 = (~a[1] & ~b[1]) & (~a[0] & ~b[0]);
assign p1 = (~a[1] & ~b[1]) & (a[0] & b[0]);
assign p2 = (a[1] & b[1])   & (~a[0] & ~b[0]);
assign p3 = (a[1] & b[1])   & (a[0] & b[0]); */

/** Structural Design **/
// Signal Declarations
logic eq0, eq1;

// 1-Bit Comparator Instantiations
Comparator_1bit Comp0(.a(a[0]), .b(b[0]), .eq(eq0));
Comparator_1bit Comp1(.a(a[1]), .b(b[1]), .eq(eq1));

assign eq = eq0 & eq1;

endmodule
