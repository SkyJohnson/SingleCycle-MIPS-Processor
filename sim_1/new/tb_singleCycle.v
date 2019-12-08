`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2019 11:38:50 PM
// Design Name: 
// Module Name: tb_singleCycle
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


module tb_singleCycle;

    reg CLK, RST;
    
    datapath #(32, 5) testCPU (.CLK(CLK), .RST(RST));
    
    initial begin
        RST <= 1;
        CLK <= 0;
    end
    
    always #10 CLK <= ~CLK;
    
    initial begin
        #10 RST <= 0;
        #600;
        $finish;
    end
endmodule
