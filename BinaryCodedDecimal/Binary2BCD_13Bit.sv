/* File:            Binary2BCD_13Bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     13-Bit Binary Coded Decimal converter module.
 */

`timescale 1ns / 1ps

module Binary2BCD_13Bit
(
    input  logic clk,
    input  logic reset,                 // Active High, Synchronous reset
    input  logic start,                 // Should be asserted to trigger conversion
    input  logic [12 : 00] binary,      // Binary input
    output logic [15 : 00] decimal,     // BCD Output
    output logic valid                  // Asserted for one clock when the output is valid
);

// States
enum {IDLE, OPERATION} state = IDLE;

// Internal Signals
logic [12 : 00] binaryReg = 0;
logic [03 : 00] bcd3 = 0, bcd2 = 0, bcd1 = 0, bcd0 = 0;
logic [03 : 00] bcd3_a, bcd2_a, bcd1_a, bcd0_a;     // Adjusted BCDs
logic [03 : 00] counterReg = 0;

// Combinational Part
always_comb begin
    // Each BCD block requires to be adjusted if it is greater than 4
    // The adjustment is done before shifting at each cycle
    // Adjusted BCD blocks are represented with the "_a" suffix
    bcd0_a <= (bcd0 > 4'd4) ? (bcd0 + 3) : bcd0;
    bcd1_a <= (bcd1 > 4'd4) ? (bcd1 + 3) : bcd1;
    bcd2_a <= (bcd2 > 4'd4) ? (bcd2 + 3) : bcd2;
    bcd3_a <= (bcd3 > 4'd4) ? (bcd3 + 3) : bcd3;
end

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        // Output Signals
        valid <= 1'b0;
        
        // Internal Signals
        binaryReg   <= 0;
        bcd3        <= 0;
        bcd2        <= 0;
        bcd1        <= 0;
        bcd0        <= 0;
        
        // State
        state <= IDLE;
    end
    else begin
        // Defaults
        valid <= 1'b0;
    
        case(state)
            IDLE:
                if(start) begin
                    // Internal Signals
                    binaryReg   <= binary;
                    bcd3        <= 0;
                    bcd2        <= 0;
                    bcd1        <= 0;
                    bcd0        <= 0;
                    counterReg  <= 0;
                    
                    // State
                    state <= OPERATION;
                end
            
            OPERATION: begin
                // Shift 1-Bit each cycle
                // Adjustment of BCD groups is handled in the combinational block above
                bcd0 <= {bcd0_a[2:0], binaryReg[12 - counterReg]};      
                bcd1 <= {bcd1_a[2:0], bcd0_a[3]};        
                bcd2 <= {bcd2_a[2:0], bcd1_a[3]};         
                bcd3 <= {bcd3_a[2:0], bcd2_a[3]};
                
                if(counterReg < 12)
                    counterReg <= counterReg + 1;
                else begin
                    valid <= 1'b1;
                    state <= IDLE;
                end        
            end
            
            default:
                state <= IDLE;
        endcase
    end      
end

// Output Logic
assign decimal[15:12] = bcd3;
assign decimal[11:08] = bcd2;
assign decimal[07:04] = bcd1;
assign decimal[03:00] = bcd0;

endmodule
