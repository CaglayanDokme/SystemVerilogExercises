/* File:            RotatingLEDs.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 24, 2021 -> Created
 * Description:     LED Rotator module with programmable speed input.
 */

`timescale 1ns / 1ps

module RotatingLEDs
#(parameter nSpeed = 8, nLED = 8, rawClkFreq = 100e6, counterClkFreq = 250)
(
    input  logic clk,
    input  logic reset,         // Active High
    input  logic [nSpeed-1 : 0] rotationSpeed,
    output logic [nLED-1 : 0]   leds
);

// Internal Signals
logic [nLED-1   : 0] ledsReg    = 1;    // Current status of LEDs
logic [nSpeed-1 : 0] counterReg = 0;    // Will be used to adjust speed
logic rotateLeft = 1;                   // Represents rotation side(L:1 - R:0)
logic dividedClock;

// Clock Divider Instantiation
ClockDivider #(.rawClockFreq(rawClkFreq), .desiredClockFreq(counterClkFreq)) ClkGen(.*);

// Internal Logic
always_ff @ (posedge(clk))
    if(reset) begin
        ledsReg     <= 1;
        rotateLeft  <= 1;
        counterReg  <= 0;
    end
    else begin
        if(dividedClock) begin  // Use decelerated clock
            counterReg  <= counterReg + 1;  // Increment counter
            
            if(counterReg >= ((2**nSpeed - 1) - rotationSpeed)) begin   // Check if counter exceeded the given limit
                counterReg <= 0;    // Reset counter
                
                if(rotateLeft) begin    // Rotating Left
                    if(ledsReg[nLED-1]) begin   // Finish left rotation
                        rotateLeft  <= 1'b0;
                        ledsReg     <= {ledsReg[0], ledsReg[nLED-1 : 1]};   // Rotate right 
                    end
                    else begin  // Continue left rotation
                        ledsReg <= {ledsReg[nLED-2 : 0], ledsReg[nLED-1]};  // Rotate left
                    end    
                end         
                else begin  // Rotating Right
                    if(ledsReg[0]) begin    // Finish right rotation
                        rotateLeft  <= 1'b1;
                        ledsReg     <= {ledsReg[nLED-2 : 0], ledsReg[nLED-1]};  // Rotate left
                    end
                    else begin  // Continue right rotation
                        ledsReg <= {ledsReg[0], ledsReg[nLED-1 : 1]};   // Rotate right
                    end
                end
            end            
        end
    end

// Output Logic
assign leds = ledsReg;

endmodule
