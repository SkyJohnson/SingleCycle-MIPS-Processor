`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2019 03:10:23 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file #(parameter WL_data = 32, parameter WL_addr = 5)(
    input CLK, RST, write_EN, input signed [WL_data-1:0] writeData, input [WL_addr-1:0] readAddr1, readAddr2, writeAddr, 
    output signed [WL_data-1:0] readData1, readData2 
    );
    reg [WL_data-1:0] mem [0:2**WL_addr-1];
    integer i;
    
    always @(posedge CLK or RST) begin
        if(RST) begin
            for(i = 0; i<=2**WL_addr-1; i=i+1) begin
                mem[i] <= 32'h00000000;
            end
        end
        else
            if(write_EN) mem[writeAddr] <= writeData;
    end
    assign readData1 = mem[readAddr1];
    assign readData2 = mem[readAddr2];
     
endmodule
 