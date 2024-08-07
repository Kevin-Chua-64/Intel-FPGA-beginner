module run_led(CLK, RSTn, LED_Out);
	input CLK, RSTn;
	output [7:0]LED_Out;
	
	led8_module U1
	(
	.CLK(CLK) ,	// input  CLK_sig
	.RSTn(RSTn) ,	// input  RSTn_sig
	.LED_Out(LED_Out) 	// output [7:0] LED_Out_sig
);

endmodule
