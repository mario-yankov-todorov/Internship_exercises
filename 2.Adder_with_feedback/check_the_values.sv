module   check_the_values()                             ;
      
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
                             print_number)                           ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                            clk_expected, reset_expected)            ;                      ;
                  $display ("             in  = %0d  out   = %0d" ,
                            in_expected, out_expected)               ;                   ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk_actual, reset_actual)                ;             ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in_actual, out_actual)                   ;               ;
                  $display ()                                        ;
						
                 end 
					  
            else begin
				  
                  $display ()                                        ;
                  $display ("%0d. The values were correct!"       ,
                             print_number)                           ;
                  $display ()                                        ;
                  $display ("   Expected: clk = %0d  reset = %0d" ,
                            clk_expected,  reset_expected)           ;                                 ;
                  $display ("             in  = %0d  out   = %0d" ,
                            in_expected,  out_expected)              ;                                 ;
                  $display ()                                        ;
                  $display ("   Actual:   clk = %0d, reset = %0d" , 
                            clk_actual, reset_actual)                ;                          ;
                  $display ("             in  = %0d, out   = %0d" ,
                            in_actual, out_actual)                   ;                               ;
                  $display ()                                        ;
						
                 end
				  
    endtask
		  
endmodule