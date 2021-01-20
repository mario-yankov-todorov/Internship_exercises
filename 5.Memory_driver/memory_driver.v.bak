module memory_driver
    (
        // ----------------------------------------------------------------
        // INPUTS
        input                               clk                 ,
        input                               rst                 , 
        input          [32      -1:0]       concatenated        ,
        // Input to enable writing
        input                               wr_en               ,
        // Input to enable reading
        input                               rd_en               ,   

        // OUTPUTS
        // Output for reading data from memory
        output reg     [32      -1:0]       concatenated_out    ,
        
        // Output to indicate if the memory is empty
        output                              empty               ,
        // Output to indicate if the memory is full
        output                              full                           		  		  
    );

        // ----------------------------------------------------------------
        // REGS
        // Register for tracking the number of words in memory                  
        reg             [4      -1:0]       fifo_counter    = 7'b 0000000 ;
        // Pointer to indicate where the next word should be written
        reg             [6      -1:0]       wr_pointer      = 6'b 000000  ;
        // Pointer - from which cell the next word should be read
        reg             [6      -1:0]       rd_pointer      = 6'b 000000  ;
        // Register for store eight 32 bits words
        reg            [32      -1:0]       fifo_ram    [0:63]            ;
        

        // ----------------------------------------------------------------
        // Assigments 
        assign  empty           =   (fifo_counter   ==   0)               ;
        assign  full            =   (fifo_counter   ==  64)               ;


    // --------------------------------------------------------------------
    // PROCEDURAL BLOCKS        PROCEDURAL BLOCKS        PROCEDURAL BLOCKS
    // --------------------------------------------------------------------


    // --------------------------------------------------------------------
    // WRITE BLOCK
    always  @   (posedge clk)   begin:  write
        // If write is enabled and full is not true
        if      (wr_en == 1  &&  full != 1)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  concatenated                    ;
        // If write is enabled and in the same time read is enabled
        else if (wr_en == 1  &&  rd_en == 1)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  concatenated                    ;
    end 

    // --------------------------------------------------------------------
    // READ BLOCK
    always  @   (posedge clk )   begin:  read
        // If read is enabled and empty is not true
        if      (rd_en == 1  &&  empty != 1)
            // get the output from the indicated position in the memory
            concatenated_out    <=  fifo_ram [rd_pointer]               ;
        // If write is enabled and in the same time read is enabled
        else if (wr_en == 1  &&  rd_en == 1)
            // get the output from the indicated position in the memory
            concatenated_out    <=  fifo_ram [rd_pointer]               ;
    end

    // --------------------------------------------------------------------
    // POINTER BLOCK                    
    always  @   (posedge clk) begin: pointer
        if (rst == 1) begin // If reset is enabled
            wr_pointer  <=  0; // reset write counter (pointer)
            rd_pointer  <=  0; // and reset read counter (pointer)
        end
        else  begin
            // If write is enabled and full is not true
            // or both write and read are enabled
            if ( 
                    (wr_en == 1  &&  full  == 0)  ||  
                    (wr_en == 1  &&  rd_en == 1) 
                ) 
                // increase write counter (pointer)
                wr_pointer  <=  wr_pointer + 1                          ;
            else
                // Otherwise let the counter value remain the same
                wr_pointer  <=  wr_pointer                              ;
            // If read is enabled and empty is not true
            // or both write and read are enabled
            if ( 
                    (rd_en == 1  &&  empty == 0)  ||  
                    (wr_en == 1  &&  rd_en  == 1) 
                ) 
                // increase write counter (pointer)
                rd_pointer  <=  rd_pointer + 1                          ;
            else  
                // Otherwise let the counter value remain the same
                rd_pointer  <=  rd_pointer                              ;
        end
    end

    // --------------------------------------------------------------------
    // COUNTER BLOCK
    always  @   (posedge clk) begin: count
        if (rst == 1)  fifo_counter <= 0; 
        else begin 
            // Concatenate write and read pointer (counter)
            case ({wr_en,rd_en})

                // Case 1: If write is not enabled and read is not enabled
                // the value of memory tarcking counter remain the same
                // (because nothing happens)
                2'b     00  :   fifo_counter    <=    fifo_counter ;    
                  
                // Case 2: If write is not enabled and read is enabled
                                // If there is nothing in memory (empty)
                2'b     01  :   if (fifo_counter  ==  0)
                                // let the counter value remain the zero
                                fifo_counter    <=    0                    ;
                                else
                                // If there is a word(s) in memory
                                // reduce the counter by one                              
                                fifo_counter    <=    fifo_counter  -  1   ;
                            

                // Case 3: If write is enabled and read is not enabled
                                // If counter is equal to eight (is full)                                
                2'b     10  :   if (fifo_counter  ==  8)
                                // let the counter value remain the same
                                fifo_counter    <=    8                    ;
                                else
                                // If memory tracking counter is not full
                                // increase its value by one unit                            
                                fifo_counter    <=    fifo_counter  +  1   ;

                // Case 4: If write is enabled and read is also enabled
                // the value of memory tarcking counter remain the same
                // (because one word enters and at the same time another
                // word leaves the FIFO memory)
                2'b     11  :   fifo_counter    <=    fifo_counter         ;
            endcase
        end                            
    end 

endmodule