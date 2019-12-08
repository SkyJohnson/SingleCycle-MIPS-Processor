`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 08:11:16 PM
// Design Name: 
// Module Name: tb_simm
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


module tb_simm;
    reg signed [15:0] imm;
    wire signed [31:0] simm;
    sign_ext #(32) Simm (.Imm(imm), .SImm(simm));
    initial begin
        imm = 16'b1111111111111111;
        $display(imm[15]);
    end
endmodule
