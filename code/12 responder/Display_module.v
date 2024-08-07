module Display_module(CLK, Player_Number, TimerH, TimerL, Digitron_Out, DigitronCS_Out);

	input CLK;
	input [3:0]Player_Number, TimerH, TimerL;
	output [7:0]Digitron_Out;
	output [3:0]DigitronCS_Out;
	
	reg [7:0]Count; // Count for chip selection
	reg [1:0]cnt; // Chip Selection
	reg [3:0]W_DigitronCS_Out;
	reg [3:0]SingleNum;
	reg [7:0]W_Digitron_Out;
	
	parameter _0 = 8'b0011_1111, _1 = 8'b0000_0110, _2 = 8'b0101_1011,
			 	 _3 = 8'b0100_1111, _4 = 8'b0110_0110, _5 = 8'b0110_1101,
			 	 _6 = 8'b0111_1101, _7 = 8'b0000_0111, _8 = 8'b0111_1111,
				 _9 = 8'b0110_1111;
				 
	always @ (posedge CLK)
		begin
			if (Count == 8'd200)
				begin
					Count <= 0;
					if (cnt == 2'b10)
						cnt <= 2'b00;
					else
						cnt <= cnt + 1'b1;
				end
			
			else
				Count <= Count + 1'b1;
		end
	
	always @ (cnt)
		begin
			case (cnt)
				2'b00: W_DigitronCS_Out = 4'b1110;
				2'b01: W_DigitronCS_Out = 4'b1011;
				2'b10: W_DigitronCS_Out = 4'b0111;
			endcase
		end
	
	always @ (W_DigitronCS_Out)
		begin
			case (W_DigitronCS_Out)
				4'b1110: SingleNum = Player_Number;
				4'b1011: SingleNum = TimerH;
				4'b0111: SingleNum = TimerL;			
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
	
	assign Digitron_Out = W_Digitron_Out;
	assign DigitronCS_Out = W_DigitronCS_Out;

endmodule
