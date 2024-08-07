module count_module(CLK, Rstn, result);

	input CLK, Rstn;
	output reg [7:0]result;
	
	reg CLK1 = 0;
	reg [25:0]Count = 0;
	
	parameter Time = 26'd25_000_000; // CLK1 period = 1s
	
	always @ (posedge CLK)
		begin
			if (Count == Time - 1'b1)
				begin
					CLK1 <= ~CLK1;
					Count <= 0;
				end
			else
				Count <= Count + 1'b1;
		end

	always @ (posedge CLK1, negedge Rstn)
		begin
			if (!Rstn)
				result <= 0;
			else if (result[7:4] == 4'b1001 && result[3:0] == 4'b1001) // determine the counter range
				begin
					result[7:4] <= 0;
					result[3:0] <= 0;
				end
			else if (result[3:0] == 4'b1001)
				begin
					result[7:4] <= result[7:4] + 1'b1;
					result[3:0] <= 0;
				end
			else
				result[3:0] <= result[3:0] + 1'b1;
		end
	
endmodule
