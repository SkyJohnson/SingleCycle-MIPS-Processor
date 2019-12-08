`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2019 10:17:52 AM
// Design Name: 
// Module Name: data_mem
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


module data_mem #(parameter WL = 32)(
input CLK, write_EN, input [WL-1:0] addr, input signed [WL-1:0] writeData, output wire signed [WL-1:0] readData
    );
    reg [WL-1:0] RAM [0:2*WL];
    
    assign readData = RAM[addr];
    always @(posedge CLK) begin
        if(write_EN) RAM[addr] <= writeData;      
    end
    
    initial $readmemb("data.mem", RAM);
endmodule
