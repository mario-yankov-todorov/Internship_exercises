// This is testbench for eight bit adder
module testbench;

	// Declare registers
	reg [7:0] a, b;
	reg cin;

	// Declare wires	
	wire [7:0] sum;
	wire cout;
	
	// Create instance of eight_bit_adder module
	eight_bit_adder dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

// Tests	
	initial begin
		$dumpvars (1, testbench);
		
      // Assign the specified values to the variables
		a = 0;
		b = 0;
		cin = 0;
		@(cout); // Wait for the carry output value to be calculated
		
		// Check that the initial values correspond to the expected ones
		// and return a message
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
		
		#10 // Set a delay of ten time units
		a = 255;
		b = 255;
		cin = 0;
		@(cout); 
		
		if (sum != 254 || cout != 1) begin
			$display ("2. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 254, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("2. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 254, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		#10
		a = 255;
		b = 255;
		cin = 1;
		@(sum);	// Wait for the sum output value to be calculated
		               // Here we wait for the sum output to change 
							// because the value of cout does not change 
							// since the previous check
			
		if (sum != 255 || cout != 1) begin
			$display ("3. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 255, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("3. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 255, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		
		#10
		a = 128;
		b = 32;
		cin = 1;
		@(cout);
		
		if (sum != 161 || cout != 0) begin
			$display ("4. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 161, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("4. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 161, 0);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		#10
		a = 255;
		b = 0;
		cin = 1;
		@(cout); 
		
		if (sum != 0 || cout != 1) begin
			$display ("5. ERROR: the output was wrong!");
			$display ("   Expected: sum = %0d, cout = %0d", 0, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("5. The output was correct!");
			$display ("   Expected: sum = %0d, cout = %0d", 0, 1);
			$display ("   Actual: sum = %0d, cout = %0d", sum, cout);
		end 
		$finish;

	end
endmodule