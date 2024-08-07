module adder(SW_In, LED_Out);
	input [2:0]SW_In;
	output [1:0]LED_Out;
	
	Adder_module U1
	(
		.a(SW_In[1]) ,	// input  a_sig
		.b(SW_In[0]) ,	// input  b_sig
		.c_in(SW_In[2]) ,	// input  c_in_sig
		.s(LED_Out[0]) ,	// input  s_sig
		.c_out(LED_Out[1]) 	// input  c_out_sig
	);
endmodule
