/* File:            ROM_withFile.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 31, 2021 -> Created
 * Description:     Parametrical ROM module with file initialization. 
 */

`timescale 1ns / 1ps

module ROM_withFile
#(parameter
    WIDTH = 8,
    DEPTH = 4   
)
(  
    input  logic [DEPTH-1 : 0] readAddr,
    output logic [WIDTH-1 : 0] readData 
);

// Data Storage
logic [WIDTH-1 : 0] data [2**DEPTH-1 : 0];

// Read data from file initially
initial
    $readmemb("RO_Data.mem", data);
    
assign readData = data[readAddr];

endmodule
