module adder_with_feedback
     (
        // ------------------------------------------------------------------------------ 
        // Inputs and output 
        input    [16    -1:0]    in        ,
        output   [16    -1:0]    out       ,
        input                    reset     , 
        input                    clock   
     );
        // ------------------------------------------------------------------------------
        // Wire and register
        wire     [16    -1:0]    sum       ;
		  reg      [16    -1:0]    register  ;
        // Assignments
        assign   out    = register         ;
        assign   sum    = in + register    ;
        
		  // ------------------------------------------------------------------------------
        // Procedural block
        always   @    (posedge clock)
            begin
                if  (reset      == 1)
                    register    <= 0       ;
                else
                    register    <= sum     ;
            end
		  
endmodule