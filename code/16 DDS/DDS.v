module DDS
(
	CLK, Rstn, KW_Add_In, KW_Sub_In, SW_Sin_In, SW_Square_In, SW_Sawtooth_In, DA_Data
);

	input CLK, Rstn;  //SW0
	input KW_Add_In;	//KEY0
	input KW_Sub_In;	//KEY1
	input SW_Sin_In;	//SW1
	input SW_Square_In;  //SW2
	input SW_Sawtooth_In;  //SW3
	 
//	output DA_CLK;
	output [7:0] DA_Data;
	
	wire [11:0] KW;
	wire [7:0] Wave_Data;
	
	reg CLKDiv;  // The clock is divided to 500KHz for choose_wave_module
	reg [7:0] DivCnt;
	 
	always @ (posedge CLK, negedge Rstn) // CLKDiv
		begin
			if(!Rstn) 
				DivCnt <= 0;			
			else
				begin
					if(DivCnt==8'd49)
						begin
							DivCnt <= 0 ;
							CLKDiv <= ~CLKDiv ;
						end
					else
						DivCnt <= DivCnt + 1'b1 ;
				end
		end 
	 
	 
	frequency_adjust_module U1
	(
		.CLK( CLK ) ,	
		.Rstn( Rstn ) ,	
		.KW_Add_In( KW_Add_In ) ,	// input - from top
		.KW_Sub_In( KW_Sub_In ) ,	// input - from top
		.KW( KW ) 	// output - to U2
	);

	choose_wave_module U2
	(
		.CLK( CLKDiv ) ,	
		.Rstn( Rstn ) ,
		.SW_Sin_In( SW_Sin_In ) ,	// input - from top
		.SW_Square_In( SW_Square_In ) ,	// input - from top
		.SW_Sawtooth_In( SW_Sawtooth_In ) ,	// input - from top
		.KW( KW ) ,	// input - from U1
		.Wave_Data( Wave_Data ) 	// output - to U3
	);

	dac_module U3
	(
		.CLK( CLK ) ,	
		.Wave_Data( Wave_Data ) ,	// input - from U2
//		.DA_CLK( DA_CLK ) ,	// output - to top
		.DA_Data_Out( DA_Data ) 	// output - to top
	);


endmodule
