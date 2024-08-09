`timescale 1ns / 1ps

module Controller (
    //Input
    input logic [6:0] Opcode,
    //7-bit opcode field from the instruction

    //Outputs
    output logic ALUSrc,
    //0: The second ALU operand comes from the second register file output (Read data 2); 
    //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic MemtoReg,
    //0: The value fed to the register Write data input comes from the ALU.
    //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic [1:0] ALUOp,  //00: I_TYPE_LOAD/S_TYPE; 01:Branch; 10: Rtype
    output logic Branch,  //0: branch is not taken; 1: branch is taken
    output logic JalrSel,
    output logic HaltSel,
    output logic [1:0] WRMux
);

  logic [6:0] R_TYPE, I_TYPE, U_TYPE, I_TYPE_LOAD, S_TYPE, B_TYPE, JAL, JALR, HALT;

  assign R_TYPE = 7'b0110011;
  assign I_TYPE = 7'b0010011;
  assign U_TYPE = 7'b0110111;
  assign I_TYPE_LOAD = 7'b0000011;
  assign S_TYPE = 7'b0100011;
  assign B_TYPE = 7'b1100011;
  assign HALT = 7'b1111111;
  assign JAL = 7'b1101111;
  assign JALR = 7'b1100111;

  assign ALUSrc = (Opcode == I_TYPE_LOAD || Opcode == S_TYPE || Opcode == I_TYPE || Opcode == JALR || Opcode == U_TYPE);
  assign MemtoReg = (Opcode == I_TYPE_LOAD);
  assign RegWrite = (Opcode == R_TYPE || Opcode == I_TYPE_LOAD || Opcode == I_TYPE || Opcode == JAL || Opcode == JALR || Opcode == U_TYPE);
  assign MemRead = (Opcode == I_TYPE_LOAD);
  assign MemWrite = (Opcode == S_TYPE);
  assign ALUOp[0] = (Opcode == B_TYPE || Opcode == JAL || Opcode == U_TYPE);
  assign ALUOp[1] = (Opcode == R_TYPE || Opcode == JAL || Opcode == U_TYPE || Opcode == I_TYPE);
  assign WRMux[0] = (Opcode == JAL || Opcode == JALR);
  assign WRMux[1] = (Opcode == U_TYPE);
  assign Branch = (Opcode == B_TYPE || Opcode == JAL);
  assign JalrSel = (Opcode == JALR);
  assign HaltSel = (Opcode == HALT);

endmodule
