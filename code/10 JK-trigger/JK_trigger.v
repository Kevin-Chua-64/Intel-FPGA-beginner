module JK_trigger(CLK, Setn, Clrn, SW_In, LED_Out);

	input CLK, Setn, Clrn;
	input [7:0]SW_In;
	output [7:0]LED_Out;
	
	trigger_module #(.Time(24'd5000000)) U1 // CLK1 = 10Hz
	(
		.CLK(CLK) ,
		.Setn(Setn) ,
		.Clrn(Clrn) ,
		.J(SW_In[7:4]) ,
		.K(SW_In[3:0]) ,
		.Q(LED_Out[7:4]) ,
		.Q_n(LED_Out[3:0])
	);
	
endmodule
