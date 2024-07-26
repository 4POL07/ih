`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        // OR
                    ALUResult = SrcA | SrcB;
            4'b0010:        // ADD
                    ALUResult = $signed(SrcA) + $signed(SrcB);
	    4'b0011:        // SUB
                    ALUResult = $signed(SrcA) - $signed(SrcB);
            4'b0100:        // XOR
                    ALUResult = SrcA ^ SrcB;
            4'b0101:        // SLT
                    ALUResult = 0;
            4'b1001:        // LUI
                    ALUResult = 0;
            4'b1010:        // SLTI
                    ALUResult = 0; 
            4'b1011:        // ADDI
                    ALUResult = 0;
            4'b1100:        // SLLI
                    ALUResult = 0;
            4'b1101:        // SRLI
                    ALUResult = 0;
            4'b1110:        // SRAI
                    ALUResult = 0;
            4'b1000:        // Equal
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
            default:
                    ALUResult = 0;
            endcase
        end
endmodule

//todos de branch tem que terminar em 1 -> beq 1000 mas [3] = 1
