`timescale 1ns / 1ns

module Pipeline_tb;
	// Inputs
	reg clk;
	reg rst;
	reg [31:0] InstrIn;

	// Outputs
	wire [31:0] Out;

	// Instantiate the Unit Under Test (UUT)
	Pipeliner uut(clk, rst, InstrIn, Out);

	// Define clk
	always #5 assign clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		InstrIn = 0;

        #10 rst = 0;

		// ADrI $1, $0, 0x000C
		#10 InstrIn = 32'b011011_00001_00000_00000000_00001100;
		// ADDI $2, $0, 0x0004
		#10 InstrIn = 32'b011011_00010_00000_00000000_00000100;
		// NOP
		#10 InstrIn = 0;
		// Another NOP
		//#10 InstrIn = 0;
		// SUB  $3, $2, $1
		#10 InstrIn = 32'b010010_00011_00010_00001_00000000000;
		// ADDI $2, $2, 0x0004
		#10 InstrIn = 32'b011011_00010_00010_00000000_00000100;
		// ADDI $2, $1, 0x0004
		#10 InstrIn = 32'b011011_00010_00001_00000000_00000100;
		// NOT  $4, $3
		#10 InstrIn = 32'b010001_00100_00011_00000_00000000000;

		// MOV
		#10 InstrIn = 32'b010000_00011_00101_00000_00000000000; // 50
		#10 InstrIn = 32'b011000_00011_00101_11111111_11111111; // no matter

		// NOT
		#10 InstrIn = 32'b011001_00100_00101_11111111_11111110; // no matter
		#10 InstrIn = 32'b010001_00100_00101_00000_00000000000; // ~50 = -51

		// NOR
		#10 InstrIn = 32'b011100_00100_01000_00000000_01010000; // ~80 = -80
		#10 InstrIn = 32'b010100_00100_00101_00000_00000000000; // ~50 = -51

		// NAND
		#10 InstrIn = 32'b011101_00100_00101_11111111_11111111; // ~50 = -51
		#10 InstrIn = 32'b010101_00100_00000_00000_00000000000; // -1

		// AND
		#10 InstrIn = 32'b010110_00100_00011_00011_00000000000; // 50
		#10 InstrIn = 32'b010110_00100_00011_00000000_00000000; // 0

		// SLT
		#10 InstrIn = 32'b010111_00100_00000_00101_00000000000; // 1
		#10 InstrIn = 32'b011111_00100_00000_11111111_11111110; // 0
		// $finish;

	end
      
endmodule