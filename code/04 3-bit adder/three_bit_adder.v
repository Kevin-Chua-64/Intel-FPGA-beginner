module three_bit_adder(SW_In, LED_Out);
	input [6:0]SW_In;
	output [3:0]LED_Out;
	wire c1, c2;
	
	Adder_module U0 (.a(SW_In[1]), .b(SW_In[4]), .c_in(SW_In[0]), .s(LED_Out[0]), .c_out(c1));
	Adder_module U1 (.a(SW_In[2]), .b(SW_In[5]), .c_in(c1), .s(LED_Out[1]), .c_out(c2));
	Adder_module U2 (.a(SW_In[3]), .b(SW_In[6]), .c_in(c2), .s(LED_Out[2]), .c_out(LED_Out[3]));
	
endmodule
 