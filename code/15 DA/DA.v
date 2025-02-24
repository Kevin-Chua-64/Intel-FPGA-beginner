module DA(CLK, Rstn, DA_Data);

	input CLK, Rstn;
	output reg [7:0] DA_Data;
	
	reg [7:0]Count = 0;
	reg CLK1 = 0;
	
	always @ (posedge CLK, negedge Rstn) //CLK1
		begin
			if (!Rstn)
				CLK1 <= 0;
			else if (Count == 8'd250 - 1'b1)
				begin
					Count <= 0;
					CLK1 <= ~CLK1;
				end
			else
				Count <= Count + 1'b1;
		end
		
	always @ (posedge CLK1, negedge Rstn)
		begin
			if (!Rstn)
				DA_Data <= 0;
			else if (DA_Data == 8'b11111111)
				DA_Data <= 0;
			else
				DA_Data <= DA_Data + 1'b1;
		end

endmodule
