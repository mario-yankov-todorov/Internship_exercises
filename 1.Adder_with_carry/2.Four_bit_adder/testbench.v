//This is testbench for four bit adder
module testbench;

	//Declare registers
	reg [3:0] a, b;
	reg cin;

	//Declare wires	
	wire [3:0] sum;
	wire cout;
	
	//Create instance of four_bit_adder module
	four_bit_adder dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

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
			$display ("1. ERROR: the output was wrong!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 0, 0);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("1. The output was correct!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 0, 0);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 15;
		b = 15;
		cin = 0;
		#10
		if (sum != 14 || cout != 1) begin
			$display ("2. ERROR: the output was wrong!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 14, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("2. The output was correct!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 14, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 15;
		b = 15;
		cin = 1;
		#10
		if (sum != 15 || cout != 1) begin
			$display ("3. ERROR: the output was wrong!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 15, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("3. The output was correct!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 15, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 9;
		b = 10;
		cin = 1;
		#10
		if (sum != 4 || cout != 1) begin
			$display ("4. ERROR: the output was wrong!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 4, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("4. The output was correct!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 4, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);
		end

		a = 7;
		b = 9;
		cin = 0;
		#10 
		if (sum != 0 || cout != 1) begin
			$display ("5. ERROR: the output was wrong!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 0, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);   		
		end 
		else begin
			$display ("5. The output was correct!" );
			$display ( "   Expected: sum = %0d, cout = %0d", 0, 1);
			$display ( "   Actual: sum = %0d, cout = %0d", sum, cout);
		end 
		$finish;

	end
endmodule