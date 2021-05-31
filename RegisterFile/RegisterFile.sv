/* File:            RegisterFile.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 31, 2021 -> Created
 * Description:     Parametrical Register File module. 
 */
 
`timescale 1ns / 1ps

module RegisterFile
#(parameter 
    WIDTH = 32,     // Individual register width
    DEPTH = 5       // Address width (2**DEPTH registers in total)
)
(
    input  logic clk,
    input  logic reset,                     // Active High, Synchronous reset
    input  logic writeEnable,               // Should be asserted to enable register write to given address(asynchronous)
    input  logic [DEPTH-1 : 0] readAddr,    // Read address
    input  logic [DEPTH-1 : 0] writeAddr,   // Write address(valid only if the writeEnable is asserted)
    input  logic [WIDTH-1 : 0] writeData,   // Data to be written to given address
    output logic [WIDTH-1 : 0] readData     // Data read from given read address(asynchronous)
);

// Register File
logic [WIDTH-1 : 0] regFile [(2**DEPTH)-1 : 0];

// Register Logic
always_ff @ (posedge(clk)) begin
    if(reset) begin
        for(int i = 0; i < 2**DEPTH; ++i) begin
            regFile[i] <= 0;
        end
    end
    else begin
        // Data is written to register file only if the writeEnable signal is asserted
        if(writeEnable) begin
            regFile[writeAddr] <= writeData;
        end  
    end
end

// Output Logic
assign readData = regFile[readAddr];

endmodule
