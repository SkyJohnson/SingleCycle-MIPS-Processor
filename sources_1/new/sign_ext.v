`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 07:54:49 PM
// Design Name: 
// Module Name: sign_ext
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


module sign_ext #(parameter WL = 32)(
input signed [15:0] Imm, output reg signed [WL-1:0] SImm
    );
    always @(*)
        SImm <= { {16{Imm[14]}}, Imm[15:0] };
endmodule
