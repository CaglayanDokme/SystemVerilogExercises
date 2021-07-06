`timescale 1ns / 1ps

module Celsius2Fahrenheit
(
    input  logic clk,
    input  logic reset,
    input  logic [7:0] celsius,
    output logic [7:0] fahrenheit   
);

// ROM as conversion table
logic [7:0] conversionTable [99 : 0];

// Read conversion table from file initially
initial
    $readmemb("ConversionTable.mem", conversionTable);

always @ (posedge(clk)) begin
    if(reset) begin
        fahrenheit <= 0;
    end    
    else begin
        if(celsius < 100)
            fahrenheit <= conversionTable[celsius];
        else
            fahrenheit <= 0;        
    end
end

endmodule
