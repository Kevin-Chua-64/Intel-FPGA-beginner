module PWM
(
	CLK, Rstn, AddDuty, SubDuty, AddPeriod, SubPeriod, Count_D_Display, Count_P_Display,
	Digitron_Out, DigitronCS_Out, DigOutA, DigOutB, PWM_LED_Out
);

	input CLK, Rstn; // SW0
	input AddDuty, SubDuty, AddPeriod, SubPeriod; // KEY[3:0]
	input Count_P_Display, Count_D_Display; // SW[2:1]
	output [3:0] DigitronCS_Out;
	output [7:0] Digitron_Out;
	output [3:0] DigOutA, DigOutB;
	output PWM_LED_Out;
	
	wire [7:0] Duty; // 0~100
	wire [23:0] Count_P, Count_D;
	
	Adjust_module U1
	(
		.CLK(CLK),
		.Rstn(Rstn), 
		.AddDuty(AddDuty), // input - from top
		.SubDuty(SubDuty), // input - from top
		.AddPeriod(AddPeriod), // input - from top
		.SubPeriod(SubPeriod), // input - from top
		.Duty(Duty), // output[7:0] - to U2, U3
		.Count_P(Count_P) // output[23:0] - to U2, U3
	);
	
	PWM_Generate_module U2
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.Duty(Duty), // input[7:0] - from U1
		.Count_P(Count_P), // input[23:0] - from U1
		.Count_D(Count_D), // output[23:0] - to U3
		.PWM_LED_Out(PWM_LED_Out) // output - to top
	);
	
	Display_module U3
	(
		.CLK(CLK),
		.Rstn(Rstn),
		.Count_D_Display(Count_D_Display), // input - from top
		.Count_P_Display(Count_P_Display), // input - from top
		.Count_D(Count_D), // input[23:0] - from U2
		.Count_P(Count_P), // input[23:0] - from U1
		.Duty(Duty), // input[7:0] - from U1
		.Digitron_Out(Digitron_Out), // output - to top
		.DigitronCS_Out(DigitronCS_Out), // output - to top
		.DigOutA(DigOutA), // output - to top
		.DigOutB(DigOutB) // output - to top
	);

endmodule
