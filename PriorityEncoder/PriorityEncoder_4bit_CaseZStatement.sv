/* File:            PriorityEncoder_4bit_CaseZStatement.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 12, 2021 -> Created
 * Description:     4-Bit Priority Encoder impelemented using a casez statement
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.7
 */

`timescale 1ns / 1ps

module PriorityEncoder_4bit_CaseZStatement(
    input [4:1] prio,
    output logic [2:0] index);
    
    always_comb
        casez(prio) // casex(prio) would also work
            4'b1???: index = 3'b100;
            4'b01??: index = 3'b011;
            4'b001?: index = 3'b010;
            4'b0001: index = 3'b001; 
            4'b0000: index = 3'b000;
        endcase
endmodule