module FIFO 
    (
        // ----------------------------------------------------------------
        // INPUTS
        input          [32      -1:0]       data_in             ,
        input                               reset               , 
        input                               clk                 ,
            // Input to enable writing
        input                               wr                  ,
            // Input to enable reading
        input                               rd                  ,

        // OUTPUTS
            // Output to indicate if the memory is empty
        output                              empty               ,
            // Output to indicate if the memory is full
        output                              full                ,
            // Output for tracking the number of words in memory                  
        output reg      [4      -1:0]       fifo_counter        ,
        output reg     [32      -1:0]       data_out            
        		  		  
    );

        // ----------------------------------------------------------------
        // REGS
            // Register for store seven 32 bits words
        reg            [32      -1:0]       fifo_ram        [0:7]   ;
            // Pointer to indicate where the next word should be written
        reg             [3      -1:0]       wr_pointer              ;
            // Pointer - from which cell the next word should be read
        reg             [3      -1:0]       rd_pointer              ;

        // ----------------------------------------------------------------
        // Assigments
        assign  empty   =   (fifo_counter   ==  0)                  ;
        assign  full    =   (fifo_counter   ==  8)                  ;


    // --------------------------------------------------------------------
    // Procedural blocks        Procedural blocks        Procedural blocks 
    // --------------------------------------------------------------------

	 
	 
	 

endmodule