module clock
	(
		CLK, Rstn, DispDay, AdjustDay, AdjustHour, AdjustMin,
		Buzzer_Out, Digitron_Out, DigitronCS_Out, DigOutA,DigOutB
	);

	input CLK, Rstn; // KEY0
	input DispDay; // SW0
	input AdjustDay, AdjustHour, AdjustMin; // SW[3:1]
	output Buzzer_Out;
	output [7:0]Digitron_Out;
	output [3:0]DigitronCS_Out;
	output [3:0]DigOutA, DigOutB;
	
	wire [3:0]SecH, SecL, MinH, MinL, HourH, HourL;
	wire [2:0]Day;
	
	Time_module U1
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.DispDay(DispDay), // input - from top
		.AdjustDay(AdjustDay), // input - from top
		.AdjustHour(AdjustHour), // input - from top
		.AdjustMin(AdjustMin), // input - from top
		.SecH(SecH), // output - to U2, U3
		.SecL(SecL), // output - to U2, U3
		.MinH(MinH), // output - to U2, U3
		.MinL(MinL), // output - to U2, U3
		.HourH(HourH), // output - to U2
		.HourL(HourL), // output - to U2
		.Day(Day) // output - to U2
	);
	
	Display_module U2
	(
		.CLK(CLK),
		.DispDay(DispDay), // input - from top
		.SecH(SecH), // input - from U1
		.SecL(SecL), // input - from U1
		.MinH(MinH), // input - from U1
		.MinL(MinL), // input - from U1
		.HourH(HourH), // input - from U1
		.HourL(HourL), // input - from U1
		.Day(Day), // input - from U1
		.Digitron_Out(Digitron_Out), // output - to top
		.DigitronCS_Out(DigitronCS_Out), // output - to top
		.DigOutA(DigOutA), // output - to top
		.DigOutB(DigOutB) // output - to top
	);
	
	Buzzer_module U3
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.AdjustDay(AdjustDay), // input - from top
		.AdjustHour(AdjustHour), // input - from top
		.AdjustMin(AdjustMin), // input - from top
		.SecL(SecL), // input - from U1
		.SecH(SecH), // input - from U1
		.MinL(MinL), // input - from U1
		.MinH(MinH), // input - from U1
		.Buzzer_Out(Buzzer_Out) // output - to top
	);

endmodule
