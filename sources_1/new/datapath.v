`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2019 03:20:36 PM
// Design Name: 
// Module Name: datapath
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


module datapath #(parameter WL = 32, parameter AL_rf = 5, parameter WL_op = 6)(
input CLK, RST
    );
    // declare wires
    wire [WL-1:0] PC_out, Inst;   // 32-bit unsigned data bus
    wire [WL-1:0] PC_in, PC_incr, PCBranch, PCJump, PC_inter;
    wire signed [WL-1:0] SImm, ALUIn1, ALUIn2, RF_out1, RF_out2, ALU_out, DM_out, ALU_DM;    // signed 32-bit data bus
    wire [2:0] ALUsel;  // 3-bit ALU select bus
    wire zero, RFDsel, shamt_rsSel, ALUInSel, MtoRFSel, Branch, PCSel, DM_writeEN, RF_writeEN, Jump;   // enable flags and select bits
    wire [5:0] opcode = Inst[31:26], funct = Inst[5:0]; // 6-bit opcode and funct for R-type isntructions
    wire [4:0] rs = Inst[25:21], rt = Inst[20:16], rd = Inst[15:11], shamt = Inst[10:6];    // 5-bit register addresses and shift amount
    wire [4:0] rtd, regshift_mux; // 5-bit register write address
    wire [25:0] Jaddr = Inst[25:0]; // 26-bit jump address
    wire signed [15:0] Imm = Inst[15:0];   // 16-bit signed immediate value
    
    // assign wire values;
    assign ALUIn1 = shamt_rsSel ? shamt : RF_out1;  // 1st ALU input gets shamt for fixed shift instructions and rs for all others
    assign ALUIn2 = ALUInSel ? SImm : RF_out2;  // 2nd ALU input gets either sign-extended immedate or register file read data 2 based on mux input
    assign rtd = RFDsel ? rd : rt;  // Register file destination register gets rd for R-type, rt for LW, SW, and I-type
    assign ALU_DM = MtoRFSel ? DM_out : ALU_out;    // Write data to register file from data memory for LW, from ALU for R-type
    assign PCSel = Branch & zero;   // mux to determine if branch is taken (if Branch == 1 and ALU output == 0)
    assign PC_incr = PC_out + 1;    // Next address
    assign PCBranch = PC_incr + SImm;   // Branch Address
    assign PCJump = {PC_incr[31:26], Jaddr};    // Jump Address
    assign PC_inter = PCSel ? PCBranch : PC_incr;   
    assign PC_in = Jump ? PCJump : PC_inter;
    
    // instantiate modules
    pc #(WL) prog_count (.CLK(CLK), .RST(RST), .PC_next(PC_in), .PC_curr(PC_out));  // program counter
    
    instr_mem #(WL, WL) instruction_set (.instr_addr(PC_out), .instr_data(Inst));   // instruction memory reads binary instructrions from text file
    
    sign_ext #(WL) simm (.Imm(Imm), .SImm(SImm));
    
    control_unit #(WL_op) control (.Opcode(opcode), .funct(funct), .MtoRFSel(MtoRFSel), 
        .DMWE(DM_writeEN), .Branch(Branch), .ALUInSel(ALUInSel), .RFDSel(RFDsel), .RFWE(RF_writeEN), .shamt_rsSel(shamt_rsSel), .Jump(Jump), .ALUSel(ALUsel)); // Sets flags and determines ALU operation
        
    reg_file #(WL, AL_rf) registers (.CLK(CLK), .RST(RST), .write_EN(RF_writeEN), .writeData(ALU_DM), .readAddr1(rs), 
        .readAddr2(rt), .writeAddr(rtd), .readData1(RF_out1), .readData2(RF_out2));   // Register file
        
    ALU #(WL) logic_unit (.x(ALUIn1), .y(ALUIn2), .sel(ALUsel), .out(ALU_out), .zero(zero));    // Arithmetic and Logic Unit
    
    data_mem #(WL) data (.CLK(CLK), .write_EN(DM_writeEN), .addr(ALU_out), .writeData(RF_out2), .readData(DM_out)); // Data memory reads 32-bit binary values from text file
    
endmodule
