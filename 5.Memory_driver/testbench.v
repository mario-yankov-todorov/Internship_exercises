`timescale 1ns/100ps

module testbench                                ;
    // -------------------------------------------------------------------
    // Registers and wires
    reg                     clk                 ;   
    reg                     rst                 ; 
    reg                     button              ;

    reg                     wr_en               ;   // Enable writing
    reg                     rd_en               ;   // Enable reading

    wire   [32     -1:0]    concatenated_out    ; 

    wire                    empty               ;   
    wire                    full                ;    


    // -------------------------------------------------------------------
    // Create instance of button_counter_state_machine module
    button_counter    dut_1
    (   
            .clk                (clk)               ,	  
            .rst                (rst)               ,
            .btn                (button)        
    );
	  
    // -------------------------------------------------------------------
    // Create instance of memory_driver module
    memory_driver    dut_2 
    (   
            .wr_en              (wr_en)             ,
            .rd_en              (rd_en)             ,

            .concatenated_out   (concatenated_out)  ,

            .empty              (empty)             ,
            .full               (full)                           
    );

    // -------------------------------------------------------------------
    // Presets
    initial begin
        $dumpvars   ( 1,   testbench )                  ;

        clk             =           1                   ;   
        rst             =           0                   ;     
        wr_en           =           1                   ;   
        rd_en           =           0                   ;
        button          =           0                   ;    

    end

    // -------------------------------------------------------------------
    // Set when to change the clock 
    always  #5 clk = ~clk                               ;


    // -------------------------------------------------------------------
    // TESTS              TESTS              TESTS              TESTS         
    // -------------------------------------------------------------------

    always    @    ( clk or rst or button or wr_en or rd_en) begin

        #15 //At time 15
            button  =   1   ;
                                // Time 20 - first signal to the counter
        #20 //At time 35
            button  =   0   ;


        #10 //At time 45
            button  =   1   ;
                                // Time 50 - second signal to the counter
        #20 //At time 65
            button  =   0   ;


        #10 //At time 75
            button  =   1   ;
                                // Time 80 - third signal to the counter
        #20 //At time 95
            button  =   0   ;


        #10 //At time 105
            button  =   1   ;
                                // Time 110 - fourth signal to the counter
        #20 //At time 125
            button  =   0   ;

            $display();
            $display(concatenated_out);
        
		  
		#100 //At time 
                                                                      
		    $finish;

    end


endmodule
