`timescale 1ns / 1ps

module counting_tb;

  
    reg timer;
    reg reset;
    reg enable;
    wire [5:0] minutes;
    wire [5:0] seconds;
    reg clk;
   

    counting uut (
        .timer(clk),
        .reset(reset),
        .enable(enable),
        .minutes(minutes),
        .seconds(seconds)
    );

    // Clock generation
 
   


    // Test stimulus
    initial begin
       
       reset = 0;
       enable = 1;
       clk = 0;
       timer = 0;
       #100;
        // Reset signals
      



   
    end
    
   always #(1) clk = ~clk;


endmodule
