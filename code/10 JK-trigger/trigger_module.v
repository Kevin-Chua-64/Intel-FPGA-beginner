module trigger_module(CLK, Setn, Clrn, J, K, Q, Q_n);

	input CLK, Setn, Clrn;
	input [3:0]J, K;
	output reg [3:0]Q, Q_n;
	
	reg CLK1 = 0;
	reg [23:0]count = 0;
	
	parameter Time;
	
	always @ (posedge CLK)
		begin
			if (count == Time - 1'b1)
				begin
					CLK1 <= ~CLK1;
					count <= 0;
				end
			else
				count <= count + 1'b1;
		end
		
	always @ (posedge CLK1)
		begin
			Q[0] <= ( ( (J[0] & Q_n[0]) | (~K[0] & Q[0]) ) & Setn & Clrn ) | ~Setn;
			Q[1] <= ( ( (J[1] & Q_n[1]) | (~K[1] & Q[1]) ) & Setn & Clrn ) | ~Setn;
			Q[2] <= ( ( (J[2] & Q_n[2]) | (~K[2] & Q[2]) ) & Setn & Clrn ) | ~Setn;
			Q[3] <= ( ( (J[3] & Q_n[3]) | (~K[3] & Q[3]) ) & Setn & Clrn ) | ~Setn;
			Q_n[0] <= ~Q[0];
			Q_n[1] <= ~Q[1];
			Q_n[2] <= ~Q[2];
			Q_n[3] <= ~Q[3];
		end

endmodule
