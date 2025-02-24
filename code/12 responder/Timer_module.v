module Timer_module(CLK, Rstn, Timer_Start, TimerH, TimerL, Buzzer_TimeOver, LED_OverTime);

	input CLK, Rstn;
	input Timer_Start;
	output reg [3:0]TimerH, TimerL;
	output reg Buzzer_TimeOver;
	output reg [3:0]LED_OverTime;
	
	reg CLK1; // period: 1s
	reg [24:0]Count = 0;
	reg count1 = 0; // Buzzer_TimeOver for 1s
	
	always @ (posedge CLK, negedge Timer_Start) // CLK1
		begin
			if (!Timer_Start)
				Count <= 0;
			else if (Count == 25'd25_000_000 - 1'b1)
				begin
					Count <= 0;
					CLK1 <= ~CLK1;
				end
			else
				Count <= Count + 1'b1;
		end
		
	always @ (posedge CLK1, negedge Rstn)
		begin
			if (!Rstn) // Reset
				begin
					TimerH <= 4'd3;
					TimerL <= 4'd0;
				end
			
			else if (Timer_Start) // Count down
				begin
					if (TimerL == 4'd0)
						begin
							if (TimerH == 4'd0)
								begin
									TimerH <= TimerH;
									TimerL <= TimerL;
								end
							else
								begin
									TimerH <= TimerH - 1'd1;
									TimerL <= 4'd9;
								end
						end
					else
						TimerL <= TimerL - 1'd1;
				end

		end
	
	always @ (posedge CLK1, negedge Rstn) // Buzzer_TimeOver for 1s
		begin
			if (!Rstn)
				begin
					count1 <= 0;
					Buzzer_TimeOver <= 0;
					LED_OverTime <= 4'b0;
				end
				
			else if (TimerH == 4'd0 && TimerL == 4'd0)
				begin
					if (count1 == 1)
						begin
							count1 <= 0;
							Buzzer_TimeOver <= 0;
							LED_OverTime <= 4'b0;
						end
					else
						begin
							count1 <= 1;
							Buzzer_TimeOver <= 1;
							LED_OverTime <= 4'b1111;
						end
				end
				
			else
				begin
					count1 <= 0;
					Buzzer_TimeOver <= 0;
					LED_OverTime <= 4'b0;
				end
		end

endmodule
