`timescale 1ns/100ps

module testbench                            ;
    // -------------------------------------------------------------------
    // Registers and wires
    reg                     clk             ;   
    reg                     rst             ;   
    reg    [32     -1:0]    data_in         ;   
    reg                     wr_en           ;   // Enable writing
    reg                     rd_en           ;   // Enable reading

    wire   [32     -1:0]    data_out        ; 

    wire                    empty           ;   
    wire                    full            ;   
    wire    [4     -1:0]    fifo_count      ;   
    wire    [3     -1:0]    wr_ptr          ;   
    wire    [3     -1:0]    rd_ptr          ; 

    wire    [8     -1:0]    fifo_ram_0      ;     
    wire    [8     -1:0]    fifo_ram_1      ;    
    wire    [8     -1:0]    fifo_ram_2      ;      
    wire    [8     -1:0]    fifo_ram_3      ;      
    wire    [8     -1:0]    fifo_ram_4      ;      
    wire    [8     -1:0]    fifo_ram_5      ;      
    wire    [8     -1:0]    fifo_ram_6      ;      
    wire    [8     -1:0]    fifo_ram_7      ;      

    // -------------------------------------------------------------------
    // Create a task to check the values 		  
    task display_the_values                                 ;
	 
        input       [4    -1:0]     statement_number        ; 
	 
        input                       clk_expected            ;
        input                       rst_expected            ;
        input      [32    -1:0]     data_in_expected        ;
        input                       wr_en_expected          ;
        input                       rd_en_expected          ;
        input      [32    -1:0]     data_out_expected       ;
        input                       empty_expected          ;
        input                       full_expected           ;
        input       [4    -1:0]     fifo_count_expected     ;
        input       [3    -1:0]     wr_ptr_expected         ;
        input       [3    -1:0]     rd_ptr_expected         ;

		  
        input                       clk_actual              ;
        input                       rst_actual              ;
        input      [32    -1:0]     data_in_actual          ;
        input                       wr_en_actual            ;
        input                       rd_en_actual            ;
        input      [32    -1:0]     data_out_actual         ;
        input                       empty_actual            ;
        input                       full_actual             ;
        input       [4    -1:0]     fifo_count_actual       ;
        input       [3    -1:0]     wr_ptr_actual           ;
        input       [3    -1:0]     rd_ptr_actual           ;

        
  
			
            if  (   clk_actual          !=   clk_expected           || 
                    rst_actual          !=   rst_expected           ||
                    data_in_actual      !=   data_in_expected       || 
                    wr_en_actual        !=   wr_en_expected         ||
                    rd_en_actual        !=   rd_en_expected         ||
                    data_out_actual     !=   data_out_expected      ||
                    empty_actual        !=   empty_expected         ||
                    full_actual         !=   full_expected          ||
                    fifo_count_actual   !=   fifo_count_expected    ||
                    wr_ptr_actual       !=   wr_ptr_expected        ||
                    rd_ptr_actual       !=   rd_ptr_expected    
                )  begin

                    $timeformat(-9, 0, " ", 7)                                                              ;
                    $display ()                                                                             ;
                    $display ("STATEMENT  %0d:            Time is: %t "                                 ,
                               statement_number, $time)					                                    ;
                    $display ()                                                                             ;
                    $display (" Result: ERROR - the values were wrong!")                                    ;
                    $display ()                                                                             ;
                    $display ("   Expected:     clk    = %0d      rst    = %0d     data_in  = %0d"      , 
                                clk_expected, rst_expected, data_in_expected)                               ; 
                    $display ("                 wr_en  = %0d      rd_en  = %0d     data_out = %0d"      ,
                                wr_en_expected, rd_en_expected, data_out_expected)                          ;
                    $display ("                 empty  = %0d      full   = %0d     fifo_count = %0d"    ,
                                empty_expected, full_expected, fifo_count_expected)                         ;
                    $display ("                 wr_ptr = %0d      rd_ptr = %0d"                         ,
                                wr_ptr_expected, rd_ptr_expected)                                           ;
                    $display ()                                                                             ;
                    $display ("   Actual:       clk    = %0d      rst    = %0d     data_in  = %0d"      , 
                                clk_actual, rst_actual, data_in_actual)                                     ; 
                    $display ("                 wr_en  = %0d      rd_en  = %0d     data_out = %0d"      ,
                                wr_en_actual, rd_en_actual, data_out_actual)                                ;
                    $display ("                 empty  = %0d      full   = %0d     fifo_count = %0d"    ,
                                empty_actual, full_actual, fifo_count_actual)                               ;
                    $display ("                 wr_ptr = %0d      rd_ptr = %0d"                         ,
                                wr_ptr_actual, rd_ptr_actual)                                               ;
                    $display ()                                                                             ;
                                                                                                
                end else begin

                    $timeformat(-9, 0, " ", 7)                                                              ;
                    $display ()                                                                             ;
                    $display ("STATEMENT  %0d:            Time is: %t "                                 ,
                               statement_number, $time)					                                    ;
                    $display ()                                                                             ;
                    $display (" Result: The values were correct!")                                          ;
                    $display ()                                                                             ;
                    $display ("   Expected:     clk    = %0d      rst    = %0d     data_in  = %0d"      , 
                                clk_expected, rst_expected, data_in_expected)                               ; 
                    $display ("                 wr_en  = %0d      rd_en  = %0d     data_out = %0d"      ,
                                wr_en_expected, rd_en_expected, data_out_expected)                          ;
                    $display ("                 empty  = %0d      full   = %0d     fifo_count = %0d"    ,
                                empty_expected, full_expected, fifo_count_expected)                         ;
                    $display ("                 wr_ptr = %0d      rd_ptr = %0d"                         ,
                                wr_ptr_expected, rd_ptr_expected)                                           ;
                    $display ()                                                                             ;
                    $display ("   Actual:       clk    = %0d      rst    = %0d     data_in  = %0d"      , 
                                clk_actual, rst_actual, data_in_actual)                                     ; 
                    $display ("                 wr_en  = %0d      rd_en  = %0d     data_out = %0d"      ,
                                wr_en_actual, rd_en_actual, data_out_actual)                                ;
                    $display ("                 empty  = %0d      full   = %0d     fifo_count = %0d"    ,
                                empty_actual, full_actual, fifo_count_actual)                               ;
                    $display ("                 wr_ptr = %0d      rd_ptr = %0d"                         ,
                                wr_ptr_actual, rd_ptr_actual)                                               ;
                    $display ()                                                                             ;
                end                                              
                
    endtask

    // -------------------------------------------------------------------
    // Create instance of valid_in_state_machine module
    fifo    dut 
    (   
            .clk            (clk)           ,	  
            .rst            (rst)           ,
            .data_in        (data_in)       ,
            .wr_en          (wr_en)         ,
            .rd_en          (rd_en)         ,

            .data_out       (data_out)      ,

            .empty          (empty)         ,
            .full           (full)          ,
            .fifo_count     (fifo_count)    ,
            .wr_ptr         (wr_ptr)        ,
            .rd_ptr         (rd_ptr)        ,

            .fifo_ram_0     (fifo_ram_0)    ,
            .fifo_ram_1     (fifo_ram_1)    ,
            .fifo_ram_2     (fifo_ram_2)    ,
            .fifo_ram_3     (fifo_ram_3)    ,
            .fifo_ram_4     (fifo_ram_4)    ,
            .fifo_ram_5     (fifo_ram_5)    ,
            .fifo_ram_6     (fifo_ram_6)    ,
            .fifo_ram_7     (fifo_ram_7)    
                  
    );

    // -------------------------------------------------------------------
    // Presets
    initial begin
        $dumpvars   ( 1,   testbench )                  ;

        clk             =           1                   ;   
        rst             =           0                   ;   
        data_in         =           1                   ;   
        wr_en           =           1                   ;   
        rd_en           =           0                   ;    

    end

    // -------------------------------------------------------------------
    // Set when to change the clock 
    always #50 clk = ~clk                               ;


    // -------------------------------------------------------------------
    // TESTS              TESTS              TESTS              TESTS         
    // -------------------------------------------------------------------

    always    @    ( clk or rst or data_in or wr_en or rd_en) begin

        #1 
            rd_en   =   1   ;    

        // ---------------------------------------------------------------
        #100 // At time 101 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                1, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                                1, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                                1, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                2, // ------------- Expected --- wr_ptr
                                1, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );
        end

        // ---------------------------------------------------------------
        #50 
            data_in   =  18   ;

        // ---------------------------------------------------------------
        #50 // At time 201 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                2, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                               18, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                                1, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                3, // ------------- Expected --- wr_ptr
                                2, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );
        end 

        // ---------------------------------------------------------------
        #50 
            data_in   =  93   ;

        // ---------------------------------------------------------------
        #50 // At time 301 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                3, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                               93, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                               18, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                4, // ------------- Expected --- wr_ptr
                                3, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );

        end 

        // ---------------------------------------------------------------
        #50 
            data_in   =  50   ;

        // ---------------------------------------------------------------
        #50 // At time 401 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                4, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                               50, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                               93, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                5, // ------------- Expected --- wr_ptr
                                4, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );

        end

        // ---------------------------------------------------------------
        #50 
            data_in   = 128   ;

        // ---------------------------------------------------------------
        #50 // At time 501 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                5, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                              128, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                               50, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                6, // ------------- Expected --- wr_ptr
                                5, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );

        end

        // ---------------------------------------------------------------
        #50 
            data_in   = 180   ;

        // ---------------------------------------------------------------
        #50 // At time 601 - right after  !!! posedge clk !!!                
        begin
            // Task
            display_the_values
                            ( 
                                6, // ------------- STATEMENT -- number

                                1, // ------------- Expected --- clk          
                                0, // ------------- Expected --- rst         
                              180, // ------------- Expected --- data_in    
                                1, // ------------- Expected --- wr_en      
                                1, // ------------- Expected --- rd_en
                              128, // ------------- Expected --- data_out       
                                0, // ------------- Expected --- empty        
                                0, // ------------- Expected --- full       
                                1, // ------------- Expected --- fifo_count
                                7, // ------------- Expected --- wr_ptr
                                6, // ------------- Expected --- rd_ptr
                                

                                clk, // ----------- Actual ----- clk         
                                rst, // ----------- Actual ----- rst         
                                data_in, // ------- Actual ----- data_in    
                                wr_en, // --------- Actual ----- wr_en      
                                rd_en, // --------- Actual ----- rd_en
                                data_out, // -------Actual ----- data_out        
                                empty, // --------- Actual ----- empty       
                                full, // ---------- Actual ----- full       
                                fifo_count, // ---- Actual ----- fifo_counter
                                wr_ptr, // -------- Actual ----- wr_ptr
                                rd_ptr // --------- Actual ----- rd_ptr  
                            );

        end 

        
		  
		#100 //At time 701
            $display()                                                                          ;
            $display()                                                                          ;
            $display (" fifo_ram_0    = %0d     fifo_ram_1    = %0d     fifo_ram_2  = %0d"  , 
                        fifo_ram_0,              fifo_ram_1,             fifo_ram_2)            ;
            $display (" fifo_ram_3    = %0d    fifo_ram_4    = %0d    fifo_ram_5  = %0d"  , 
                        fifo_ram_3,             fifo_ram_4,             fifo_ram_5)             ;
            $display (" fifo_ram_6    = %0d   fifo_ram_7    = %0d"                        , 
                        fifo_ram_6,             fifo_ram_7)                                     ;

		    $finish;

    end
    
		  
endmodule
