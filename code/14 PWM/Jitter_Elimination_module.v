module Jitter_Elimination_module(CLK, Rstn, Button_In, Button_Out);

	input CLK, Rstn;
	input Button_In;
	output Button_Out;
	
	reg neg1; // The current state of the button
	reg neg2; // The previous state of the button
	
	always @ (posedge CLK, negedge Rstn)
		begin
			if (!Rstn)
				begin
					neg1 <= 1;
					neg2 <= 1;
				end
			else
				begin
					neg1 <= Button_In;
					neg2 <= neg1;
				end
		end
	
	assign Button_Out = ( (!neg1) & neg2 ) ? 1 : 0;

endmodule
