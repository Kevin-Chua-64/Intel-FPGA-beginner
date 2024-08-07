module UART_TX
(
	CLK, Rstn, TX_Pin_Out
);

	input CLK, Rstn;  // SW0
	output TX_Pin_Out;
	
	wire TX_Done_Sig, TX_En_Sig, BPS_CLK;
	wire [7:0] TX_Data;
	
	data_control_module U1
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.TX_Done_Sig(TX_Done_Sig),  // input - from U3
		.TX_En_Sig(TX_En_Sig),  // output - to U2, U3
		.TX_Data(TX_Data)  // output [7:0] - to U3
	);
	
	tx_bps_module U2
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.Count_Sig(TX_En_Sig),  // input - from U1
		.BPS_CLK(BPS_CLK)  // output - to U3
	);
	
	tx_control_module U3
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.TX_En_Sig(TX_En_Sig),  // input - from U1
		.BPS_CLK(BPS_CLK),  // input - from U2
		.TX_Data(TX_Data),// input [7:0] - from U1
		.TX_Done_Sig(TX_Done_Sig),  // output - to U1
		.TX_Pin_Out(TX_Pin_Out) // output - to top
	);

endmodule
