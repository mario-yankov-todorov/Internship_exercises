module adder_with_feedback
     (
        // ------------------------------------------------------------------------------ 
        // Inputs and output 
        input    [16    -1:0]    in        ,
        output   [16    -1:0]    out       ,
        input                    reset     , 
        input                    clk   
     );
        // ------------------------------------------------------------------------------
        // Wire and register
        wire     [16    -1:0]    sum       ;
        reg      [16    -1:0]    reg_1     ;
        // Assignments
        assign   out    = reg_1            ;
        assign   sum    = in + out         ;

        // ------------------------------------------------------------------------------
        // Procedural block
        always   @    (posedge clk)
            begin
                if  (reset   == 1)
                    reg_1    <= 0       ;
                else
                    reg_1    <= sum     ;
            end
		  
endmodule