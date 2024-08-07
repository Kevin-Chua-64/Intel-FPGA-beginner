module Select_module(CLK, Rstn, Start, K1, K2, K3, K4, LED_Out, Player_Number, Buzzer_Answer, Timer_Start);

	input CLK, Rstn, Start;
	input K1, K2, K3, K4;
	output reg [3:0]LED_Out, Player_Number;
	output reg Buzzer_Answer, Timer_Start; // Determine if someone has pressed the button, nobody: Timer_Start == 0
	
	reg [24:0]Count = 0;
	
	always @ (posedge CLK, negedge Rstn)
		begin
			if (!Rstn) // Reset
				begin
					Count <= 'd0;
					LED_Out <= 4'b0;
					Player_Number <= 4'd0;
					Buzzer_Answer <= 0;
					Timer_Start <= 0;
				end
			
			else if (Start) // Start
				begin
					if (Timer_Start) // Someone has pressed the button, buzzer for 0.5s
						begin
							if (Count == 25'd25_000_000 - 1'b1)
								Buzzer_Answer <= 0;
							else
								begin
									Count <= Count + 1'b1;
									Buzzer_Answer <= 1;
								end
						end
						
					else if (!K1 && !Timer_Start)
						begin
							LED_Out <= 4'b0001;
							Player_Number <= 4'd1;
							Timer_Start <= 1;
						end
					else if (!K2 && !Timer_Start)
						begin
							LED_Out <= 4'b0010;
							Player_Number <= 4'd2;
							Timer_Start <= 1;
						end
					else if (!K3 && !Timer_Start)
						begin
							LED_Out <= 4'b0100;
							Player_Number <= 4'd3;
							Timer_Start <= 1;
						end
					else if (!K4 && !Timer_Start)
						begin
							LED_Out <= 4'b1000;
							Player_Number <= 4'd4;
							Timer_Start <= 1;
						end
				end
				
		end
		
endmodule
