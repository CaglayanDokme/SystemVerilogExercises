/* File:            DualPriorityEncoder_15bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     15-Bit Dual-Priority Encoder
 */

`timescale 1ns / 1ps

module DualPriorityEncoder_15bit
(
    input  logic [15:01] req,
    output logic [03:00] first,
    output logic [03:00] second
);

// Internal Signals
logic [15:1] reqSecond;

// Instantiation of Single-Priority Encoder
PriorityEncoder_15bit PE(.req(reqSecond), .index(second));

always_comb
    if(req[15]) begin
        first       = 4'd15;                // First 1 found
        reqSecond   = {1'b0, req[14:1]};    // Start searching after the first one
    end
    else if(req[14]) begin
        first       = 4'd14;
        reqSecond   = {2'b0, req[13:1]};
    end    
    else if(req[13]) begin
        first       = 4'd13;
        reqSecond   = {3'b0, req[12:1]};
    end    
    else if(req[12]) begin
        first       = 4'd12;
        reqSecond   = {4'b0, req[11:1]};
    end    
    else if(req[11]) begin
        first       = 4'd11;
        reqSecond   = {5'b0, req[10:1]};
    end    
    else if(req[10]) begin
        first       = 4'd10;
        reqSecond   = {6'b0, req[9:1]};
    end    
    else if(req[9]) begin
        first       = 4'd9;
        reqSecond   = {7'b0, req[8:1]};
    end    
    else if(req[8]) begin
        first       = 4'd8;
        reqSecond   = {8'b0, req[7:1]};
    end    
    else if(req[7]) begin
        first       = 4'd7;
        reqSecond   = {9'b0, req[6:1]};
    end    
    else if(req[6]) begin
        first       = 4'd6;
        reqSecond   = {10'b0, req[5:1]};
    end    
    else if(req[5]) begin
        first       = 4'd5;
        reqSecond   = {11'b0, req[4:1]};
    end    
    else if(req[4]) begin
        first       = 4'd4;
        reqSecond   = {12'b0, req[3:1]};
    end    
    else if(req[3]) begin
        first       = 4'd3;
        reqSecond   = {13'b0, req[2:1]};
    end    
    else if(req[2]) begin
        first       = 4'd2;
        reqSecond   = {14'b0, req[1]};
    end    
    else if(req[1]) begin
        first       = 4'd1;
        reqSecond   = 15'b0;
    end    
    else begin
        first       = 4'd0;
        reqSecond   = 15'b0;
    end    
endmodule
