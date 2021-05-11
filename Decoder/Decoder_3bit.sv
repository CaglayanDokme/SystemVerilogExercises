/* File:            Decoder_3bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Decodes a 3-Bit signal and asserts one bit of 8-Bit output.
 *                  Solution of an exercise from FPGA Prototyping by System Verilog Examples, Pong Chu, Exercise 2.6.2
 */

`timescale 1ns / 1ps

module Decoder_3bit(
    input enable,
    input [2:0] n,
    output [7:0] decoded);
    
logic [3:0] dec2out;

// Instantiation of 2-Bit Decoder
Decoder_2bit Dec2(.enable(enable), .n(n[1:0]), .decoded(dec2out));    
    
// Output logic
assign decoded[3:0] = {4{~n[2]}} & dec2out;
assign decoded[7:4] = {4{ n[2]}} & dec2out;
    
endmodule
