`timescale 1ns / 1ns

module ALU(
    input [size-1:0] a,
    input [size-1:0] b,
	input [2:0] func,
    output reg [size-1:0] out,
    output reg zero_flag
    );
	parameter size = 32;
	 	
	always @(*) begin
		case (out) 
			0: zero_flag = 1'b1;
			default: zero_flag = 1'b0;
		endcase
	end
	
	always @(*) begin
		if (func == 3'd0) 
			out <= a+b;
		else if (func == 3'd1)
			out <= a-b;
		else if (func == 3'd2)
			out <= a&b;
		else if (func == 3'd3)
			out <= a|b;
		else if (func == 3'd4)
			out <= ~(a|b);
		else if (func == 3'd5) // Added this for bitwise XOR
			out <= a^b;
		else if (func == 3'd6) // SLT
			out <= $signed(a)<$signed(b) ? 1 : 0;
		else
			out <= b << 16; // LUI
   end



endmodule