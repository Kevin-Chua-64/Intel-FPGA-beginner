module D_trigger(CLK, SW_In, Setn, Clrn, LED_Out);

	input CLK, SW_In, Setn, Clrn;
	output LED_Out;
	
	nand U1 (f1, Setn, f4, f2),
			U2 (f2, f1, f5, Clrn),
			U3 (f3, Setn, f6, f4),
			U4 (f4, f3, CLK, Clrn),
			U5 (f5, f4, Setn, CLK, f6),
			U6 (f6, f5, SW_In, Clrn);
	assign LED_Out = f1;
	
endmodule
	