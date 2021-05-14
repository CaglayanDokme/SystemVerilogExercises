/* File:            BarrelShifer_Nbit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Shifts the given signal to the right according to the given shift amount
 */

`timescale 1ns / 1ps

module BarrelShifer_Nbit
#(parameter N = 8)  // N must be an exact power of 2
(
    input  logic [N-1           : 0] a,
    input  logic [$clog2(N)-1   : 0] shiftAmount,
    output logic [N-1           : 0] shifted
);

// Internal Signals
logic [N-1:0] p [N-1:0];

assign p[0] = a;

/* Normal shift operator doesn't support circular shifts. 
 * So, we need to merge back the cyclic bits. 
 * As the shift direction is to the right, we shall  
 * concatenate them on the most left side of the vector. */
generate
    genvar i;
    for(i = 1; i < N; ++i) begin
        assign p[i] = (a >> i) | {(a[i-1 : 0]), {(N - i){1'b0}}};
    end
endgenerate

// Body
assign shifted = p[shiftAmount];

endmodule
