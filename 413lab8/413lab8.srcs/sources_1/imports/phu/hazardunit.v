module hazardunit(IFIDWrite,PCWrite,HazardMux, DestDepO, DestDepT, ReadRegO, ReadRegT, IsImm, IsJump, IsBranch, IsWBO, IsWBT);

	input [4:0]	DestDepO, DestDepT, ReadRegO, ReadRegT;
	input IsImm, IsJump, IsBranch; 
	input [1:0] IsWBO, IsWBT;
	output 	IFIDWrite, PCWrite, HazardMux;

	wire IDMEM_Dependency, IDEX_Dependency;

	assign IDMEM_Dependency = (IsImm ? ((IsBranch && ReadRegT == DestDepT) || ReadRegO == DestDepT):(ReadRegO == DestDepT || ReadRegT == DestDepT)) && !IsJump && (IsWBT != 0);
	assign IDEX_Dependency = (IsImm ? ((IsBranch && ReadRegT == DestDepO) || ReadRegO == DestDepO):(ReadRegO == DestDepO || ReadRegT == DestDepO)) && !IsJump && (IsWBO != 0);
	assign HazardMux = IDMEM_Dependency || IDEX_Dependency; //DestDep1 == OperandDep1 || DestDep2 == OperandDep1 || ((DestDep1 == OperandDep2  || (DestDep2 == OperandDep2 )) && !IsImm);
	assign PCWrite = ~HazardMux;
	assign IFIDWrite = ~HazardMux;

endmodule
