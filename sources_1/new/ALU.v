`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 10:48:14 AM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU #(parameter WL = 32)(
input signed [WL-1:0] x, input signed [WL-1:0] y, input [2:0] sel, output reg signed [WL-1:0] out, output reg zero
    );
    always @(*) begin
        case (sel)
            3'b000: out <= x&y; // and
            3'b001: out <= x|y; // or
            3'b010: out <= x+y; // add
            3'b011: out <= y << x;  // sll
            3'b100: out <= x >> y;  // srl
            3'b101: out <= x >>> y; // sra
            3'b110: out <= x-y; // sub
            3'b111: out <= (x<=y);  // slt
        endcase
        zero <= (out == 32'h00000000);
    end
endmodule
