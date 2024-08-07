module Time_module
	(
		CLK, Rstn, DispDay, AdjustDay, AdjustHour, AdjustMin,
		SecH, SecL, MinH, MinL, HourH, HourL, Day
	);
	
	
	input CLK, Rstn;
	input DispDay, AdjustDay, AdjustHour, AdjustMin;
	output reg[3:0]SecH, SecL, MinH, MinL, HourH, HourL;
	output reg[2:0]Day;
		
	reg CLK1 = 0;
	reg [24:0]count = 0;
	
	always @ (posedge CLK) // CLK1
		begin
			if (count == 25'd25_000_000 - 1'b1)
				begin
					count <= 0;
					CLK1 <= ~CLK1;
				end
			else
				count <= count + 1'b1;
		end
	
	always @ (posedge CLK1, negedge Rstn)
		begin
			if (!Rstn) // Reset
					begin
						SecH = 0;
						SecL = 0;
						MinH = 0;
						MinL = 0;
						HourH = 0;
						HourL = 0;
						Day = 7;
					end
					
			else
				begin
					if (AdjustDay && DispDay) // Adjust day
						begin
							if (Day == 3'd7)
								Day <= 1;
							else
								Day <= Day + 1;
						end

					else if (AdjustHour && !DispDay) // Adjust hour
						begin
							if (HourL == 4'd9)
								begin
									HourL <= 0;
									HourH <= HourH + 1;
								end
							else
								begin
									if (HourH == 4'd2 && HourL == 4'd3)
										begin
											HourH <= 0;
											HourL <= 0;
										end
									else
										HourL <= HourL + 1;
								end
						end
					
					else if (AdjustMin && !DispDay) // Adjust minute
						begin
							if (MinL == 4'd9)
								begin
									MinL <= 0;
									if (MinH == 4'd5)
										MinH <= 0;
									else
										MinH <= MinH + 1;
								end
							else
								MinL <= MinL + 1;
						end

					else if (!AdjustDay && !AdjustHour && !AdjustMin) // Regular working
						begin
							if (SecL == 4'd9)
								begin
									SecL <= 0;
									if (SecH == 4'd5)
										begin
											SecH <= 0;
											if (MinL == 4'd9)
												begin
													MinL <= 0;
													if (MinH == 4'd5)
														begin
															MinH <= 0;
															if (HourL == 4'd9)
																begin
																	HourL <= 0;
																	HourH <= HourH + 1;
																end
															else if (HourH == 4'd2 && HourL == 4'd3)
																begin
																	HourH <= 0;
																	HourL <= 0;
																	if (Day == 3'd7)
																		Day <= 0;
																	else
																		Day <= Day + 1;
																end
																
															else
																HourL <= HourL + 1;
														end
													else
														MinH <= MinH + 1;
												end
											else
												MinL <= MinL + 1;
										end
									else
										SecH <= SecH + 1;
								end
							else
								SecL <= SecL + 1;
						end
						
					else // Others
						begin
							SecH <= SecH;
							SecL <= SecL;
							MinH <= MinH;
							MinL <= MinL;
							HourH <= HourH;
							HourL <= HourL;
							Day <= Day;
						end
				end		
					
		end
		
endmodule
