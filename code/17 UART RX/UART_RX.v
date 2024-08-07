module UART_RX
(
	CLK, Rstn, RX_Pin_In, RX_En_Sig, LED_Out
);

	input CLK, Rstn; // SW0
	input RX_Pin_In; // T5
	input RX_En_Sig; // SW1
	
	output [7:0] LED_Out;
	
	wire neg_sig;
	wire BPS_CLK;
	wire Count_Sig;
	wire RX_Done_Sig;	
	wire [7:0] RX_Data;	 	 
		 
	detect_module U1
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.RX_Pin_In(RX_Pin_In),  // input - from top
		.neg_sig(neg_sig)  // output - to U3
	);
	
	rx_bps_module U2
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.Count_Sig(Count_Sig),  // input - from U3
	   .BPS_CLK(BPS_CLK)  // output - to U3
	);	 
	
	rx_control_module U3
	(
		.CLK(CLK),
	   .Rstn(Rstn),
		.neg_sig(neg_sig),  // input - from U1
		.RX_En_Sig(RX_En_Sig),  // input - from top
		.RX_Pin_In(RX_Pin_In),  // input - from top
		.BPS_CLK(BPS_CLK),  // input - from U2
	   .Count_Sig(Count_Sig),  // output - to U2
		.RX_Data(RX_Data),  // output - to U4
		.RX_Done_Sig(RX_Done_Sig)  // output - to U4		  
	);
	
	display_module U4
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.RX_Done_Sig(RX_Done_Sig),	 // input - from U3 
		.RX_Data(RX_Data),  // input - from U3
		.LED_Out(LED_Out)  // output - to top
	);
	
endmodule
