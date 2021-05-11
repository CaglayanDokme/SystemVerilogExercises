/* File:            Decoder_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Decodes a 2-Bit signal and asserts one bit of 4-Bit output.
 *                  Solution of an exercise from FPGA Prototyping by System Verilog Examples, Pong Chu, Exercise 2.6.2
 */

`timescale 1ns / 1ps

module Decoder_2bit(
    input enable,
    input [1:0] n,
    output [3:0] decoded);
    
// Output Logic    
assign decoded[0] = enable & ~n[1] & ~n[0];
assign decoded[1] = enable & ~n[1] &  n[0];
assign decoded[2] = enable &  n[1] & ~n[0];
assign decoded[3] = enable &  n[1] &  n[0];
    
endmodule
