module led8_module(CLK, RSTn, LED_Out);
	input CLK, RSTn;
	output [7:0]LED_Out;
	
	parameter T100MS = 26'd50000000;
	reg [25:0]Count;
	reg [7:0]rLED_Out;
	
	always @ (posedge CLK or negedge RSTn)
		if (!RSTn)
			begin 
				Count <= 26'd0;
				rLED_Out <= 8'b0000_0001;
			end
		else if (Count == T100MS - 1'b1)
			begin
				Count <= 26'd0;
				if (rLED_Out == 8'b0000_0000)
					rLED_Out <= 8'b0000_0001;
				else
					rLED_Out <= {rLED_Out[0], rLED_Out[7:1]};
			end
		else
			Count <= Count + 1'b1;
			
	assign LED_Out = rLED_Out;
	
endmodule
