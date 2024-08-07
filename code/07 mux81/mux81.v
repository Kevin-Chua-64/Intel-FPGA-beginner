module mux81(CSn, SW_In, Key_In0, Key_In1, Key_In2, Key_In3, Key_In4, Key_In5,Key_In6, Key_In7, LED_Out);

	parameter width = 1;

	input CSn;
	input [2:0]SW_In;
	input [width-1:0]Key_In0, Key_In1, Key_In2, Key_In3, Key_In4, Key_In5,Key_In6, Key_In7;
	output [width-1:0]LED_Out;
	
	mux81_module #(.width(width)) U1
	(
		.CSn(CSn),
		.A(SW_In),
		.D0(Key_In0),
		.D1(Key_In1),
		.D2(Key_In2),
		.D3(Key_In3),
		.D4(Key_In4),
		.D5(Key_In5),
		.D6(Key_In6),
		.D7(Key_In7),
		.Y(LED_Out)
	);
	
endmodule
