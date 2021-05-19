/* File:            tb_PWM_Generator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 19, 2021 -> Created
 * Description:     Testbench for programmable PWM Signal Generator
 */

`timescale 1ns / 1ps

module tb_PWM_Generator;

// Local Constants
localparam N = 3;
localparam T = 10;  // Nanoseconds

// Test Signals
logic clk = 0;
logic reset = 0;
logic [N-1 : 0] dutyCycle = 0;
logic pwmSignal;

// Instantiation of Circuit Under Test
PWM_Generator #(.N(N)) PWM_Gen(.*);

// Clock Generation
always begin
    clk = 1'b0; #(T/2);
    clk = 1'b1; #(T/2);
end

// Test Scenario
initial begin
    // Clock Synchronization
    @(posedge(clk));

    // Reset Initially
    reset = 1'b1;
    #T;
    reset = 1'b0;
    
    for(int i = 0; i < 2**N; ++i) begin
        dutyCycle = i;
        
        #(T * 2**N * 3);    // Wait for 3 complete waves
    end
    
    $stop;
end

endmodule
