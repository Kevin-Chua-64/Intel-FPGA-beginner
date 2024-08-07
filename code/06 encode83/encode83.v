module encode83(CLK, SW_In, LED_Out);

	input CLK;
	input [7:0]SW_In;
	output [7:0]LED_Out;
	
	encode_module U1
	(
		.CLK(CLK),
		.x(SW_In),
		.y(LED_Out)
	);
	
endmodule
