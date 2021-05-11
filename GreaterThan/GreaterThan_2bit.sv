/* File:            GreaterThan_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Compares 2-bit signals and asserts if the former one is greater.
 *                  Solution of an exercise from FPGA Prototyping by System Verilog Examples, Pong Chu, Exercise 2.6.1
 */

`timescale 1ns / 1ps

module GreaterThan_2bit(
    input [1:0] a, b,
    output greater);
    
// Signal Declarations
logic p0, p1, p2;

// Body
assign greater = p0 | p1 | p2;    // Sum of product terms

// Product terms (Derived from the truth table)
assign p0 = a[0] & ~a[1] & ~b[0] & ~b[1];
assign p1 = a[0] & a[1] & ~b[0] & b[1];
assign p2 = a[1] & ~b[1];
    
endmodule
