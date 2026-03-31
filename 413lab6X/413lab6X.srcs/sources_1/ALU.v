`timescale 1ns / 1ps

module ALU (
    input  [2:0]  opcode, 
    input  [31:0] operand1,
    input  [31:0] operand2, 
    output [31:0] result
    );
    assign result = 
        (opcode == 3'b000) ? operand1 :
        (opcode == 3'b001) ? ~operand1 :
        (opcode == 3'b010) ? operand2 - operand1 :
        (opcode == 3'b011) ? operand1 + operand2 :
        (opcode == 3'b100) ? ~(operand1 | operand2) :
        (opcode == 3'b101) ? ~(operand1 & operand2) :
        (opcode == 3'b110) ? operand1 & operand2 :
        ($signed(operand1) < $signed(operand2)) ? 1 : 0;
endmodule
