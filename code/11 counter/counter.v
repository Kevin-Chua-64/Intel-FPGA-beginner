module counter(CLK, Rstn, DigOutA, DigOutB);

	input CLK, Rstn;
	output [3:0]DigOutA, DigOutB;
	
	count_module U1
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.result({DigOutB, DigOutA})
	);
	
endmodule
