`timescale 1ns/100ps

module testbench                         ;

        // ---------------------------------------------------------------
        // Registers and wire
        reg    [16    -1:0]    in        ;
        wire   [16    -1:0]    out       ;     
        reg                    reset     ;
        reg                    clk       ;
		  
        // ---------------------------------------------------------------
            // Create a task to check the values 		  
            task print_the_values                               ;
	 
                input     [4    -1:0]    print_number           ; 
	 
                input                    clk_expected           ;
                input                    reset_expected         ;
                input    [16    -1:0]    in_expected            ;
                input    [16    -1:0]    out_expected           ;
		  
                input                    clk_actual             ;
                input                    reset_actual           ;
                input    [16    -1:0]    in_actual              ;
                input    [16    -1:0]    out_actual             ;
		  
		 
                    if  (   clk_actual   !=   clk_expected    || 
                            reset_actual !=   reset_expected  ||
                            in_actual    !=   in_expected     || 
                            out_actual   !=   out_expected        )  begin
				  
                            $display ()                                        ;
                            $display ("%0d. ERROR: the values were wrong!"  ,
                                      print_number)                            ;
                            $display ()                                        ;
                            $display ("   Expected: clk = %0d  reset = %0d" ,
                                      clk_expected, reset_expected)            ; 
                            $display ("             in  = %0d  out   = %0d" ,
                                      in_expected, out_expected)               ;
                            $display ()                                        ;
                            $display ("   Actual:   clk = %0d, reset = %0d" , 
                                      clk_actual, reset_actual)                ;
                            $display ("             in  = %0d, out   = %0d" ,
                                      in_actual, out_actual)                   ;
                            $display ()                                        ;
						
                            end 
					  
                    else    begin
				  
                            $display ()                                        ;
                            $display ("%0d. The values were correct!"       ,
                                      print_number)                           ;
                            $display ()                                        ;
                            $display ("   Expected: clk = %0d  reset = %0d" ,
                                      clk_expected,  reset_expected)           ; 
                            $display ("             in  = %0d  out   = %0d" ,
                                      in_expected,  out_expected)              ; 
                            $display ()                                        ;
                            $display ("   Actual:   clk = %0d, reset = %0d" , 
                                      clk_actual, reset_actual)                ;
                            $display ("             in  = %0d, out   = %0d" ,
                                      in_actual, out_actual)                   ;
                            $display ()                                        ;
						
                            end
				  
            endtask
				
		  
        // ---------------------------------------------------------------
        // Create instance of adder_with_feedback module
        adder_with_feedback    dut    
        (        .in       (in)          ,
                 .out      (out)         ,
                 .reset    (reset)       ,
                 .clk      (clk)  				  
        );
			
        // ---------------------------------------------------------------
        // Presets
        initial begin
            $dumpvars    ( 1, testbench )    ;
				
            clk          = 1                 ;
            reset        = 1                 ;
        
        end
		  
        // ---------------------------------------------------------------
        // Set when to change the clock 
        always #50 clk = ~clk; // Thе clock will change at any time
                               // multiple of 50 (that is, a time
                               // which can be divided by 50,
                               // with no remainder).
                               // In this case the clock is initially
                               // equal to 1 and it will change to 0,
                               // at time 50. That means that at
                               // any time multiple of 100 the clock
                               // will be equal back to 1. And after 
                               // 50 simulation time units (#50), it
                               // will be equal back to 0.

        // And this way, according to adder_with_feedback.v file, we save
        // the current sum from adder to the register, at the moment when
        // the clock becomes equal to 1 (If reset = 0). Of course, if
        // reset = 1, in that moment (when clock becomes equal to 1), 
        // the register becomes equal to 0.
 
 
        // ---------------------------------------------------------------
        // TESTS              TESTS              TESTS              TESTS         
        // ---------------------------------------------------------------
		  

        always    @    ( in or out or clk )    begin
		  
         #0 // Delay of 0 time units (for readability of the document)        
         // --------------------------------------------------------------		  
          //  At time    0    ! clk = 1 !       !!    posedge    !!
                                       //  !! start procedural block !!    
          in       =    16'd    5    ; //     reset =   1   in =   5
                                       // -------------------------------
                                       //     out   =   0,  because the
                                       //     reset is true at posedge
         // --------------------------------------------------------------		  

         #25
         // --------------------------------------------------------------		  
          //  At time   25    ! clk = 1 !
                                       //   
          reset    =            0    ; //      reset =   0   in =   5
                                       // -------------------------------
                                       //      out   =   0,  because the
                                       //      reset was true at the last
                                       //      positive edge
         // --------------------------------------------------------------
		  			 
         #75
         // --------------------------------------------------------------		  
          //  At time  100    ! clk = 1 !       !!    posedge    !!
                                       //  !! start procedural block !!    
          in       =    16'd    5    ; //     reset =   0   in =   5
          // wait for the output        // -------------------------------	 
          @     (out)                ; //     out   =   0(out) +   5(in)
                                       //     out   =   5
         // --------------------------------------------------------------
             begin
                 print_the_values(1, 1, 0, 5, 5, clk, reset, in, out)    ;
             end      
         // --------------------------------------------------------------
			
         #100
         // --------------------------------------------------------------		  
          //  At time  200    ! clk = 1 !       !!    posedge    !!
                                       //  !! start procedural block !!    
          in       =    16'd    5    ; //     reset =   0   in =   5
          // wait for the output        // -------------------------------	 
          @     (out)                ; //     out   =   5(out) +   5(in)
                                       //     out   =  10
         // --------------------------------------------------------------
             begin
                 print_the_values(2, 1, 0, 5, 10, clk, reset, in, out)   ;
             end      
         // --------------------------------------------------------------
	  
         #100
         // --------------------------------------------------------------		  
          //  At time  300    ! clk = 1 !       !!    posedge    !!
                                       //  !! start procedural block !!    
          in       =    16'd  200    ; //     reset =   0   in =  200
          // wait for the output        // -------------------------------	 
          @     (out)                ; //     out   =   10(out) + 200(in)
                                       //     out   =  210
         // --------------------------------------------------------------
             begin
                 print_the_values(3, 1, 0, 200, 210, clk, reset, in, out);
             end      
         // --------------------------------------------------------------
         #100 // At time 400 - stop the tests 
                                                 
          $finish                                                        ;
	 
         end
		  
endmodule
