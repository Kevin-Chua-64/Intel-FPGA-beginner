module data_control_module
(
	CLK, Rstn, TX_Done_Sig, TX_En_Sig, TX_Data
);
	input CLK, Rstn;
	input TX_Done_Sig;
	output TX_En_Sig;
	output [7:0] TX_Data;
	
	reg isTX; // Enable signal
	reg [7:0] rTX_Data;
	reg [3:0] i; // The index of the transmitted data
	
	reg [31:0] Count; // Count for 1s
	parameter T1s = 32'd50_000_000;
	parameter _0A = 8'b0000_1010, _0B = 8'b0000_1011, _0C = 8'b0000_1100,
			 	 _0D = 8'b0000_1101, _0E = 8'b0000_1110, _0F = 8'b0000_1111;
			
	always @ (posedge CLK, negedge Rstn)
		begin
			if(!Rstn)
				begin
					isTX <= 0;
					i <= 'd5;
				end
				
			else if(TX_Done_Sig)
				begin
					isTX <= 0;
					Count <= Count + 1'b1;
				end
				
			else if (Count == T1s - 1'b1) // every 1s
				begin
					isTX <= 1'b1;
					Count <= 0;
					// Data transmit
					if(i == 'd5)
						i <= 0;
					else 
						i <= i + 1'b1;  
				end
				
			else 
				Count <= Count + 1'b1;
			
			case(i)
				'd0: rTX_Data  <= _0A;
				'd1: rTX_Data  <= _0B;
				'd2: rTX_Data  <= _0C;
				'd3: rTX_Data	<= _0D;
				'd4: rTX_Data  <= _0E;
				'd5: rTX_Data  <= _0F;
			endcase   
		end
	
	assign TX_Data = rTX_Data;
	assign TX_En_Sig = isTX;
	
endmodule
