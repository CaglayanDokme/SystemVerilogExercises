/* File:            FIFO_8Words.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 15, 2021 -> Created
 * Description:     8-Word FIFO module.
 */
 
 `timescale 1ns / 1ps

module FIFO_8Words
(
    input  logic clk,
    input  logic reset,
    input  logic writeEnable,
    input  logic readEnable,
    input  logic [31:0] writeData,
    output logic [31:0] readData,
    output logic full,
    output logic empty
);

// Internal Data
logic [31:0] data [7:0];

// Pointers
logic [2:0] writePtr = 0,   readPtr = 0,
            writePtr_p,     readPtr_p;
            
// Potential values of internal pointers            
always_comb begin
    // Without explicit declaration of successive values, 
    // the compiler creates a signal imlicitly. And, the width of that 
    // signal prevents comparison between actual and implicit signal
    writePtr_p  = writePtr  + 1;
    readPtr_p   = readPtr   + 1;
end            

// Register Logic
always_ff @ (posedge(clk)) begin
    if(reset) begin        
        writePtr    <= 0;
        readPtr     <= 0;
        empty       <= 1'b1;
        full        <= 1'b0;
    end
    else begin
        // Write Logic
        if(writeEnable && ~full) begin
            data[writePtr]  <= writeData;
            writePtr        <= writePtr + 1;
            empty           <= 1'b0;
            
            // Determine if full
            // Handles the simultaneous read and write operations also
            if((writePtr_p == readPtr) && !readEnable) begin    
                full <= 1'b1;
            end
        end
        
        // Read Logic
        if(readEnable && ~empty) begin
            readPtr     <= readPtr + 1;
            full        <= 1'b0;
            
            // Determine if empty
            // Handles the simultaneous read and write operations also
            if((readPtr_p == writePtr) && !writeEnable) begin
                empty <= 1'b1;
            end
        end
    end
end

// Output Logic
assign readData = data[readPtr];

endmodule
