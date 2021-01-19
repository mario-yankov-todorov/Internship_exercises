`timescale 1ns/100ps

module fifo
    (
        // ----------------------------------------------------------------
        // INPUTS
        input                               clk                 ,
        input                               rst                 , 
        input          [32      -1:0]       data_in             ,
        // Input to enable writing
        input                               wr_en               ,
        // Input to enable reading
        input                               rd_en               ,   

        // OUTPUTS
        // Output for reading data from memory
        output reg     [32      -1:0]       data_out            ,
        
        // Output to indicate if the memory is empty
        output                              empty               ,
        // Output to indicate if the memory is full
        output                              full                ,
        // Output for test fifo_counter register                  
        output          [4      -1:0]       fifo_count          ,
        // Output for test wr_pointer register
        output          [3      -1:0]       wr_ptr              ,
        // Output for test rd_pointer register
        output          [3      -1:0]       rd_ptr              ,

        // Output for test fifo_ram[0]
        output          [8      -1:0]       fifo_ram_0          ,
        // Output for test fifo_ram[1]
        output          [8      -1:0]       fifo_ram_1          ,
        // Output for test fifo_ram[2]
        output          [8      -1:0]       fifo_ram_2          ,
        // Output for test fifo_ram[3]
        output          [8      -1:0]       fifo_ram_3          ,
        // Output for test fifo_ram[4]
        output          [8      -1:0]       fifo_ram_4          ,
        // Output for test fifo_ram[5]
        output          [8      -1:0]       fifo_ram_5          ,
        // Output for test fifo_ram[6]
        output          [8      -1:0]       fifo_ram_6          ,
        // Output for test fifo_ram[7]
        output          [8      -1:0]       fifo_ram_7          
            		  		  
    );

        // ----------------------------------------------------------------
        // REGS
        // Register for tracking the number of words in memory                  
        reg             [4      -1:0]       fifo_counter    =   4'b 0000   ;
        // Pointer to indicate where the next word should be written
        reg             [3      -1:0]       wr_pointer      =   3'b 000   ;
        // Pointer - from which cell the next word should be read
        reg             [3      -1:0]       rd_pointer      =   3'b 000   ;
        // Register for store eight 32 bits words
        reg            [32      -1:0]       fifo_ram            [0:7]   ;
        

        // ----------------------------------------------------------------
        // Assigments 
        assign  empty           =   (fifo_counter   ==  0)                  ;
        assign  full            =   (fifo_counter   ==  8)                  ;
        assign  fifo_count      =   fifo_counter                            ;
        assign  wr_ptr          =   wr_pointer                              ;
        assign  rd_ptr          =   rd_pointer                              ;

        // ----------------------------------------------------------------
        // Memory tracking
        assign  fifo_ram_0          =   fifo_ram[0]                         ;
        assign  fifo_ram_1          =   fifo_ram[1]                         ;
        assign  fifo_ram_2          =   fifo_ram[2]                         ;
        assign  fifo_ram_3          =   fifo_ram[3]                         ;
        assign  fifo_ram_4          =   fifo_ram[4]                         ;
        assign  fifo_ram_5          =   fifo_ram[5]                         ;
        assign  fifo_ram_6          =   fifo_ram[6]                         ;
        assign  fifo_ram_7          =   fifo_ram[7]                         ;


    // --------------------------------------------------------------------
    // PROCEDURAL BLOCKS        PROCEDURAL BLOCKS        PROCEDURAL BLOCKS
    // --------------------------------------------------------------------


    // --------------------------------------------------------------------
    // WRITE BLOCK
    always  @   (posedge clk)   begin:  write
        // If write is enabled and full is not true
        if      (wr_en == 1  &&  full != 1)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  data_in                         ;
        // If write is enabled and in the same time read is enabled
        else if (wr_en == 1  &&  rd_en == 1)
            // save input data in memory at the indicated position
            fifo_ram [wr_pointer]   <=  data_in                         ;
    end 

    // --------------------------------------------------------------------
    // READ BLOCK
    always  @   (posedge clk )   begin:  read
        // If read is enabled and empty is not true
        if      (rd_en == 1  &&  empty != 1)
            // get the output from the indicated position in the memory
            data_out    <=  fifo_ram [rd_pointer]                       ;
        // If write is enabled and in the same time read is enabled
        else if (wr_en == 1  &&  rd_en == 1)
            // get the output from the indicated position in the memory
            data_out    <=  fifo_ram [rd_pointer]                       ;
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
            if ( (wr_en == 1  &&  full  == 0)  ||  (wr_en == 1  &&  rd_en  == 1) ) 
                // increase write counter (pointer)
                wr_pointer  <=  wr_pointer + 1                          ;
            else
                // Otherwise let the counter value remain the same
                wr_pointer  <=  wr_pointer                              ;
            // If read is enabled and empty is not true
            // or both write and read are enabled
            if ( (rd_en == 1  &&  empty == 0)  ||  (wr_en == 1  &&  rd_en  == 1) ) 
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