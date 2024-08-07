module Buzzer_module(CLK, Rstn, AdjustDay, AdjustHour, AdjustMin, SecL, SecH, MinL, MinH, Buzzer_Out);

	input CLK, Rstn;
	input AdjustDay, AdjustHour, AdjustMin;
	input [3:0]SecL, SecH, MinL, MinH;
	output Buzzer_Out;
	
	parameter Di = 16'd50_000; // Frequency is 500HZ, "di"
	parameter Da = 15'd25_000; // Frequency is 1000HZ, "da"
	
	reg [15:0]Count, Pulse_x;
	reg W_Buzzer = 1;
	
	always @ (posedge CLK)
		begin
			if (!AdjustDay && !AdjustHour && !AdjustMin)
				begin
					if (MinH == 4'd5 && MinL == 4'd9 && SecH == 4'd5)
						begin
							if ((SecL%2) == 0)
								Pulse_x <= Di;
							else
								Pulse_x <= 0;
						end
					else if (MinH == 4'd0 && MinL == 4'd0 && SecH == 4'd0 && SecL == 4'd0)
						Pulse_x <= Da;
					else
						Pulse_x <= 0;
				end
			else
				Pulse_x <= 0;
		end
		
	always @ (posedge CLK, negedge Rstn)
		begin
			if (!Rstn)
				begin
					Count <= 0;
					W_Buzzer <= 1;
				end
			else
				begin
					if ((Pulse_x == Di) | (Pulse_x == Da))
						begin
							if (Count == Pulse_x)
								begin
									Count <= 0;
									W_Buzzer <= ~W_Buzzer;
								end
							else
								Count <= Count + 1;
						end
					else
						begin
							Count <= 0;
							W_Buzzer <= 1;
						end
				end
		end
	
	assign Buzzer_Out = W_Buzzer;

endmodule
