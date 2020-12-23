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

		//Assign the specified values to the variables
		a = 0;
		b = 0;
		cin = 0;	
		#10 //Set a delay of ten time units
		//Check that the initial values correspond to the expected ones
		//and return a message
		if (sum != 0 || cout != 0) begin
			$display ("1. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 0, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("1. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 0, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 3;
		b = 3;
		cin = 0;
		#10
		if (sum != 2 || cout != 1) begin
			$display ("2. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 2, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("2. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 2, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 3;
		b = 3;
		cin = 1;
		#10
		if (sum != 3 || cout != 1) begin
			$display ("3. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 3, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("3. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 3, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 1;
		b = 1;
		cin = 1;
		#10
		if (sum != 3 || cout != 0) begin
			$display ("4. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 3, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("4. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 3, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 1;
		b = 0;
		cin = 1;
		#10 
		if (sum != 2 || cout != 0) begin
			$display ("5. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 2, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("5. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 2, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end 

		$finish;

	end
endmodule
