/* File:            Decoder_3bit_CaseStatement.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 12, 2021 -> Created
 * Description:     Decodes a 3-Bit signal and asserts one bit of 8-Bit output.
 *                  Designed using a case statement.
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.5(2-Bit Decoder)
 */

`timescale 1ns / 1ps

module Decoder_3bit_CaseStatement(
    input logic enable,
    input logic [2:0] n,
    output logic [7:0] decoded);
    
    always_comb
        case({enable, n})   // Concatenates enable and input signals
            4'b1000: decoded = 8'b0000_0001; 
            4'b1001: decoded = 8'b0000_0010; 
            4'b1010: decoded = 8'b0000_0100; 
            4'b1011: decoded = 8'b0000_1000; 
            4'b1100: decoded = 8'b0001_0000; 
            4'b1101: decoded = 8'b0010_0000; 
            4'b1110: decoded = 8'b0100_0000; 
            4'b1111: decoded = 8'b1000_0000; 
            default: decoded = 8'b0;
        endcase
            
endmodule
