/* File:            GreaterThan_4bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Compares 4-bit signals and asserts if the former one is greater.
 *                  Solution of an exercise from FPGA Prototyping by System Verilog Examples, Pong Chu, Exercise 2.6.1
 */

`timescale 1ns / 1ps

module GreaterThan_4bit(
    input [3:0] a, b,
    output greater);

// Signal Declarations
logic HG, LG, HEQ, LEQ;

// Instantiations of Comparator Circuits
GreaterThan_2bit greaterH(.a(a[3:2]), .b(b[3:2]), .greater(HG));
GreaterThan_2bit greaterL(.a(a[1:0]), .b(b[1:0]), .greater(LG));
Comparator_2bit equalityH(.a(a[3:2]), .b(b[3:2]), .eq(HEQ));
Comparator_2bit equalityL(.a(a[1:0]), .b(b[1:0]), .eq(LEQ));
    
// Body
assign greater = HG | (~HG & HEQ & LG);    // Sum of product terms
    
endmodule
