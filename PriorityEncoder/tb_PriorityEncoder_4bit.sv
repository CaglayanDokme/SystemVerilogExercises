/* File:            tb_PriorityEncoder_4bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Testbench for 4-Bit Priority Encoder
 */

`timescale 1ns / 1ps

module tb_PriorityEncoder_4bit;

logic [4:1] test_in;
logic [2:0] test_out;

PriorityEncoder_4bit PrioEnc(.prio(test_in), .index(test_out));

initial begin
    for(int i = 0; i < 16; ++i) begin
        test_in = i;
        #20;
    end    
    
    $stop;
end
endmodule
