`timescale 1ns / 100ps

module testbench;
        // ------------------------------------------------------------------------------ 
        // Registers and wire
        reg    [16    -1:0]    in        ;
        wire   [16    -1:0]    out       ;     
        reg                    reset     ;
        reg                    clock     ;
        // ------------------------------------------------------------------------------ 
        // Create instance of adder_with_feedback module
        adder_with_feedback    dut    
        (    .    in(in)        ,
             .    out(out)      ,
             .    reset(reset)  ,
             .    clock(clock)  				  
        );
			
        // ------------------------------------------------------------------------------
        // Presets
        initial begin
            $dumpvars    ( 1, test )    ;
            clock        = 0            ;
            reset        = 1            ;
        end	
		  
endmodule