`timescale 1ns / 1ps

module MUX (
    input         select, 
    input  [31:0] operand1,
    input  [31:0] operand2, 
    output [31:0] result
    );
    assign result = select ? operand2 : operand1;
endmodule
