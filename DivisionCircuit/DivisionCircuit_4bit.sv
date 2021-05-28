/* File:            DivisionCircuit_4bit.sv 
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 28, 2021 -> Created
 * Description:     4-Bit Division Circuit
 */

`timescale 1ns / 1ps

module DivisionCircuit_4bit
(
    input  logic clk,
    input  logic reset,
    input  logic load,
    input  logic [3:0] dividend,
    input  logic [3:0] divisor,
    output logic [3:0] quotient,
    output logic [3:0] remainder,
    output logic valid
);

// States
enum {IDLE, CALCULATE} state;

// Internal Signals (Register)
logic [3:0] dividendReg = 0;
logic [3:0] divisorReg  = 0;
logic [3:0] calcReg     = 0;
logic [3:0] idx         = 4;

// Internal Signals (Combinational)
logic [3:0] diffReg;

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
        idx         <= 4;
        
        // Internal State
        state       <= IDLE;
    end
    else begin
        // Defaults
        valid <= 1'b0;
        
        case(state)
            IDLE: begin
                quotient    <= 0;
                remainder   <= 0;
                
                // Wait until new data arrives
                if(load) begin
                    // Internal Signals        
                    dividendReg <= dividend;    // Save a valid sample of each input
                    divisorReg  <= divisor;
                    calcReg     <= 0;
                    idx         <= 4;
                    
                    // Internal State
                    state <= CALCULATE;
                end
            end
                    
            CALCULATE: begin                
                if(idx > 0) begin   // Calculation continues
                    if(calcReg >= divisorReg) begin
                        quotient[idx]    <= 1'b1;
                        calcReg          <= {diffReg[2:0], dividendReg[idx-1]};
                    end
                    else begin
                        quotient[idx]    <= 1'b0;
                        calcReg          <= {calcReg[2:0], dividendReg[idx-1]};
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
