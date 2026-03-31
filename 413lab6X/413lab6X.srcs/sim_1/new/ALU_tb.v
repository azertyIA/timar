`timescale 1ns / 1ns

module ALU_tb;

reg [5:0] opcode;
reg [31:0] operand1, operand2;
wire [31:0] result;

ALU brainiac(opcode, operand1, operand2, result);

initial begin
    #5 // move
    opcode <= 0;
    operand1 <= 32'hFEFE;
    #5 
    operand1 <= 32'hFAAE;
    
    #5 // not 
    opcode <= 1;
    operand1 <= 32'hFFFFFFF0;
    #5 
    operand1 <= 32'h00000010;

    #5 // subtract
    opcode <= 3'b010;
    operand1 <= 32'hFFFFFAAE;
    operand2 <= 32'hFFFFFAAE;

    #5 // add
    opcode <= 3'b011;
    operand1 <= 32'hFFFFFFF0;
    operand1 <= 32'h00000010;
    #5
    operand1 <= 32'h000000FE;
    operand1 <= 32'h00000010;

    #5 // nor
    opcode <= 3'b100;
    operand1 <= 32'h00000000;
    operand2 <= 32'hFFFFFFFF;
    #5
    operand1 <= 32'h00000000;
    operand2 <= 32'h00000000;
    #5
    operand1 <= 32'hAAAAAAAA;
    operand2 <= 32'h66666666;

    #5 // nand
    opcode <= 3'b101;
    operand1 <= 32'h00000000;
    operand2 <= 32'h00000000;
    #5
    operand1 <= 32'hFFFFFFFF;
    operand2 <= 32'h00000000;
    #5
    operand1 <= 32'hAAAAAAAA;
    operand2 <= 32'hBBBBBBBB;

    #5 // and
    opcode <= 3'b110;
    operand1 <= 32'hFFFFFAAE;
    operand2 <= 32'hFFFFFAAE;
    #5
    operand1 <= 32'hFFFFFFFF;
    operand2 <= 32'hFFFFFFFF;
    #5
    operand1 <= 32'h66666666;
    operand2 <= 32'h99999999;

    #5 // set less than
    opcode <= 3'b111;
    operand1 <= 32'h00001000;
    operand2 <= 32'h00001001;
    #5
    operand1 <= 32'h00001001;
    operand2 <= 32'h00001000;
    #5
    operand1 <= 32'hFFFFFFFF;
    operand2 <= 32'h00000001;
    #5
    operand1 <= 32'h00000001;
    operand2 <= 32'h00000001;
    #5
    operand1 <= 32'hFFFFFFFF;
    operand2 <= 32'hFFFFFFFE;
end

endmodule