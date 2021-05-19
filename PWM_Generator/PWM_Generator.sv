/* File:            PWM_Generator.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 19, 2021 -> Created
 * Description:     Basic, programmable PWM Signal Generator
 */

`timescale 1ns / 1ps

module PWM_Generator
#(parameter N = 8)
(
    input  logic clk,
    input  logic reset,         // Active High
    input  logic [N-1 : 0] dutyCycle,
    output logic pwmSignal
);

// Internal Signals
logic [N-1 : 0] highCycles, lowCycles;

assign highCycles   = dutyCycle;
assign lowCycles    = (2**N - 1) - highCycles; 

// Instantiation of Modules
SquareWaveGenerator #(.N(N)) PWM_Generator(.*, .wave(pwmSignal));

endmodule
