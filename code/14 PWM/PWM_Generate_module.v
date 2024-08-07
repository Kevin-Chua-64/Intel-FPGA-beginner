module PWM_Generate_module(CLK, Rstn, Duty, Count_P, Count_D, PWM_LED_Out);
	
	input CLK, Rstn;
	input [7:0] Duty;
	input [23:0] Count_P;
	output [23:0] Count_D;
	output reg PWM_LED_Out;
	
	reg [23:0] cnt; // at every edge, cyclical growth
	
	assign Count_D = Count_P * Duty / 'd100;
	
	always @ (posedge CLK, negedge Rstn)
		begin
			if (!Rstn)
				cnt <= 0;
			else if (cnt == Count_P - 1'b1)
				cnt <= 0;
			else
				cnt <= cnt + 1;
		end
		
	always @ (posedge CLK, negedge Rstn)
		begin
			if (!Rstn)
				PWM_LED_Out <= 0;
			else if (cnt <= Count_D)
				PWM_LED_Out <= 1;
			else
				PWM_LED_Out <= 0;
		end

endmodule
