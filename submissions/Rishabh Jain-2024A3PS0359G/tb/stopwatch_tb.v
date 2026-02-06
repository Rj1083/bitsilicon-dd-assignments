`timescale 1ns / 1ps

module stopwatch_tb();

    // Inputs
    reg clk;
    reg rst_n;
    reg start;
    reg stop;
    reg reset;

    // Outputs
    wire [7:0] minutes;
    wire [5:0] seconds;
    wire [1:0] status;

    // Instantiate the Unit Under Test (UUT)
    stopwatch_top uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .start(start), 
        .stop(stop), 
        .reset(reset), 
        .minutes(minutes), 
        .seconds(seconds), 
        .status(status)
    );

    // Clock generation (10ns period -> 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst_n = 0;
        start = 0;
        stop = 0;
        reset = 0;

        // Release system reset
        #20 rst_n = 1;
        
        // 1. Test Reset Functionality
        #10 reset = 1;
        #10 reset = 0;
        #10;

        // 2. Start the stopwatch
        $display("Starting stopwatch simulation...");
        start = 1;
        #10 start = 0; // Single-cycle synchronous signal

        // 3. Wait for 60 "increments" 
        // In a real FPGA, you'd have a clock divider to make 1 sec.
        // Here, we monitor the 'seconds' output to see it roll over.
        wait(minutes == 8'd1);
        
        $display("Success: Rollover to 1 minute detected at time %t", $time);

        // 4. Test Pause
        #100 stop = 1;
        #10 stop = 0;
        $display("Stopwatch paused at %0d:%02d", minutes, seconds);
        
        #100; // Stay paused for a bit

        // 5. Resume
        start = 1;
        #10 start = 0;
        $display("Stopwatch resumed.");

        // Let it run a bit more and then finish
        #500;
        $display("Final Time: %0d:%02d", minutes, seconds);
        $finish;
    end

    // Monitor changes in the console
    initial begin
        $monitor("Time: %t | State: %b | Min: %0d | Sec: %0d", 
                 $time, status, minutes, seconds);
    end

endmodule
