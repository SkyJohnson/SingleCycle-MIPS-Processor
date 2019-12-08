`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2019 11:59:10 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit #(parameter WL = 6)(
input [WL-1:0] Opcode, funct, output reg MtoRFSel, DMWE, Branch, ALUInSel, RFDSel, RFWE, shamt_rsSel, Jump, output reg [2:0] ALUSel
    );
    reg [1:0] ALUOp;
    always @(*) begin
        // Main Decoder
        case (Opcode)
            6'b000000: begin    // R-Type instruction
                RFWE <= 1;
                RFDSel <= 1;
                ALUInSel <= 0;
                Branch <= 0;
                DMWE <= 0;
                MtoRFSel <= 0;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b10;
            end
            6'b000001: begin    // Fixed Shift instruction
                RFWE <= 1;
                RFDSel <= 1;
                ALUInSel <= 0;
                Branch <= 0;
                DMWE <= 0;
                MtoRFSel <= 0;
                shamt_rsSel <= 1;
                Jump <= 0;
                ALUOp <= 2'b10;
            end
            6'b100011: begin    // LW Instruction
                RFWE <= 1;
                RFDSel <= 0;
                ALUInSel <= 1;
                Branch <= 0;
                DMWE <= 0;
                MtoRFSel <= 1;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b00;
            end
            6'b101011: begin    // SW instruction
                RFWE <= 0;
                RFDSel <= 1'bx;
                ALUInSel <= 1;
                Branch <= 0;
                DMWE <= 1;
                MtoRFSel <= 1'bx;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b00;
            end
            6'b000100: begin    // branch instruction
                RFWE <= 0;
                RFDSel <= 1'bx;
                ALUInSel <= 0;
                Branch <= 1;
                DMWE <= 0;
                MtoRFSel <= 1'bx;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b01;
            end
            6'b001000: begin    // addi instruction
                RFWE <= 1;
                RFDSel <= 0;
                ALUInSel <= 1;
                Branch <= 0;
                DMWE <= 0;
                MtoRFSel <= 0;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b00;
            end
            6'b000010: begin    // Jump Instruction
                RFWE <= 0;
                RFDSel <= 1'bx;
                ALUInSel <= 1'bx;
                Branch <= 1'bx;
                DMWE <= 0;
                MtoRFSel <= 1'bx;
                shamt_rsSel <= 1'bx;
                Jump <= 1;
                ALUOp <= 2'bxx;
            end
            default: begin
                RFWE <= 0;
                RFDSel <= 0;
                ALUInSel <= 0;
                Branch <= 0;
                DMWE <= 0;
                MtoRFSel <= 0;
                shamt_rsSel <= 0;
                Jump <= 0;
                ALUOp <= 2'b00;
            end
        endcase
        
        // ALU Decoder
        if(ALUOp == 2'b00)
            ALUSel <= 3'b010;   // Add
        else if (ALUOp == 2'b01)
            ALUSel <= 3'b110;   // Sub
        else begin
            case (funct)    // Look at funct
                6'b100000: ALUSel <= 3'b010;    // add
                6'b100010: ALUSel <= 3'b110;    // sub
                6'b100100: ALUSel <= 3'b000;    // and
                6'b100101: ALUSel <= 3'b001;    // or
                6'b101010: ALUSel <= 3'b111;    // slt
                6'b110000: ALUSel <= 3'b011;    // sll
                6'b110001: ALUSel <= 3'b100;    // srl
                6'b110010: ALUSel <= 3'b101;    // sra
            endcase
        end
    end
endmodule
