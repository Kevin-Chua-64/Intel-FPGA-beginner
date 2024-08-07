module Adder_module(a, b, c_in, s, c_out);
	input wire a, b, c_in;
	output wire s, c_out;
	
	assign s = c_in ^ (a ^ b);
	assign c_out = (a&b) | (c_in & (a^b));
	
endmodule
