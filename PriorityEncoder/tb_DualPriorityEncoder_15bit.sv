/* File:            tb_DualPriorityEncoder_15bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Testbench for 15-Bit Dual-Priority Encoder
 */

`timescale 1ns / 1ps

module tb_DualPriorityEncoder_15bit;

// Test Signals
logic [15:01] test_req;
logic [03:00] test_first;
logic [03:00] test_second;

// Instantiation of Circuit Under Test
DualPriorityEncoder_15bit DPE_15bit(.req(test_req), .first(test_first), .second(test_second));

// Test Scenario
initial begin
    for(int firstIndex = 1; firstIndex < 15; ++firstIndex) begin
        for(int secondIndex = 0; secondIndex < firstIndex; ++secondIndex) begin
            test_req = 2**firstIndex + 2**secondIndex;
            
            #10;
        end        
    end
    
    $stop;
end
endmodule
