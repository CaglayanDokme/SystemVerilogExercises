/* File:            PriorityEncoder_4bit_CaseStatement.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 12, 2021 -> Created
 * Description:     4-Bit Priority Encoder impelemented using a case statement
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.6
 */

`timescale 1ns / 1ps

module PriorityEncoder_4bit_CaseStatement(
    input [4:1] prio,
    output logic [2:0] index);
    
    always_comb
        case(prio)
            4'b1000, 4'b1001, 4'b1010, 4'b1011,
            4'b1100, 4'b1101, 4'b1110, 4'b1111: index = 3'b100;  
                      
            4'b0100, 4'b1001, 4'b1010, 4'b1011: index = 3'b011;
            
            4'b0010, 4'b0011:                   index = 3'b010;
            
            4'b0001:                            index = 3'b001; 
            
            4'b0000:                            index = 3'b000;
        endcase
endmodule
