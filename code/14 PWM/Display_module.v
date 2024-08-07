module Display_module
(
	CLK, Rstn, Count_D_Display, Count_P_Display, Count_D, Count_P, Duty,
	Digitron_Out, DigitronCS_Out, DigOutA, DigOutB
);

	input CLK, Rstn;
	input Count_D_Display, Count_P_Display;
	input [7:0] Duty;
	input [23:0] Count_D, Count_P;
	output [7:0] Digitron_Out;
	output [3:0] DigitronCS_Out;
	output reg [3:0] DigOutA, DigOutB;
	
	reg [7:0]Count = 0; // Count for chip selection
	reg [1:0]cnt = 0; // Chip Selection
	reg [3:0]W_DigitronCS_Out;
	reg [4:0]SingleNum;
	reg [7:0]W_Digitron_Out;
	
	parameter _0 = 8'b0011_1111, _1 = 8'b0000_0110, _2 = 8'b0101_1011,
			 	 _3 = 8'b0100_1111, _4 = 8'b0110_0110, _5 = 8'b0110_1101,
			 	 _6 = 8'b0111_1101, _7 = 8'b0000_0111, _8 = 8'b0111_1111,
				 _9 = 8'b0110_1111, _A = 8'b0111_0111, _B = 8'b0111_1100,
				 _C = 8'b0011_1001, _D = 8'b0101_1110, _E = 8'b0111_1001,
				 _F = 8'b0111_0001, _None = 8'b0000_0000;
	
	always @ (posedge CLK) // Chip selection
		begin
			if (Count == 8'd200 - 1'b1)
				begin
					Count <= 0;
					if (cnt == 2'b11)
						cnt <= 2'b00;
					else
						cnt <= cnt + 1;
				end
			else
				Count <= Count + 1;
		end
		
	always @ (cnt, Rstn) // Chip display value
		begin
			if (!Rstn)
				W_DigitronCS_Out <= 4'b1111;
			else
				begin
					case (cnt)
						2'b00: W_DigitronCS_Out <= 4'b0111;
						2'b01: W_DigitronCS_Out <= 4'b1011;
						2'b10: W_DigitronCS_Out <= 4'b1101;
						2'b11: W_DigitronCS_Out <= 4'b1110;
					endcase
				end
		end
		
	always @ (W_DigitronCS_Out, Rstn)
		begin
			if (!Rstn)
				begin
					DigOutA <= 4'b1111;
					DigOutB <= 4'b1111;
				end
			else
				begin
					if (!Count_D_Display && !Count_P_Display) // Only display duty (decimal)
						begin
							DigOutA = Duty % 10;
							DigOutB = ( Duty / 10 ) % 10;
							case (W_DigitronCS_Out)
								4'b0111: SingleNum = ( Duty / 100 ) % 10;
								default: SingleNum = 5'b11111;
							endcase
						end
					else if (Count_D_Display && !Count_P_Display) // Display D_Count (hexadecimal)
						begin
							DigOutA = Count_D[3:0];
							DigOutB = Count_D[7:4];					
							case(W_DigitronCS_Out)
								4'b0111: SingleNum = Count_D[11:8];
								4'b1011: SingleNum = Count_D[15:12];
								4'b1101: SingleNum = Count_D[19:16];
								4'b1110: SingleNum = Count_D[23:20];
							endcase
						end
					else if (!Count_D_Display && Count_P_Display) // Display P_Count (hexadecimal)
						begin
							DigOutA = Count_P[3:0];
							DigOutB = Count_P[7:4];					
							case(W_DigitronCS_Out)
								4'b0111: SingleNum = Count_P[11:8];
								4'b1011: SingleNum = Count_P[15:12];
								4'b1101: SingleNum = Count_P[19:16];
								4'b1110: SingleNum = Count_P[23:20];
							endcase
						end
					else // FFFFFF
						begin
							DigOutA = 4'b1111;
							DigOutB = 4'b1111;					
							SingleNum = 4'b1111;
						end
					
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
						10: W_Digitron_Out = _A;
						11: W_Digitron_Out = _B;
						12: W_Digitron_Out = _C;
						13: W_Digitron_Out = _D;
						14: W_Digitron_Out = _E;
						15: W_Digitron_Out = _F;
						5'b11111: W_Digitron_Out = _None;
					endcase
				end	
		end
	
	assign Digitron_Out = W_Digitron_Out;
	assign DigitronCS_Out = W_DigitronCS_Out;

endmodule
