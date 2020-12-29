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

//Create module for eight bit adder 
module eight_bit_adder (input [7:0] a, b, input cin, output [7:0] sum, output cout);

	//Declare wires for eight bit adder
	wire [6:0] carry;
			
	//Make instances of full_adder module to create eight bit adder
	full_adder zero(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));
	full_adder one(.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder two(.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder three(.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
	full_adder four(.a(a[4]), .b(b[4]), .cin(carry[3]), .sum(sum[4]), .cout(carry[4]));
	full_adder five(.a(a[5]), .b(b[5]), .cin(carry[4]), .sum(sum[5]), .cout(carry[5]));
	full_adder six(.a(a[6]), .b(b[6]), .cin(carry[5]), .sum(sum[6]), .cout(carry[6]));
	full_adder seven(.a(a[7]), .b(b[7]), .cin(carry[6]), .sum(sum[7]), .cout(cout));

endmodule