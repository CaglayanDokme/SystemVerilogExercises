/* File:            ClockDivider.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 24, 2021 -> Created
 * Description:     Parametrical clock divider module. Decelerates the given clock to obtain the given frequency.
 */

`timescale 1ns / 1ps

module ClockDivider
#(parameter rawClockFreq = 100_000_000, desiredClockFreq = 1_000_000)
(
    input  logic clk,
    output logic dividedClock
);

// Local Constants
localparam RATIO    = rawClockFreq / desiredClockFreq;
localparam BITS     = $clog2(RATIO);

// Internal Signals
logic [BITS-1 : 0] counter  = 0;
logic [BITS-1 : 0] limit    = RATIO;

// Internal Logic
always_ff @ (posedge(clk))
    if(counter < limit-1)
        counter <= counter + 1;
    else
        counter <= 0;
    
// Output Logic
assign dividedClock = (counter == 0) ? 1 : 0;

endmodule
