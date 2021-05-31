/* File:            RegisterFile_4x8.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 31, 2021 -> Created
 * Description:     4x8 Register File module. 
 */
 
`timescale 1ns / 1ps

module RegisterFile_4x8
(
    input  logic clk,
    input  logic reset,             // Active High, Synchronous reset
    input  logic writeEnable,       // Should be asserted to enable register write to given address(asynchronous)
    input  logic [1:0] readAddr,    // Read address
    input  logic [1:0] writeAddr,   // Write address(valid only if the writeEnable is asserted)
    input  logic [7:0] writeData,   // Data to be written to given address
    output logic [7:0] readData     // Data read from given read address(asynchronous)
);

// Register File
logic [7:0] regFile [3:0];

// Register Logic
always_ff @ (posedge(clk)) begin
    if(reset) begin
        regFile <= {0, 0, 0, 0};
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
