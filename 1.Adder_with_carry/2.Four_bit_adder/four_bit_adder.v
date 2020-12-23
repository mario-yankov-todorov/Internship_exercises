//Create module full_adder
module full_adder (input a, b, cin, output cout, sum);

	//Declare wires for full adder
	wire half_carry_ab, half_sum, half_carry_cin;

	//Create logic gates
	and (half_carry_ab, a, b);
	xor (half_sum, a, b);
	and (half_carry_cin, half_sum, cin);
	xor (sum, half_sum, cin);
	or (cout, half_carry_ab, half_carry_cin);

endmodule

//Create module for four bit adder 
module four_bit_adder (input [3:0] a, b, input cin, output [3:0] sum, output cout);

	//Declare wires for four bit adder
	wire [2:0] carry;
			
	//Make instances of full_adder module to create four bit adder
	full_adder zero(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));
	full_adder one(.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder two(.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder three(.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(cout));

endmodule