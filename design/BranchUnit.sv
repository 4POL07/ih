`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic [31:0] AluResult,
    input logic JalrSel,
    input logic HaltSel,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = PC_Full + Imm;
  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = (Branch && AluResult[0]) || JalrSel; // Desvio condicional ou incondicional
  assign PcSel = Branch_Sel || HaltSel; // Se PcSel = 1, Pc é atualizado com o valor de BrPC, caso contrário Pc é atualizado com PC+4
  assign BrPC = (JalrSel) ? AluResult : ((PcSel) ? PC_Imm : 32'b0);
  
endmodule
