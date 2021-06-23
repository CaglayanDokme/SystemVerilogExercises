/* File:            DualPort_RAM.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 23, 2021 -> Created
 * Description:     Dual-Port Random Access Memory module.
 */

`timescale 1ns / 1ps

module DualPort_RAM
#(parameter
    DATA_W = 32,  // Data width
    ADDR_W = 10   // Address width
)
(
    input  logic clk,
    input  logic reset,  // Active High
    input  logic writeEnable_0,
    input  logic writeEnable_1,
    input  logic [ADDR_W-1 : 0] address_0,
    input  logic [ADDR_W-1 : 0] address_1,
    input  logic [DATA_W-1 : 0] writeData_0,
    input  logic [DATA_W-1 : 0] writeData_1,
    output logic [DATA_W-1 : 0] readData_0,
    output logic [DATA_W-1 : 0] readData_1
);

// Local Constants
localparam HIGH_ADDR = 2**ADDR_W - 1;

// Data Storage
logic [DATA_W-1 : 0] data [HIGH_ADDR : 0];

always_ff @ (posedge(clk)) begin
    if(reset) begin
        readData_0 <= 0;
        readData_1 <= 0;
    end
    else begin
        readData_0 <= data[address_0];
        readData_1 <= data[address_1];
    
        if(writeEnable_0)
            data[address_0] <= writeData_0;
            
        if(writeEnable_1)
            data[address_1] <= writeData_1;
    end
end

endmodule
