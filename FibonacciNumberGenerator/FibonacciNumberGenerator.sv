/* File:            FibonacciNumberGenerator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 27, 2021 -> Created
 * Description:     Fibonacci Nubmer Generator module, generates a fibonacci number at each clock.
 *                  Circuit width is parametrical.
 */

`timescale 1ns / 1ps

module FibonacciNumberGenerator
#(parameter WIDTH = 12)         // Indicates the upper limit of number generation in bits
(
    input  logic clk,
    input  logic reset,                     // Active High
    input  logic start,                     // Keep asserted to generate continuously
    output logic valid,                     // Validness of generated Fibonacci Number
    output logic overflowed,                // Asserts if an overflow occurs
    output logic [WIDTH-1 : 0] fibNumber    // Generated Fibonacci Number
);

// States
enum {  
    IDLE,       // Wait for the assertion of start signal
    START_0,    // Generate 0
    START_1,    // Generate 1
    CALCULATE   // Generate remaining fibonacci numbers f(i) = f(i-1) + f(i-2)
} state;

// Internal Signals
logic [WIDTH-1  : 0] fib0 = 0, fib1 = 1;    // f(i-2) and f(i-1) 
logic [WIDTH    : 0] fibSum;                // f(i-1) + f(i-2)

// Combinational Part
always_comb begin
    /* The width of fibSum register is different, be careful :) 
       The MSB of fibSum register will be used for indicating the overflow */
    fibSum = {1'b0, fib0} + {1'b0, fib1};   // f(i-2) + f(i-1)
end

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        state       <= IDLE;
        fib0        <= 0;
        fib1        <= 1;
        fibNumber   <= 0;
        valid       <= 1'b0;
        overflowed  <= 1'b0;
    end
    else begin
        valid       <= 1'b0;
        overflowed  <= 1'b0;
        fib0        <= 0;   // Default value of f(0)
        fib1        <= 1;   // Default value of f(1)
        fibNumber   <= 0;
    
        case(state)
            IDLE: 
                if(start) begin // Wait for start signal
                    state <= START_0;
                end
                
            START_0:
                if(start) begin
                    fibNumber   <= fib0;
                    valid       <= 1'b1;
                    state       <= START_1;
                end
                else begin
                    state   <= IDLE;
                end
                
            START_1: 
                if(start) begin
                    fibNumber   <= fib1;
                    valid       <= 1'b1;
                    state       <= CALCULATE;
                end
                else begin
                    state   <= IDLE;
                end
                
            CALCULATE:
                if(start) begin
                    if(fibSum[WIDTH]) begin     // MSB is the overflow indicator
                        overflowed  <= 1'b1; 
                        state       <= IDLE;
                    end
                    else begin  
                        // Calculate the f(i)
                        fibNumber   <= fibSum[WIDTH-1 : 0];
                        valid       <= 1'b1;
                        
                        // Shift previously generated ones
                        fib0        <= fib1;
                        fib1        <= fibSum[WIDTH-1 : 0];
                        
                        // Remain the state
                        state       <= CALCULATE;
                    end
                end
                else begin
                    state   <= IDLE;
                end
            
            default: 
                state   <= IDLE;
        endcase
    end
end

endmodule
