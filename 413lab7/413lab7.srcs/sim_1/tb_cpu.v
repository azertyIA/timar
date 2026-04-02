`timescale 1ns / 1ns


module tb_cpu;

	// Inputs
	reg rst;
	reg clk;
	reg initialize;
	reg [31:0] instruction_initialize_data;
	reg [31:0] instruction_initialize_address;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.initialize(initialize), 
		.instruction_initialize_data(instruction_initialize_data), 
		.instruction_initialize_address(instruction_initialize_address)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		initialize = 1;
		instruction_initialize_data = 0;
		instruction_initialize_address = 0;

        #100;
      
        
		instruction_initialize_address = 0;
		instruction_initialize_data = 32'b000000_00000_00010_00001_00000_10_0000;      // ADD R1, R0, R2 - R1 = 0 + 20 = 20
		#20;
		instruction_initialize_address = 4;
        instruction_initialize_data = 32'b001000_00000_00001_0000000000000011;         // SUBI R1, R0, 3  -> R1 = 0 - 3 = -3
        #20;
		instruction_initialize_address = 8;
		instruction_initialize_data = 32'b000000_00100_00011_01000_00000_10_0010;      // SUB R8, R4, R3 - R8 = 40 - 30 = 10
		#20;
		instruction_initialize_address = 12;
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0101;      // OR R7, R5, R6 - R7 = -63
		#20;
		instruction_initialize_address = 16;
		instruction_initialize_data = 32'b101011_00000_01001_00000_00000_00_1100;      // SW R9, 12(R0) - Add. 12 stores 90
		#20;
		instruction_initialize_address = 20;
		instruction_initialize_data = 32'b100011_00000_01100_00000_00000_00_1100;      // LW R12, 12(R0) - R12 Stores 90
		#20;
		instruction_initialize_address = 24;                                           // AND R7, R6, R5
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0100;      // Validating the AND operation 
		#20;
		instruction_initialize_address = 28;                                           // NOR R7, R6, R5
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0111;      // Validating the NOR operation 
		#20;
		instruction_initialize_address = 32;                                           // XOR R7, R6, R5
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0110;      // Validating the XOR operation 
	    #20;
	    instruction_initialize_address = 36;                                                        
	    instruction_initialize_data = 32'b000000_00010_00011_00001_00000_10_1010;      // SLT R1, R2, R3
		#20;
		instruction_initialize_address = 40;                                                        
	    instruction_initialize_data = 32'b000000_00011_00010_00001_00000_10_1010;      // SLT R1, R3, R2
		#20;
		instruction_initialize_address = 44;                                                        
	    instruction_initialize_data = 32'b001100_00110_00111_0000_0000_0010_0101;      // ANDI R7, R6, 37 R7 <= 40
		#20;
		instruction_initialize_address = 48;                                                        
	    instruction_initialize_data = 32'b001111_00000_00001_0000_0000_0100_0011;      // LUI R1, 67 R1 <= 67
		#20;
        instruction_initialize_address = 52;
		instruction_initialize_data = 32'b000101_00000_00001_0000_0000_0000_0010;      // BNE R0, R1, 2 (to the 69)
		#20;
		instruction_initialize_address = 56;                                                        
	    instruction_initialize_data = 32'b001111_00000_00001_0000_0000_0100_0011;      // LUI R1, 67 R1 <= 67
		#20;
		instruction_initialize_address = 60;                                                        
	    instruction_initialize_data = 32'b001111_00000_00001_0000_0000_0000_0000;      // LUI R1, 0 R1 <= 0
		#20;
		instruction_initialize_address = 64;                                                        
	    instruction_initialize_data = 32'b001111_00000_00001_0000_0000_0100_0101;      // LUI R1, 69 R1 <= 69
		#20;
		instruction_initialize_address = 68;                                                        
		instruction_initialize_data = 32'b000101_00000_00000_11111_11111_11_1111;      // BNE R0, R0, -1 (DONT STOP)
		#20;
		instruction_initialize_address = 72;                                                        
	    instruction_initialize_data = 32'b000010_000000_0000_0000_0000_0001_1001;      // J 100
		#20;
		instruction_initialize_address = 100;                                                        
		instruction_initialize_data = 32'b000100_00000_00000_11111_11111_11_1111;      // BEQ R0, R0, -1
		#20;

		
		initialize = 0;
		rst = 0;
		
		#500;
		$finish;
	end
      
always
    #5 clk = ~clk;
endmodule

