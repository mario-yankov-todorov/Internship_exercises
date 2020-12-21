//This is testbench for two bit adder
module testbench;

//Declare registers
	reg [1:0] a, b;
	reg cin;
	
//Declare wires	
	wire [1:0] sum;
	wire cout;
	
//Create instance of full_adder module
	two_bit_adder dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

//Tests	
	initial begin
		$dumpvars (1, testbench);

		#10

		a = 0;
		b = 0;
		cin = 0;

		#10

		a = 1;
		b = 1;
		cin = 0;

		#10

		a = 1;
		b = 1;
		cin = 1;

		#10

		a = 1;
		b = 0;
		cin = 1;

		#10

		a = 0;
		b = 1;
		cin = 1;

		#10 $finish;

	end
endmodule
