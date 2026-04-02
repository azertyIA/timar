`timescale 1ns / 1ns

module ALU_control(
	input [5:0] instruction,
	input [1:0] ALUOp,
	output reg [2:0] func
);

always @(*) begin
	// Remember that the ALUOP is set by the control unit in control.v 
	// ALUOp = 2'b00 for R-type instructions
	// ALUOp = 2'b01 for branch instructions
	// ALUOp = 2'b10 for lw and sw instructions
	// ALUOp = 2'b11 for I-type instructions

	if (ALUOp == 2'b00) begin  
		if (instruction == 6'h20) 
			func <= 3'd0;
		else if (instruction == 6'h22)
			func <= 3'd1;
		else if (instruction == 6'h24)
			func <= 3'd2;
		else if (instruction == 6'h25)
			func <= 3'd3;
		else if (instruction == 6'h27)
			func <= 3'd4;
		else if (instruction == 6'h26) // Added this for bitwise xor
			func <= 3'd5;
		else if (instruction == 6'h2A) // addede for SLT (signed)
			func <= 3'd6;
		else
			func <= 3'd7;
	end else if (ALUOp == 2'b01) begin
		func <= 3'd1;
	end else if (ALUOp == 2'b10) begin
		func <= 3'd0;
	end else if (ALUOp == 2'b11) begin  
		if (instruction == 6'b000011)      // SUBI this used to be 8
			func <= 3'd1;
		else if (instruction == 6'b001100) // ANDI
			func <= 3'd2;
		else if (instruction == 6'b001111) // LUI
			func <= 3'd7;
	end
end

endmodule