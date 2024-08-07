module Buzzer_module(CLK, Buzzer_Answer, Buzzer_TimeOver, Buzzer_Out);

	input CLK;
	input Buzzer_Answer, Buzzer_TimeOver;
	output Buzzer_Out;
	
	parameter _Answer = 17'd95419, _TimeOver = 17'd50607;
	
	reg [16:0]Pulse_x = 0;
	reg [16:0]Count = 0;
	reg W_buzzer = 1;
	
	always @ (posedge CLK) // if ring, select the type
		begin
			if (Buzzer_Answer)
				Pulse_x <= _Answer;
			else if (Buzzer_TimeOver)
				Pulse_x <= _TimeOver;
			else
				Pulse_x <= 0;
		end
		
	always @ (posedge CLK) // ring
		begin
			if ( (Pulse_x == _Answer) | (Pulse_x == _TimeOver) )
				begin
					if (Count == Pulse_x)
						begin
							Count <= 0;
							W_buzzer <= ~W_buzzer;
						end
					else
						Count <= Count + 1'b1;
				end
			else
				begin
					Count <= 0;
					W_buzzer <= 1;
				end
		end
		
	assign Buzzer_Out = W_buzzer;

endmodule
