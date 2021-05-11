/* File:            tb_Decoder_2bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 11, 2021 -> Created
 * Description:     Testbench for 2-bit Decoder module
 */

`timescale 1ns / 1ps

module tb_Decoder_2bit;

// Test signals
logic enable;
logic [1:0] test_in;
logic [3:0] test_out;

// Instantiation of Circuit Under Test
Decoder_2bit UUT(.enable(enable), .n(test_in), .decoded(test_out));

initial begin
    enable = 1'b0;
    for(int i = 0; i < 4; ++i) begin
        test_in = i;
        #100;
    end  
    
    enable = 1'b1;
    for(int i = 0; i < 4; ++i) begin
        test_in = i;
        #100;
    end
end
endmodule
