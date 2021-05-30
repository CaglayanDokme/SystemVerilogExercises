/* File:            Binary2BCD.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 30, 2021 -> Created
 * Description:     Parametrical width Binary Coded Decimal converter module.
 */
 
 `timescale 1ns / 1ps

module Binary2BCD
#(parameter
    WIDTH   = 13,   // Binary input width
    DIGITS  = 4     // BCD Digits(Must be big enough to represent the biggest binary value(.i.e. 2**WIDTH - 1))
)
(
    input  logic clk,
    input  logic reset,                         // Active High, Synchronous reset
    input  logic start,                         // Should be asserted to trigger conversion
    input  logic [WIDTH-1  : 00] binary,        // Binary input
    output logic [4*DIGITS-1 : 00] decimal,     // BCD Output
    output logic valid                          // Asserted for one clock when the output is valid
);

// Local Constants
localparam WIDTH_C = $clog2(WIDTH);  // Counter width

// States
enum {IDLE, OPERATION} state = IDLE;

// Internal Signals
logic [WIDTH-1 : 00] binaryReg = 0;
logic [03 : 00] bcd     [DIGITS-1 : 00];    // BCD Digit Registers
logic [03 : 00] bcd_z   [DIGITS-1 : 00];    // Zero for BCDs    (I couldn't find a better way to reset BCD registers)
logic [03 : 00] bcd_n   [DIGITS-1 : 00];    // Next BCDs        (Next value of BCD Registers)
logic [03 : 00] bcd_a   [DIGITS-1 : 00];    // Adjusted BCDs    (Adjusted values of BCD Registers)
logic [WIDTH_C-1 : 00] counterReg = 0;      // Counter is used for indexing the given binary input

// Combinational Part
generate
    for(genvar i = 0; i < DIGITS; ++i) begin
        // Each BCD block requires to be adjusted if it is greater than 4
        // The adjustment is done before shifting at each cycle
        // Adjusted BCD blocks are represented with the "_a" suffix
        assign bcd_a[i] = (bcd[i] > 4'd4) ? (bcd[i] + 3) : bcd[i];
    end
endgenerate

assign bcd_n[0] = {bcd_a[0][2:0], binaryReg[WIDTH - 1 - counterReg]}; 
generate
    // Next values of each BCD digits includes its adjusted and 1-Bit shifted value
    // Adjustment of BCD groups is handled in the combinational block above
    for(genvar k = 1; k < DIGITS; ++k) begin
        assign bcd_n[k] = {bcd_a[k][2:0], bcd_a[k-1][3]}; 
    end
endgenerate

generate
    // bcd_z signals will be used to reset bcd registers
    for(genvar i = 0; i < DIGITS; ++i) begin
        assign bcd_z[i] = 0;
    end
endgenerate

// State Machine
always_ff @ (posedge(clk)) begin
    if(reset) begin
        // Output Signals
        valid <= 1'b0;
        
        // Internal Signals
        binaryReg   <= 0;
        bcd         <= bcd_z;
        
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
                    counterReg  <= 0;
                    bcd         <= bcd_z;
                    
                    // State
                    state <= OPERATION;
                end
            
            OPERATION: begin
                bcd <= bcd_n;
                
                if(counterReg < WIDTH-1)
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
generate
    for(genvar i = 0; i < DIGITS; ++i) begin
        assign decimal[(4*(i+1))-1 : 4*i] = bcd[i];
    end
endgenerate

endmodule
