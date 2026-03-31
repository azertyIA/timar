`timescale 1ns / 1ns

module register_file_tb;

reg clk, RegWrite;
reg [31:0] write_data;
reg [4:0] read_sel_1, read_sel_2, write_address; 
wire [31:0] read_data_1, read_data_2;

nbit_register_file the_registein_files(write_data, read_data_1, read_data_2, read_sel_1, read_sel_2, write_address, RegWrite, clk);

always #5 clk = ~clk;

initial begin 
    clk <= 0;
    RegWrite <= 0;
    #3
    #5
    read_sel_1 <= 3;
    read_sel_2 <= 13;
    write_address <= 14;
    write_data <= 32'hFFFFFFFF;
    #5
    read_sel_1 <= 14;
    read_sel_2 <= 14;
    RegWrite <= 1;
end

endmodule