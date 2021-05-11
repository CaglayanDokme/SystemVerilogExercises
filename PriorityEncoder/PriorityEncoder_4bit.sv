/* File:            PriorityEncoder_4bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     4-Bit Priority Encoder
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.3
 */

`timescale 1ns / 1ps

module PriorityEncoder_4bit(
    input logic [4:1] prio,
    output logic [2:0] index);
    
always_comb
    if(prio[4])
        index = 3'b100;
    else if(prio[3])
        index = 3'b011;
    else if(prio[2])
        index = 3'b010;
    else if(prio[1])
        index = 3'b001;
    else
        index = 3'b000;

endmodule
