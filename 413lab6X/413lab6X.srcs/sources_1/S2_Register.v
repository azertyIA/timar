`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:12:01 03/07/2025 
// Design Name: 
// Module Name:    S2_Register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module S2_Register(
    input        clk,
    input        rst,
    input [31:0] RD1,          // Register File Read Data 1
    input [31:0] RD2,          // Register File Read Data 2
    input [31:0] S1_Imm,
    input        S1_DataSrc,
    input [2:0]  S1_ALUOp,
    input        S1_WriteEnable,  // Write enable signal
    input [4:0]  S1_WriteSelect,  // Write select (destination register)

    output reg [31:0] S2_Imm,
    output reg        S2_DataSrc,
    output reg [2:0]  S2_ALUOp,
    output reg [31:0] S2_RD1,       // Latched Read Data 1
    output reg [31:0] S2_RD2,       // Latched Read Data 2
    output reg        S2_WriteEnable, // Latched write enable
    output reg [4:0]  S2_WriteSelect  // Latched write select
);

    always @(posedge clk) begin
        if (rst) begin
            S2_RD1         <= 32'd0;
            S2_RD2         <= 32'd0;

            S2_Imm         <= 32'd0;
            S2_DataSrc     <= 1'd0;
            S2_ALUOp       <= 3'd0;

            S2_WriteEnable <= 1'b0;
            S2_WriteSelect <= 5'd0;
        end else begin
            S2_RD1         <= RD1;
            S2_RD2         <= RD2;

            S2_Imm         <= S1_Imm;
            S2_DataSrc     <= S1_DataSrc;
            S2_ALUOp       <= S1_ALUOp;

            S2_WriteEnable <= S1_WriteEnable;
            S2_WriteSelect <= S1_WriteSelect;
        end
    end

endmodule
