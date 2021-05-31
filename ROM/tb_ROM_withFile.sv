/* File:            tb_ROM_withFile.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 31, 2021 -> Created
 * Description:     Testbench for the parametrical ROM module with file initialization. 
 */
 
`timescale 1ns / 1ps

module tb_ROM_withFile;

// Local Constants
localparam WIDTH = 8;
localparam DEPTH = 8;  

// Test Signals
logic [DEPTH-1 : 0] readAddr;
logic [WIDTH-1 : 0] readData;

// Instantiation of Circuit Under Test
ROM_withFile #(.WIDTH(WIDTH), .DEPTH(DEPTH)) CUT(.*);

// Test Scenario
initial begin
    for(int i = 0; i < 2**DEPTH; ++i) begin
        readAddr <= i;
        #1;
        
        if(i != readData) begin 
            $display("Data read is wrong! Expected: %d Read: %d", i, readData);
            $stop;  // Abort
        end       
    end
    
    $stop;  // End of the test
end

endmodule
