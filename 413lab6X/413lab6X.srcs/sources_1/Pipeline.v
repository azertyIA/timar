module Pipeliner(input clk, input rst, input [31:0] InstrIn, output [31:0] Out);

wire [31:0] S1_Imm;
wire [4:0] S1_ReadSelect1, S1_ReadSelect2, S1_WriteSelect;
wire [2:0] S1_ALUOp;
wire S1_DataSrc, S1_WriteEnable;

wire [31:0] RD1, RD2;

wire [31:0] S2_Imm, S2_RD1, S2_RD2;
wire [4:0] S2_WriteSelect;
wire [2:0] S2_ALUOp;
wire S2_DataSrc, S2_WriteEnable;

wire [31:0] MUXOut;
wire [31:0] ALUOut;

wire [31:0] S3_ALUOut;
wire S3_WriteEnable;
wire [4:0] S3_WriteSelect;

S1_Register s1(
    clk,
    rst,
    InstrIn,
    S1_ReadSelect1,
    S1_ReadSelect2,
    S1_Imm,
    S1_DataSrc,
    S1_ALUOp,
    S1_WriteSelect,
    S1_WriteEnable
);

nbit_register_file Register_File(
    S3_ALUOut,   
    RD1, RD2, 
    S1_ReadSelect1, S1_ReadSelect2, 
    S3_WriteSelect, S3_WriteEnable, clk
);


S2_Register s2(
    clk,
    rst,
    RD1,
    RD2,
    S1_Imm,
    S1_DataSrc,
    S1_ALUOp,
    S1_WriteEnable,
    S1_WriteSelect,
    S2_Imm,
    S2_DataSrc,
    S2_ALUOp,
    S2_RD1,
    S2_RD2,
    S2_WriteEnable,
    S2_WriteSelect
);

MUX m1(
    S2_DataSrc, 
    S2_RD2,
    S2_Imm, 
    MUXOut
);

ALU bigbrain(
    S2_ALUOp, 
    S2_RD1,
    MUXOut, 
    ALUOut
);

S3_Register s3(
    clk,
    rst,
    ALUOut,
    S2_WriteSelect,
    S2_WriteEnable,
    S3_ALUOut,
    S3_WriteSelect,
    S3_WriteEnable
);

assign Out = S3_ALUOut;

endmodule