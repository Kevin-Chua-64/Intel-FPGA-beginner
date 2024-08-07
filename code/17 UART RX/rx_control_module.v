module rx_control_module
(
	CLK, Rstn, neg_sig, RX_En_Sig, RX_Pin_In, BPS_CLK, Count_Sig, RX_Data, RX_Done_Sig
);

	input CLK, Rstn;
	input neg_sig;
	input RX_En_Sig;
	input RX_Pin_In;
	input BPS_CLK;
	
	output Count_Sig;
	output [7:0] RX_Data;
	output RX_Done_Sig;
	
	reg [3:0] State;
	reg [7:0] rData;
	reg isCount;		
	reg isDone;
	
	always @ (posedge CLK, negedge Rstn)
		if(!Rstn)
			begin
				State <= 4'd0;
				rData <= 8'd0;
				isCount <= 1'b0;
				isDone <= 1'b0;	 
			end
		else if(RX_En_Sig) // While RX_En_Sig = 1, Receive is Allowed
			case (State)
				4'd0: 
					if(neg_sig)
						begin 
							State <= State + 1'b1; 
							isCount <= 1'b1; 
						end
				4'd1:  // Start bit
					if(BPS_CLK)
						State <= State + 1'b1;
				
				4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9:  // Data bit
					if(BPS_CLK)
						begin 
							State <= State + 1'b1; 
							rData[State - 2] <= RX_Pin_In;
						end	 
				4'd10:  // Stop bit
					if(BPS_CLK)
						State <= State + 1'b1;
						
				4'd11:
					begin 
						State <= State + 1'b1; 
						isDone <= 1'b1;
						isCount <= 1'b0; 
					end
				4'd12:
					begin 
						State <= 1'b0; 
						isDone <= 1'b0;
					end
			endcase
			
		else
			begin
				State <= 4'd0;
				rData <= 8'd0;
				isCount <= 1'b0;
				isDone <= 1'b0;	 
			end
			
	assign Count_Sig = isCount;
	assign RX_Data = rData;
	assign RX_Done_Sig = isDone;
	 
endmodule
