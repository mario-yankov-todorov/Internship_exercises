module button_counter
    (
        // ----------------------------------------------------------------
        // Inputs and output
        input                           clk             ,   // Clock
        input                           rst             ,   // Reset  		  
        input                           btn             ,   // Button

        output      [8      -1:0]       button_counter      // Counter 
                                                            // output   
    );


                                
    // --------------------------------------------------------------------
    // Registers
    reg         [2      -1:0]       state                                 ;
    reg         [8      -1:0]       counter_output     =  8'b 00000000    ;

    // --------------------------------------------------------------------
    // Assigment 
    assign  button_counter       =   counter_output                       ;


    // --------------------------------------------------------------------
    // Parameters for different states
    parameter   state_0     =   2'b     00      ;
    parameter   state_1     =   2'b     01      ;
    parameter   state_2     =   2'b     10      ;

      		  
    // --------------------------------------------------------------------
    // Procedural block         Procedural block         Procedural block 
    // --------------------------------------------------------------------

        always  @   (posedge clk)

            if (rst == 1) begin
                state               =   state_0            ;
                counter_output      =         0            ;    
            end
            else
                case (state)

                    state_0:
                        // If the button is pressed
                        if (btn  ==  1) begin
                            // go to state 1 and increase counter by one
                            state           =  state_1              ;
                            counter_output  =  counter_output + 1   ;
                        end else begin 
                            // Otherwise let the state remain the same                           
                            state    =  state_0         ;

                        end                  
                    state_1: begin
                            // On the next positive edge of the clock 
                            // go directly to state 2
                            state    =  state_2         ;
                    end
                    state_2:
                        // If the button is pressed
                        if (btn == 1)  begin
                            // let the state remain the same
                            state    =  state_2         ;
                        end  else  begin
                            // Otherwise go to state 0
                            state    =  state_0         ;
                        end
                endcase


endmodule