/* File:            tb_FIFO_8Words.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            June 15, 2021 -> Created
 * Description:     Testbench for 8-Word FIFO module.
 */

`timescale 1ns / 1ps

module tb_FIFO_8Words;

// Test Constants
localparam T = 10;  // Nanoseconds

// Test Signals
logic clk;             
logic reset = 0;           
logic writeEnable = 0;     
logic readEnable = 0;      
logic [31:0] writeData = 0;
logic [31:0] readData; 
logic full;            
logic empty;

// Instantiation of Circuit Under Test
FIFO_8Words CUT(.*);

// Clock Generation
always begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));
    
    // Reset Initially
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    #T;
    
    // Write Until Full
    for(int i = 0; (i < 8) && !full; ++i) begin
        writeData   <= i;
        writeEnable <= 1'b1;
        #T;
    end
    writeEnable <= 1'b0;
    #T;
    
    if(!full) begin
        $display("FIFO needed to be full! Aborting the test.");
        $stop;  // Abort
    end
    
    // Read unless empty
    for(int i = 0; (i < 8) && !empty; ++i) begin
        // Simulation cannot handle sampling of a signal during the setup time of the clock
        // To avoid data race, we just have to sample the data right at the half point of a clock
        @(negedge(clk));     
        
        if(readData != i) begin
            $display("Data read(%d) is not valid, idx:%d! Aborting the test.", readData, i);
            $stop;  // Abort
        end
        
        readEnable <= 1'b1;
        #T;  
    end
    readEnable <= 1'b0;
    #T;  
    
    if(!empty) begin
        $display("FIFO needed to be empty! Aborting the test.");
        $stop;  // Abort
    end
    
    @(posedge(clk));   // Synchronize again
    
    // Write and Read at the same time while empty
    writeData   <= 32'hAA;
    writeEnable <= 1'b1;
    readEnable  <= 1'b1;
    #T;
    writeEnable <= 1'b0;
    readEnable  <= 1'b0;
    #T;
    
    writeData   <= 32'hBB;
    writeEnable <= 1'b1;
    readEnable  <= 1'b1;
    #T;
    writeEnable <= 1'b0;
    readEnable  <= 1'b0;
    #T;
    
    if(empty) begin
        $display("FIFO needed not to be empty! Aborting the test.");
        $stop;  // Abort
    end
    
    // Reset Again
    reset <= 1'b1;
    #T;
    reset <= 1'b0;
    
    // Fill completely
    for(int i = 0; (i < 8) && !full; ++i) begin
        writeData   <= i;
        writeEnable <= 1'b1;
        #T;
    end
    writeEnable <= 1'b0;
    #T;
    
    if(!full) begin
        $display("FIFO needed to be full! Aborting the test.");
        $stop;  // Abort
    end
        
    // Write and Read at the same time while full
    writeData   <= 32'hAA;
    writeEnable <= 1'b1;
    readEnable  <= 1'b1;
    #T;
    writeEnable <= 1'b0;
    readEnable  <= 1'b0;
    #T;
    
    writeData   <= 32'hBB;
    writeEnable <= 1'b1;
    readEnable  <= 1'b1;
    #T;
    writeEnable <= 1'b0;
    readEnable  <= 1'b0;
    #T;
    
    if(full) begin
        $display("FIFO needed not to be full! Aborting the test.");
        $stop;  // Abort
    end
        
    $stop;
end

endmodule
