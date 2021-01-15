module valid_in_state_machine
    (
        // ----------------------------------------------------------------
        // Inputs and output 
        input                       clk             ,   // Clock
        input                       rst             ,   // Reset  		  
        input                       btn             ,   // Button

        output reg                  out             ,   // Output for
                                                        // the signal 
        output      [2    -1:0]     state_test          // Output for
                                                        // testing the 
                                                        // state register   
    );	 
                                
    // --------------------------------------------------------------------
    // Register and assigment
    reg         [2    -1:0]         state           ;
    assign      state_test    =     state           ;

    // --------------------------------------------------------------------
    // Parameters for different states
    parameter   state_0     =   2'b     00      ;
    parameter   state_1     =   2'b     01      ;
    parameter   state_2     =   2'b     10      ;

      		  
    // --------------------------------------------------------------------
    // Procedural blocks        Procedural blocks        Procedural blocks 
    // --------------------------------------------------------------------

        always  @   (posedge clk)

            if (rst == 1) begin
                // If reset is true, there is no signal
                state           =    state_0            ;
                out             =          0            ;    
            end
            else
                case (state)

                    state_0:
                        // If the button is pressed
                        if (btn  ==  1) begin
                            // go to state 1, in which a signal is given
                            state    =  state_1         ;
                            out      =        1         ;
                        end else begin 
                            // Otherwise let the state remain the same
                            
                            state    =  state_0         ;
                            out      =        0         ;
                        end                  
                    state_1: begin
                            // On the next positive edge of the clock 
                            // go directly to state 2, in which there
                            // is no signal
                            state    =  state_2         ;
                            out      =        0         ;
                    end
                    state_2:
                        // If the button is pressed
                        if (btn == 1)  begin
                            // let the state remain the same
                            // (there is no signal)
                            state    =  state_2         ;
                            out      =        0         ;
                        end  else  begin
                            // Otherwise go to state 0, in which
                            // there is also no signal
                            state    =  state_0         ;
                            out      =        0         ;
                        end
                endcase


endmodule