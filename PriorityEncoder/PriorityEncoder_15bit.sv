/* File:            PriorityEncoder_15bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     15-Bit Priority Encoder
 */

`timescale 1ns / 1ps

module PriorityEncoder_15bit
(
    input  logic [15 : 1] req,
    output logic [03 : 0] index
);
    
always_comb
    if(req[15])
        index = 4'd15;
    else if(req[14])
        index = 4'd14;
    else if(req[13])
        index = 4'd13;
    else if(req[12])
        index = 4'd12;
    else if(req[11])
        index = 4'd11;
    else if(req[10])
        index = 4'd10;
    else if(req[9])
        index = 4'd9;
    else if(req[8])
        index = 4'd8;
    else if(req[7])
        index = 4'd7;
    else if(req[6])
        index = 4'd6;
    else if(req[5])
        index = 4'd5;
    else if(req[4])
        index = 4'd4;
    else if(req[3])
        index = 4'd3;
    else if(req[2])
        index = 4'd2;
    else if(req[1])
        index = 4'd1;
    else
        index = 4'd0;

endmodule
