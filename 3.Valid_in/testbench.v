`timescale 1ns/100ps

module testbench                            ;
    // -------------------------------------------------------------------
    // Registers and wires
    reg                     clk             ;   // Clock
    reg                     rst             ;   // Reset
    reg                     btn             ;   // Button
    wire                    out             ;   // Wire for
                                                // the signal
    wire    [2    -1:0]     state_test      ;   // Wire for
                                                // testing the 
                                                // state reg 

    // -------------------------------------------------------------------
    // Create a task to check the values 		  
    task display_the_values                                 ;
	 
        input       [4    -1:0]     statement_number        ; 
	 
        input                       clk_expected            ;
        input                       rst_expected            ;
        input      [16    -1:0]     btn_expected            ;
        input      [16    -1:0]     out_expected            ;
        input       [2    -1:0]     state_test_expected     ;
		  
        input                       clk_actual              ;
        input                       rst_actual              ;
        input      [16    -1:0]     btn_actual              ;
        input      [16    -1:0]     out_actual              ;
        input       [2    -1:0]     state_test_actual       ;
		   
			
            if  (   clk_actual          !=   clk_expected      || 
                    rst_actual          !=   rst_expected      ||
                    btn_actual          !=   btn_expected      || 
                    out_actual          !=   out_expected      ||
                    state_test_actual   !=   state_test_expected  ) begin
						  
                    $display ()                                         ;
                    $display ("STATEMENT  %0d:            Time is:" ,
                               statement_number)					    ;
                    $display ("             ", $time)                   ;
                    $display (" Result: ERROR - the values were wrong!");
                    $display ()                                         ;
                    $display ("   Expected: clk = %0d  reset = %0d" ,
                              clk_expected, rst_expected)               ; 
                    $display ("             btn = %0d  out   = %0d" ,
                              btn_expected, out_expected)               ;
                    $display ("             state_test     = %0d"   ,
                              state_test_expected)                      ;
                    $display ()                                         ;
                    $display ("   Actual:   clk = %0d, reset = %0d" , 
                              clk_actual, rst_actual)                   ;
                    $display ("             btn = %0d, out   = %0d" ,
                              btn_actual, out_actual)                   ;
                    $display ("             state_test     = %0d"   ,
                              state_test_actual)                        ;
                    $display ()                                         ;
						
                    end 
					  
            else    begin
                    $display ()                                         ;
                    $display ("STATEMENT  %0d:            Time is:" ,
                               statement_number)					    ;
                    $display ("             ", $time)                   ;		
                    $display (" Result: The values were correct!")      ;
                    $display ()                                         ;
                    $display ("   Expected: clk = %0d  reset = %0d" ,
                              clk_expected, rst_expected)               ; 
                    $display ("             btn = %0d  out   = %0d" ,
                              btn_expected, out_expected)               ;
                    $display ("             state_test     = %0d" ,
                              state_test_expected)                      ; 
                    $display ()                                         ;
                    $display ("   Actual:   clk = %0d, reset = %0d" , 
                              clk_actual, rst_actual)                   ;
                    $display ("             btn = %0d, out   = %0d" ,
                              btn_actual, out_actual)                   ;
                    $display ("             state_test     = %0d" ,
                              state_test_actual)                        ;
                    $display ()                                         ;
						
                    end
				  
    endtask

    // -------------------------------------------------------------------
    // Create instance of valid_in_state_machine module
    valid_in_state_machine    dut 
    (   
            .clk            (clk)  		  	,	  
            .rst            (rst)           ,
            .btn            (btn)           ,
            .out            (out)           ,
            .state_test     (state_test)    
    );

    // -------------------------------------------------------------------
    // Presets
    initial begin
        $dumpvars   ( 1,   testbench )      ;

        clk         = 1                     ;   
        rst         = 1                     ;   
        btn         = 1                     ;   
        
    end

    // -------------------------------------------------------------------
    // Set when to change the clock 
    always #50 clk = ~clk                   ;


    // -------------------------------------------------------------------
    // TESTS              TESTS              TESTS              TESTS         
    // -------------------------------------------------------------------

    always    @    ( btn or rst or clk ) begin

        // ---------------------------------------------------------------
        #101 // At time 101 - right after  !!! posedge clk !!!                
        // Check that the actual values correspond to the expected ones!
        // The values entered below represent as follows: statement_number, 
        // clk_expected, reset_expected, button_expected, out_expected,
        // state_test_expected, clk_actual, reset_actual, button_actual,
        // out_actual, state_test_actual
        begin
            // Expected values: clk = 1,    rst = 1,    btn = 1, 
            //                  out = 0,    state_test = 0
            display_the_values( 1, 1, 1, 1, 0, 0, clk, rst, btn, 
                                out, state_test )                   ;
        end      

        // ---------------------------------------------------------------
        #50 // At time 151
        // Reset is false
        rst     =      0       ;

        // ---------------------------------------------------------------
        #50 // At time 201 - right after !!! posedge clk !!! 
        // The code execution is entered in the first case of the always
        // block (state_0) where when the button is pressed, the following
        // assignment is set - state <= state_1.

        // Display the values to check them
        begin
            // Expected values: clk = 1,    rst = 0,    btn = 1, 
            //                  out = 1,    state_test = 1 
            display_the_values( 2, 1, 0, 1, 1, 1, clk, rst, btn, 
                                out, state_test )                   ;
        end    

        // ---------------------------------------------------------------
        #100 // At time 301 - right after  !!! posedge clk !!!         
        begin
            // Check if on the next positive edge of the clock, the state 
            // changes directly to state 2, in which there is no signal
            // Expected values: clk = 1,    rst = 0,    btn = 1, 
            //                  out = 0,    state_test = 2
            display_the_values( 3, 1, 0, 1, 0, 2, clk, rst, btn, 
                                out, state_test )                   ;
        end     

        // ---------------------------------------------------------------
        #100 // At time 401 - right after  !!! posedge clk !!!         
        begin
            // Check that the state is still the same
            // while the button is pressed
            // Expected values: clk = 1,    rst = 0,    btn = 1, 
            //                  out = 0,    state_test = 2 
            display_the_values( 4, 1, 0, 1, 0, 2, clk, rst, btn, 
                                out, state_test )                   ;
        end 

        // ---------------------------------------------------------------
        #50 // At time 451
        // Button is false
        btn     =      0       ;

        // ---------------------------------------------------------------
        #50 // At time 501 - right after  !!! posedge clk !!!         
        begin
            // Check whether the state is returned to state 0,
            // when the button is no longer active 
            // Expected values: clk = 1,    rst = 0,    btn = 0, 
            //                  out = 0,    state_test = 0 
            display_the_values( 5, 1, 0, 0, 0, 0, clk, rst, btn, 
                                out, state_test )                   ;
        end

        // ---------------------------------------------------------------
        #50 // At time 551
        // Button is true
        btn     =      1       ;

        // ---------------------------------------------------------------
        #50 // At time 601 - right after  !!! posedge clk !!!         
        begin
            // Expected values: clk = 1,    rst = 0,    btn = 1, 
            //                  out = 1,    state_test = 1 
            display_the_values( 6, 1, 0, 1, 1, 1, clk, rst, btn, 
                                out, state_test )                   ;
        end

        // ---------------------------------------------------------------
        #50 // At time 651
        // Button is false
        btn     =      0       ;

        // ---------------------------------------------------------------
        #50 // At time 700 - right after  !!! posedge clk !!!         
        begin
            // Expected values: clk = 1,    rst = 0,    btn = 0, 
            //                  out = 0,    state_test = 2 
            display_the_values( 7, 1, 0, 0, 0, 2, clk, rst, btn, 
                                out, state_test )                   ;
        end

        // ---------------------------------------------------------------
        #100 // At time 700 - right after  !!! posedge clk !!!         
        begin
            // Expected values: clk = 1,    rst = 0,    btn = 0, 
            //                  out = 0,    state_test = 0 
            display_the_values( 8, 1, 0, 0, 0, 0, clk, rst, btn, 
                                out, state_test )                   ;
        end
		  
		  #100
		  $finish;

    end
    
		  
endmodule
