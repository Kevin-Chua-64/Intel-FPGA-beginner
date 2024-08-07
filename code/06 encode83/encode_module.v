module encode_module(CLK, x, y);

	input CLK;
	input [7:0]x;
	output reg [7:0]y;
	
	always @ (posedge CLK)
		case(x)
			8'd1: y <= 3'b000;
			8'd2: y <= 3'b001;
			8'd4: y <= 3'b010;
			8'd8: y <= 3'b011;
			8'd16: y <= 3'b100;
			8'd32: y <= 3'b101;
			8'd64: y <= 3'b110;
			8'd128: y <= 3'b111;
			default: y <= 8'b1111_1111;
		endcase

endmodule
			