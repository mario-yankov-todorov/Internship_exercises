`timescale 1ns/100ps

module testbench                            ;
    // -------------------------------------------------------------------
    // Registers and wire
    reg                     clk             ;   
    reg                     rst             ;   
    reg    [32     -1:0]    data_in         ;   
    reg                     wr_en           ;   // Enable writing
    reg                     rd_en           ;   // Enable reading

    wire                    empty           ;   
    wire                    full            ;   
    wire    [4    -1:0]     fifo_counter    ;   
    wire   [32     -1:0]    data_out        ;   

    // -------------------------------------------------------------------
    // Create a task to check the values 		  
    task display_the_values                                 ;
	 
        input       [4    -1:0]     statement_number        ; 
	 
        input                       clk_expected            ;
        input                       rst_expected            ;
        input      [32    -1:0]     data_in_expected        ;
        input                       wr_en_expected          ;
        input                       rd_en_expected          ;
        input                       empty_expected          ;
        input                       full_expected           ;
        input       [4    -1:0]     fifo_counter_expected   ;
        input      [32    -1:0]     data_out_expected       ;
		  
        input                       clk_actual              ;
        input                       rst_actual              ;
        input      [32    -1:0]     data_in_actual          ;
        input                       wr_en_actual            ;
        input                       rd_en_actual            ;
        input                       empty_actual            ;
        input                       full_actual             ;
        input       [4    -1:0]     fifo_counter_actual     ;
        input      [32    -1:0]     data_out_actual         ;
		   
			
            if  (   clk_actual          !=   clk_expected           || 
                    rst_actual          !=   rst_expected           ||
                    data_in_actual      !=   data_in_expected       || 
                    wr_en_actual        !=   wr_en_expected         ||
                    rd_en_actual        !=   rd_en_expected         ||
                    empty_actual        !=   empty_expected         ||
                    full_actual         !=   full_expected          ||
                    fifo_counter_actual !=   fifo_counter_expected  ||
                    data_out_actual     !=   data_out_expected         )
                                                                begin
                    $display ()                                                                             ;
                    $display ("STATEMENT  %0d:            Time is:"                                     ,
                               statement_number)					                                        ;
                    $display ("             ", $time)                                                       ;
                    $display (" Result: ERROR - the values were wrong!")                                    ;
                    $display ()                                                                             ;
                    $display ("   Expected:     clk   = %0d      rst          = %0d     data_in  = %0d" , 
                                clk_expected, rst_expected, data_in_expected)                               ; 
                    $display ("                 wr_en = %0d      rd_en        = %0d     empty    = %0d" ,
                                wr_en_expected, rd_en_expected, empty_expected)                             ;
                    $display ("                 full  = %0d      fifo_counter = %0d     data_out = %0d" ,
                                full_expected, fifo_counter_expected, data_out_expected)                    ;
                    $display ()                                                                             ;
                    $display ("   Actual:       clk   = %0d      rst          = %0d     data_in  = %0d" , 
                                clk_actual, rst_actual, data_in_actual)                                     ; 
                    $display ("                 wr_en = %0d      rd_en        = %0d     empty    = %0d" ,
                                wr_en_actual, rd_en_actual, empty_actual)                                   ;
                    $display ("                 full  = %0d      fifo_counter = %0d     data_out = %0d" ,
                                full_actual, fifo_counter_actual, data_out_actual)                          ;
                    $display ()                                                                             ;
						
                    end 
					  
            else    begin
                    $display ()                                                                             ;
                    $display ("STATEMENT  %0d:            Time is:"                                     ,
                               statement_number)					                                        ;
                    $display ("             ", $time)                                                       ;		
                    $display (" Result: The values were correct!")                                          ;
                    $display ()                                                                             ;
                    $display ("   Expected:     clk   = %0d      rst          = %0d     data_in  = %0d" , 
                                clk_expected, rst_expected, data_in_expected)                               ; 
                    $display ("                 wr_en = %0d      rd_en        = %0d     empty    = %0d" ,
                                wr_en_expected, rd_en_expected, empty_expected)                             ;
                    $display ("                 full  = %0d      fifo_counter = %0d     data_out = %0d" ,
                                full_expected, fifo_counter_expected, data_out_expected)                    ;
                    $display ()                                                                             ;
                    $display ("   Actual:       clk   = %0d      rst          = %0d     data_in  = %0d" , 
                                clk_actual, rst_actual, data_in_actual)                                     ; 
                    $display ("                 wr_en = %0d      rd_en        = %0d     empty    = %0d" ,
                                wr_en_actual, rd_en_actual, empty_actual)                                   ;
                    $display ("                 full  = %0d      fifo_counter = %0d     data_out = %0d" ,
                                full_actual, fifo_counter_actual, data_out_actual)                          ;
                    $display ()                                                                             ;
						
                    end
				  
    endtask

    // -------------------------------------------------------------------
    // Create instance of fifo module
    fifo    dut 
    (   
            .clk            (clk)  		  	  ,	  
            .rst            (rst)           ,
            .data_in        (data_in)       ,
            .wr_en          (wr_en)         ,
            .rd_en          (rd_en)         ,
            .empty          (empty)         ,
            .full           (full)          ,
            .fifo_counter   (fifo_counter)  ,
            .data_out       (data_out)      
    );

    // -------------------------------------------------------------------
    // Presets
    initial begin
        $dumpvars   ( 1,   testbench )      ;

        clk         =           1                     ;   
        rst         =           0                     ;   
        data_in     =           0                     ;   
        wr_en       =           1                     ;   
        rd_en       =           1                     ;   
   
        
    end

    // -------------------------------------------------------------------
    // Set when to change the clock 
    always #50 clk = ~clk                   ;


    // -------------------------------------------------------------------
    // TESTS              TESTS              TESTS              TESTS         
    // -------------------------------------------------------------------

    always    @    ( clk or rst or data_in ) begin

        // ---------------------------------------------------------------
        #101 // At time 101 - right after  !!! posedge clk !!!                
        begin
            // Expected values:     
            //  clk   =  1       rst        =  0       data_in  =  0 
            //  wr_en =  1       rd_en        =  1       empty    =  0
            //  full  =  0       fifo_counter =  0       data_out =  0
            display_the_values( 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, clk, rst, 
                                data_in, wr_en, rd_en, empty, full,
                                fifo_counter, data_out );
        end 
		  
		  #100
		  $finish;

    end
    
		  
endmodule
