module detect_module
(
	CLK, Rstn, RX_Pin_In, neg_sig
);
	input CLK, Rstn;
	input RX_Pin_In;
	output neg_sig; 
	 
	reg neg1, neg2;
	
	always @ (posedge CLK, negedge Rstn)
		if (!Rstn)
			begin
				neg1 <= 1'b1;
				neg2 <= 1'b1;
			end
		else
			begin
				neg1 <= RX_Pin_In;
				neg2 <= neg1;
			end
					
	assign neg_sig = (neg2 & !neg1) ? 1'b1 : 1'b0;
	
endmodule
