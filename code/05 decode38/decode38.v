module decode38(Sw_In, LED_Out);
	
	input wire [2:0]Sw_In;
	output wire [7:0]LED_Out;

	decode_module U1
	(
		.a2(Sw_In[2]),
		.a1(Sw_In[1]),
		.a0(Sw_In[0]),
		.y7(LED_Out[7]),
		.y6(LED_Out[6]),
		.y5(LED_Out[5]),
		.y4(LED_Out[4]),
		.y3(LED_Out[3]),
		.y2(LED_Out[2]),
		.y1(LED_Out[1]),
		.y0(LED_Out[0])
	);
endmodule
