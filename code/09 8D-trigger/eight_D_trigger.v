module eight_D_trigger(CLK, SW_In, Setn, Clrn, LED_Out);
	
	input CLK, Setn, Clrn;
	input [7:0]SW_In;
	output [7:0]LED_Out;
	
	trigger_module u1
	(
		.CLK(CLK),
		.Setn(Setn),
		.Clrn(Clrn),
		.D(SW_In),
		.Q(LED_Out)
	);
	
endmodule
