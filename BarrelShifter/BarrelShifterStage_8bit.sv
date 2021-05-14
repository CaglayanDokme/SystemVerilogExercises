/* File:            BarrelShiferStage_8bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Shifts the given signal to the right according to the given shift amount
 *                  Implemented with multiple internal stages to get rid of the case statements.
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.19
 */

`timescale 1ns / 1ps

module BarrelShiferStage_8bit
(
    input  logic [7:0] a,
    input  logic [2:0] shiftAmount,
    output logic [7:0] shifted
);

// Internal Signals
logic [7:0] s0, s1;

// Body
assign s0       = shiftAmount[0] ? {a[0], a[7:1]}     : a;  // Shift 0 or 1 bit (Stage 0)
assign s1       = shiftAmount[1] ? {s0[1:0], s0[7:2]} : s0; // Shift 0 or 2 bit (Stage 1)
assign shifted  = shiftAmount[2] ? {s1[3:0], s1[7:4]} : s1; // Shift 0 or 4 bit (Stage 2)

endmodule
