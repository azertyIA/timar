`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:51:40 03/07/2025 
// Design Name: 
// Module Name:    S1_Register 
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

module S1_Register(
    input clk,
    input rst,
    input [31:0] InstrIn,

    output reg [4:0]  S1_ReadSelect1,   // Source register 1 (r2)
    output reg [4:0]  S1_ReadSelect2,   // Source register 2 (r3) for R-format
    output reg [31:0] S1_Imm,
    output reg        S1_DataSrc,
    output reg [2:0]  S1_ALUOp,
    output reg [4:0]  S1_WriteSelect,   // Destination register (r1)
    output reg        S1_WriteEnable

    // To Do: implement the rest of the logic according to the figure

);

    always @(posedge clk) begin
        if (rst) begin
            S1_ReadSelect1    <= 5'd0;
            S1_ReadSelect2    <= 5'd0;
            S1_Imm               <= 0;
            S1_DataSrc           <= 0;
            S1_ALUOp             <= 0;
            S1_WriteSelect    <= 5'd0;
            S1_WriteEnable    <= 1'b0;


        end else begin
            // Decode register fields:
            S1_WriteSelect <= InstrIn[25:21]; // destination
            S1_ReadSelect1 <= InstrIn[20:16]; // source 1
            S1_ReadSelect2 <= InstrIn[15:11]; // source 2 (N/A if immediate)

            // Always enable writing in this simple design. This is because we focus on R and I format instructions.
			// For these format of instructions, the destination register is always written.
            S1_WriteEnable <= 1'b1;

            // Decode the immediate value by sign-extending the lower 16 bits.
            S1_Imm <= {{16{InstrIn[15]}},InstrIn[15:0]};
            // Decode ALU operation:
            S1_ALUOp <= InstrIn[28:26];


            // Data source selection:
            // Bit 29 indicates whether the instruction uses an immediate (1) or a register (0).
            S1_DataSrc <= InstrIn[29]; 
        end
    end

endmodule
