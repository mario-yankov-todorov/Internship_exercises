`timescale 1ns / 100ps

module testbench                         ;

        // ----------------------------------------------------------------
        // Registers and wire
        reg    [16    -1:0]    in        ;
        wire   [16    -1:0]    out       ;     
        reg                    reset     ;
        reg                    clk       ;
		  
        // ----------------------------------------------------------------
        // Create instance of adder_with_feedback module
        adder_with_feedback    dut    
        (        .in       (in)          ,
                 .out      (out)         ,
                 .reset    (reset)       ,
                 .clk      (clk)  				  
        );
			
        // ----------------------------------------------------------------
        // Presets
        initial begin
            $dumpvars    ( 1, testbench )    ;
				
            clk          = 0                 ;
            reset        = 0                 ;
             
        end
		  
        // ----------------------------------------------------------------
        // Set when to change the clock 
        always #50 clk = ~clk; // Thе clock will change at any time
                               // multiple of 50 (that is, a time
                               // which can be divided by 50,
                               // with no remainder).
                               // In this case the clock is initially
                               // equal to 0 and it will change to 1,
                               // at time 50. That means that at
                               // any time multiple of 100 the clock
                               // will be equal back to 0. And after 
                               // 50 simulation time units (#50), it
                               // will be equal back to 1).

  // And this way, according to adder_with_feedback.v file, we save the
// current sum from adder to the register, at the moment when the clock 
// becomes equal to 1 (If reset = 0). Of course, if reset = 1, in that
// moment (when clock becomes equal to 1), the register becomes equal to 0.
 
 
        // ----------------------------------------------------------------
        //  TESTS              TESTS              TESTS              TESTS         
        // ----------------------------------------------------------------
		  
		  always    @    ( in or out or clk )    begin
		  
         //    #0   !!!  clk = 0  !!!
	
         #49
          in       =    16'd    18    ; //    #49  clk =   0    reset =   0
                                        //         in  =  18    out   =   0
													 													 
         //   #50   !!!  clk = 1  !!!  Save changes  !!!  reg_1 =  18  !!!
			
         #51
          in       =    16'd     9    ; //    #51  clk =   1    reset =   0
                                        //         in  =   9    out   =  18

              if ( clk != 1 || reset != 0 || in != 9 || out != 18) begin
				  
                  $display ()                                        ;
                  $display ("1. ERROR: the values were wrong!")      ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                             1,  0)                                  ;
                  $display ("             in  = %0d  out   = %0d" ,
                             9, 18)                                  ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk, reset)                              ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in, out)                                 ;
                  $display ()                                        ;
						
              end 
              else begin
				  
                  $display ()                                        ;
                  $display ("1. The output was correct!")            ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                             1,  0)                                  ;
                  $display ("             in  = %0d  out   = %0d" ,
                             9, 18)                                  ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk, reset)                              ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in, out)                                 ;
                  $display ()                                        ;
						
              end
													 
         //  #100   !!!  clk = 0  !!!
													
         #149	
          in       =    16'd     4    ; //   #149  clk =   0    reset =   0
                                        //         in  =   4    out   =  18

         //  #150   !!!  clk = 1  !!!  Save changes  !!!  reg_1 =  22  !!!
			
         #151
          reset    =    1             ; //   #151  clk =   1    reset =   1
                                        //         in  =   4    out   =   0
													 
         //  #250   !!!  clk = 1  !!!  Save changes  !!!  reg_1 =   0  !!!
													 
         #251 
                                        //   #251  clk =   1    reset =   1
                                        //         in  =   4    out   =   0
			
              if ( clk != 1 || reset != 1 || in != 4 || out != 0) begin
				  
                  $display ()                                        ;
                  $display ("2. ERROR: the values were wrong!")      ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                             1,  1)                                  ;
                  $display ("             in  = %0d  out   = %0d" ,
                             4,  0)                                  ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk, reset)                              ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in, out)                                 ;
                  $display ()                                        ;
						
              end 
              else begin
				  
                  $display ()                                        ;
                  $display ("2. The output was correct!")            ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                             1,  1)                                  ;
                  $display ("             in  = %0d  out   = %0d" ,
                             4,  0)                                  ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk, reset)                              ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in, out)                                 ;
                  $display ()                                        ;
						
              end
				  
          $finish                                                    ;
			 
         end
		  
endmodule
