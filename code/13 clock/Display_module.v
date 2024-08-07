module Display_module
	(
		CLK, DispDay, SecL, SecH, MinL, MinH, HourL, HourH, Day,
		Digitron_Out, DigitronCS_Out, DigOutA, DigOutB
	);
	
	input CLK;
	input DispDay;
	input [3:0]SecL, SecH, MinL, MinH, HourL, HourH;
	input [2:0]Day;
	output [7:0]Digitron_Out;
	output [3:0]DigitronCS_Out;
	output [3:0]DigOutA, DigOutB;
	
	reg [3:0]W_DigOutA, W_DigOutB;
	reg [7:0]Count = 0; // Count for chip selection
	reg [1:0]cnt = 0; // Chip Selection
	reg [3:0]W_DigitronCS_Out;
	reg [3:0]SingleNum;
	reg [7:0]W_Digitron_Out;
	
	parameter _0 = 8'b0011_1111, _1 = 8'b0000_0110, _2 = 8'b0101_1011,
			 	 _3 = 8'b0100_1111, _4 = 8'b0110_0110, _5 = 8'b0110_1101,
			 	 _6 = 8'b0111_1101, _7 = 8'b0000_0111, _8 = 8'b0111_1111,
				 _9 = 8'b0110_1111;
	
	always @ (posedge CLK) // Display day or second
		begin
			if (DispDay)
				begin
					W_DigOutA <= Day;
					W_DigOutB <= 0;
				end
			else
				begin
					W_DigOutA <= SecL;
					W_DigOutB <= SecH;
				end
		end
		
	always @ (posedge CLK) // Chip selection
		begin
			if (Count == 8'd200 - 1'b1)
				begin
					Count <= 0;
					if (cnt == 2'b11)
						cnt <= 0;
					else
						cnt <= cnt + 1;
				end
			else
				Count <= Count + 1;
		end
		
	always @ (cnt) // Chip display value
		begin
			if (DispDay)
				W_DigitronCS_Out = 4'b1111;
			else
				begin
					case (cnt)
						2'b00: W_DigitronCS_Out = 4'b0111;
						2'b01: W_DigitronCS_Out = 4'b1011;
						2'b10: W_DigitronCS_Out = 4'b1101;
						2'b11: W_DigitronCS_Out = 4'b1110;
					endcase
				end
		end
		
	always @ (W_DigitronCS_Out)
		begin
			case (W_DigitronCS_Out)
				4'b0111: SingleNum = MinL;
				4'b1011: SingleNum = MinH;
				4'b1101: SingleNum = HourL;
				4'b1110: SingleNum = HourH;
			endcase
			
			case (SingleNum)
				0: W_Digitron_Out = _0;
				1: W_Digitron_Out = _1;
				2: W_Digitron_Out = _2;
				3: W_Digitron_Out = _3;
				4: W_Digitron_Out = _4;
				5: W_Digitron_Out = _5;
				6: W_Digitron_Out = _6;
				7: W_Digitron_Out = _7;
				8: W_Digitron_Out = _8;
				9: W_Digitron_Out = _9;
			endcase
		end
	
	assign DigOutA = W_DigOutA;
	assign DigOutB = W_DigOutB;
	assign DigitronCS_Out = W_DigitronCS_Out;
	assign Digitron_Out = W_Digitron_Out;

endmodule
