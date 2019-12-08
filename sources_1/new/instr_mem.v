`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 10:40:09 AM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem #(parameter WL_addr = 32, parameter WL_data = 32)(
input [WL_addr-1:0] instr_addr, output [WL_data-1:0] instr_data
    );
    reg [WL_data-1:0] instructions [0:WL_addr-1];
    initial $readmemb("instructionsPartE.mem", instructions);
    assign instr_data = instructions[instr_addr];
endmodule
