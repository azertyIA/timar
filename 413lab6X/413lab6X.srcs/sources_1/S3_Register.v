`timescale 1ns / 1ns
module S3_Register(
    input        clk,
    input        rst,
    input [31:0] ALUOut,
    input [4:0]  S2_WriteSelect,
    input        S2_WriteEnable,

    output reg [31:0] S3_ALUOut,
    output reg [4:0]  S3_WriteSelect,
    output reg        S3_WriteEnable
);
    always @(posedge clk) begin
        if (rst) begin
            S3_ALUOut      <= 0;
            S3_WriteSelect <= 0;
            S3_WriteEnable <= 0;
        end else begin
            S3_ALUOut      <= ALUOut;
            S3_WriteSelect <= S2_WriteSelect; 
            S3_WriteEnable <= S2_WriteEnable;
        end
    end
endmodule