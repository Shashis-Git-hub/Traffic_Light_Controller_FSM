`timescale 1ns/1ps

// Testbench for Traffic Light Controller FSM
module Traffic_light_controller_tb;
    logic clk,reset,Ta,Tb;
    logic [1:0] La,Lb;

    // Instantiate the Design Under Test (DUT)
    Traffic_light_controller dut(
        .clk(clk),.reset(reset),.Ta(Ta),.Tb(Tb),
        .La(La),.Lb(Lb)
        );
    
    //clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    //input providing and checking the Fsm giving expected output or not.
    initial begin
       
        $monitor("Time = %0t | reset = %b Ta = %b Tb = %b | La =%b Lb =%b",
            $time,reset ,Ta,Tb,La,Lb);
        
        // Initialize inputs
        reset =1;Ta=1;Tb=1;

        #10 reset = 0;
        // reset is zer, reamaing cases for State Transition.
        #10 Ta = 0;     $display("Expected: S0 move to S1");

        #10;            $display("Expected: S1 move to S2");

        #10 Tb = 1;     $display("Expected: S2 remains in S2");

        #10 Tb = 0;     $display("Expected: S2 move to S3");

        #10 ;           $display("Expected: S3 moved to S0");

        #10; $finish;
    end
endmodule
