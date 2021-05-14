/* File:            BarrelShifter_Nbit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Shifts the given signal to the right according to the given shift amount
 */

`timescale 1ns / 1ps

module BarrelShifter_Nbit
#(parameter N = 8)  // N must be an exact power of 2
(
    input  logic [N-1           : 0] a,
    input  logic [$clog2(N)-1   : 0] shiftAmount,
    input  logic                     direction,     // 1: left - 0: right 
    output logic [N-1           : 0] shifted
);

// Internal Signals
logic [N-1:0] p_left  [N-1:0];
logic [N-1:0] p_right [N-1:0];

// Body
assign p_left[0]    = a;
assign p_right[0]   = a;

generate
    genvar i;
    for(i = 1; i < N; ++i) begin
        assign p_right[i] = {a[i-1 : 0],  a[N-1 : i]};
    end
    
    for(i = 1; i < N; ++i) begin
        assign p_left[i] = {a[N-1-i : 0], a[N-1 : N-i]};
    end
endgenerate

// Output Logic
assign shifted = direction ? p_left[shiftAmount] : p_right[shiftAmount]; 

endmodule
