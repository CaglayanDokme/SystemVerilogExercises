/* File:            FIFO.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 15, 2021 -> Created
 *                  June 26, 2021 -> Data count, almostFull and almostEmpty signals added.
 * Description:     Parametrical FIFO module.
 */
 
 `timescale 1ns / 1ps

module FIFO
#(parameter 
    WIDTH = 32, // Data width
    DEPTH = 8   // Address width 
)
(
    input  logic clk,
    input  logic reset,
    input  logic writeEnable,
    input  logic readEnable,
    input  logic [WIDTH-1 : 0] writeData,
    output logic [WIDTH-1 : 0] readData,
    output logic full,
    output logic empty,
    output logic almostFull,        // Asserts when at least %75 of the FIFO is filled
    output logic almostEmpty,       // Asserts when at most %25 of the FIFO is filled
    output logic [DEPTH : 0] dataCount // Indicates the amount of data
);

// Local Constants
localparam HIGH_ADDR    = 2**DEPTH - 1;    // Index of highest address
localparam ALMOST_FULL  = (2**(DEPTH-2)) * 3;   // %75
localparam ALMOST_EMPTY = (2**(DEPTH-2)) * 1;   // %25

// Internal Data
logic [WIDTH-1 : 0] data [HIGH_ADDR : 0];

// Pointers
logic [DEPTH-1 : 0] writePtr = 0,   readPtr = 0,
                    writePtr_p,     readPtr_p;
                    
// Potential values of internal pointers            
always_comb begin
    // Without explicit declaration of successive values, 
    // the compiler creates a signal imlicitly. And, the width of that 
    // signal prevents comparison between actual and implicit signal
    writePtr_p  = writePtr  + 1;
    readPtr_p   = readPtr   + 1;
    
    // Calculation of the amount of data
    dataCount[DEPTH]        = full;
    dataCount[DEPTH-1 : 0]  = writePtr - readPtr;
    
    // Determination of 'almost' signals
    almostFull  = (dataCount > ALMOST_FULL  );
    almostEmpty = (dataCount < ALMOST_EMPTY );
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
