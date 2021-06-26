/* File:            SimpleDualPort_RAM.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 25, 2021 -> Created
 * Description:     Simple Dual-Port Random Access Memory module.
 */
 
`timescale 1ns / 1ps

module SimpleDualPort_RAM
#(parameter
    DATA_W = 32,
    ADDR_W = 8
)
(
    input  logic clk,
    input  logic reset, // Active High
    input  logic writeEnable,
    input  logic [ADDR_W-1 : 0]readAddress,
    input  logic [ADDR_W-1 : 0]writeAddress,
    input  logic [DATA_W-1 : 0]writeData,
    output logic [DATA_W-1 : 0]readData
);

// Local Constants
localparam HIGH_ADDR = 2**ADDR_W - 1;

// Data Storage
logic [DATA_W-1 : 0] data [HIGH_ADDR : 0];

// Register Logic
always_ff @ (posedge(clk)) begin
    if(reset) begin
        readData <= 0;
    end
    else begin
        if(writeEnable)
            data[writeAddress] <= writeData;
            
        readData <= data[readAddress];
    end
end

endmodule
