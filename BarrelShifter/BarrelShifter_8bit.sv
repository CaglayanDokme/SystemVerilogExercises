/* File:            BarrelShifter_8bit.sv
 * Author:          Caglayan DOKME, caglayandokme@gmail.com
 * Date:            May 14, 2021 -> Created
 * Description:     Shifts the given signal to the right according to the given shift amount
 * Original Code:   FPGA Prototyping by System Verilog Examples, Pong Chu, Listing 3.18
 */

`timescale 1ns / 1ps

module BarrelShifter_8bit
(
    input  logic [7:0] a,
    input  logic [2:0] shiftAmount,
    output logic [7:0] shifted
);

// Body
always_comb
    case(shiftAmount)
        3'd0:       shifted = a;
        3'd1:       shifted = {a[0],      a[7:1]  };
        3'd2:       shifted = {a[1:0],    a[7:2]  };
        3'd3:       shifted = {a[2:0],    a[7:3]  };
        3'd4:       shifted = {a[3:0],    a[7:4]  };
        3'd5:       shifted = {a[4:0],    a[7:5]  };
        3'd6:       shifted = {a[5:0],    a[7:6]  };
        default:    shifted = {a[6:0],    a[7]    }; 
    endcase
endmodule
