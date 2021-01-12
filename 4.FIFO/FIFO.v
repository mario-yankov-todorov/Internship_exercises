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
        // Output for reading data from memory
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
    // PROCEDURAL BLOCKS        PROCEDURAL BLOCKS        PROCEDURAL BLOCKS
    // --------------------------------------------------------------------


    // --------------------------------------------------------------------
    // WRITE BLOCK
    always  @   (posedge clk)   begin:  write
        // If write is enabled and full is not true
        if      (wr == 1  &&  full == 0)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  data_in                         ;
        // If write is enabled and in the same time read is enabled
        else if (wr == 1  &&  rd == 0)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  data_in                         ;
    end 

    // --------------------------------------------------------------------
    // READ BLOCK
    always  @   (posedge clk)   begin:  read
        // If read is enabled and empty is not true
        if      (rd == 1  &&  empty == 0)
            // get the output from the indicated position in the memory
            data_out    <=  fifo_ram [rd_pointer]                       ;
        // If write is enabled and in the same time read is enabled
        else if (wr == 1  &&  rd == 1)
            // get the output from the indicated position in the memory
            data_out    <=  fifo_ram [rd_pointer]                       ;
    end

    // --------------------------------------------------------------------
    // POINTER BLOCK                    
    always  @   (posedge clk) begin: pointer
        if (reset == 1) begin // If reset is enabled
            wr_pointer  <=  0; // reset write counter (pointer)
            rd_pointer  <=  0; // and reset read counter (pointer)
        end
        else  begin
            // If write is enabled and full is not true
            // or both write and read are enabled
            if ( (wr == 1  &&  full  == 0)  ||  (wr == 1  &&  rd  == 1) ) 
                // increase write counter (pointer)
                wr_pointer  <=  wr_pointer + 1                          ;
            else
                // Otherwise let the counter value remain the same
                wr_pointer  <=  wr_pointer                              ;
            // If read is enabled and empty is not true
            // or both write and read are enabled
            if ( (rd == 1  &&  empty == 0)  ||  (wr == 1  &&  rd  == 1) ) 
                // increase write counter (pointer)
                wr_pointer  <=  wr_pointer + 1                          ;
            else  
                // Otherwise let the counter value remain the same
                wr_pointer  <=  wr_pointer                              ;
        end
    end

    // --------------------------------------------------------------------
    // COUNTER BLOCK
    always  @   (posedge clk) begin: count
        if (reset == 1) fifo_counter <= 0;
        else begin
            // Concatenate write and read pointer (counter)
            case ((wr_pointer,rd_pointer))
                // If write is not enabled and read is not enabled
                // the value of memory tarcking counter remains the same
                // (because nothing happens)
                2'b     00  :   fifo_counter    <=    fifo_counter         ;                
                // If write is not enabled and read is enabled
                                // If there is nothing in memory
                2'b     01  :   if (fifo_counter  ==  0)
                                // let the counter value remains the zero
                                fifo_counter    <=    0                    ;
                                else
                                // If there is a word(s) in memory
                                // reduce the counter by one                              
                                fifo_counter    <=    fifo_counter  -  1   ;

                // If write is enabled and read is not enabled
                                // If counter is equal to eight (is full)                                
                2'b     10  :   if (fifo_counter  ==  8)
                                // let the counter value remains the same
                                fifo_counter    <=    8                    ;
                                else
                                // If memory tracking counter is not full
                                // increase its value by one unit                            
                                fifo_counter    <=    fifo_counter  +  1   ;
                // If write is enabled and read is also enabled
                // the value of memory tarcking counter remains the same
                // (because one word enters and at the same time another
                //  word leaves the FIFO memory)
                2'b     11  :   fifo_counter    <=    fifo_counter         ;
        end      
    end 

endmodule