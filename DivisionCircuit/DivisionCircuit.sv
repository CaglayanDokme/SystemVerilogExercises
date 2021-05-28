/* File:            DivisionCircuit.sv 
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 28, 2021 -> Created
 * Description:     Parametrical width Division Circuit
 */

`timescale 1ns / 1ps

module DivisionCircuit
#(parameter WIDTH = 8)
(
    input  logic clk,
    input  logic reset,                     // Active high, synchronous reset
    input  logic load,                      // Should be asserted to start calculation
    input  logic [WIDTH-1 : 0] dividend,    
    input  logic [WIDTH-1 : 0] divisor,     // Must be greater than zero
    output logic [WIDTH-1 : 0] quotient,    // Valid only if the valid signal is asserted
    output logic [WIDTH-1 : 0] remainder,   // Valid only if the valid signal is asserted
    output logic valid,                     // Asserts when the result is valid
    output logic divisionByZero             // Asserts when division-by-zero occured 
);

// Local Constants
localparam COUNTER_WIDTH = $clog2(WIDTH + 1);

// States
enum {IDLE, CALCULATE} state;

// Internal Signals (Register)
logic [WIDTH-1 : 0] dividendReg = 0;
logic [WIDTH-1 : 0] divisorReg  = 0;
logic [WIDTH-1 : 0] calcReg     = 0;
logic [COUNTER_WIDTH-1 : 0] idx = WIDTH + 1;

// Internal Signals (Combinational)
logic [WIDTH-1 : 0] diffReg;

// Combinational Part
always_comb begin
    if(calcReg > divisorReg)
        diffReg = calcReg - divisorReg;
    else 
        diffReg = 0;
end

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        // Output
        valid       <= 1'b0;
        quotient    <= 0;

        // Internal Signals        
        dividendReg <= 0;
        divisorReg  <= 0;
        calcReg     <= 0;
        idx         <= WIDTH;
        
        // Internal State
        state       <= IDLE;
    end
    else begin
        // Defaults
        valid           <= 1'b0;
        divisionByZero  <= 1'b0;
        
        case(state)
            IDLE: begin
                quotient    <= 0;
                remainder   <= 0;
                
                // Wait until new data arrives
                if(load) begin
                    if(0 == divisor) begin          // Division-by-0 is an exceptional status
                        divisionByZero <= 1'b1;
                    end
                    else if(1 == divisor) begin     // Division-by-1 can be done quickly
                        valid       <= 1'b1;
                        quotient    <= dividend;
                        remainder   <= 0;
                    end
                    else begin
                        // Internal Signals        
                        dividendReg <= dividend;    // Save a valid sample of each input
                        divisorReg  <= divisor;
                        calcReg     <= 0;
                        idx         <= WIDTH;
                        
                        // Internal State
                        state <= CALCULATE;
                    end
                end
            end
                    
            CALCULATE: begin                
                if(idx > 0) begin   // Calculation continues
                    if(calcReg >= divisorReg) begin
                        quotient[idx]    <= 1'b1;
                        calcReg          <= {diffReg[WIDTH-2:0], dividendReg[idx-1]};
                    end
                    else begin
                        quotient[idx]    <= 1'b0;
                        calcReg          <= {calcReg[WIDTH-2:0], dividendReg[idx-1]};
                    end
                    
                    idx <= idx - 1;
                end
                else begin      // Finishing the calculation
                    if(calcReg >= divisorReg) begin
                        quotient[idx]    <= 1'b1;
                        calcReg          <= diffReg;
                    end
                    else 
                        quotient[idx]    <= 1'b0;
                
                    // Result is valid
                    valid       <= 1'b1;
                    state       <= IDLE;
                end
            end     
            
            default:
                state <= IDLE;   
            
        endcase
    end
end

// Output Logic
assign remainder = calcReg; 

endmodule
