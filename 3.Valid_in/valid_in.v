module valid_in_state_machine
    (
        // ----------------------------------------------------------------
        // Inputs and output 
        input                       button          ,
        input                       reset           , 
        input                       clk             ,
		  
        output                      q                
		  		  
    );	 
                                
        // ----------------------------------------------------------------
        // Registers
        reg                         q               ;
        reg         [2    -1:0]     state           ;
		  
        // ----------------------------------------------------------------
        // Parameters for different states
        parameter   state_0     =   2'b     00      ;
        parameter   state_1     =   2'b     01      ;
        parameter   state_2     =   2'b     10      ;

      		  
    // --------------------------------------------------------------------
    // Procedural blocks        Procedural blocks        Procedural blocks         
    // --------------------------------------------------------------------

        always  @   (posedge clk)

            if (reset == 1)

                state <= state_0                        ;
            else
                case (state)

                    state_0:
                        if (button  ==  1) 

                            state   <=  state_1         ;
                        else 
                            state   <=  state_0         ;
                                      
                    state_1:
                            state   <=  state_2         ;

                    state_2:
                        if (button == 1)

                            state   <=  state_2         ;
                        else
                            state   <=  state_0        ;

                endcase

            if (state == state_1)
                q   =   1'b     1           ;
                                
            else
                q   =   1'b     0           ;

endmodule
