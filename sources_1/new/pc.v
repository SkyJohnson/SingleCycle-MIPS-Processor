`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 02:58:26 PM
// Design Name: 
// Module Name: pc
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


module pc #(parameter WL = 32)(
input CLK, RST, input [WL-1:0] PC_next, output reg [WL-1:0] PC_curr
    );
    always @(posedge CLK or RST) begin
        if(RST) PC_curr <= 32'h00000000;
        else PC_curr <= PC_next;
    end
endmodule
