`timescale 1ns / 1ps

module counting_tb;

  
    reg timer;

    wire [5:0] minutes;
    wire [5:0] seconds;
    reg clk;
    reg [6:0] seg;
    reg [3:0] an;
   

    counting uut (
        .timer(timer),
//        .reset(reset),
//        .enable(enable),
        .minutes(minutes),
        .seconds(seconds)
    );
    
    sevsegdisplay display (
        .min(minutes),
        .sec(seconds),
        .clk(timer)
        
        
    );

    // Clock generation
 
   
    always #5 timer = ~timer;

    // Test stimulus
    initial begin
       an = 0;
       seg = 0;
       clk = 0;
       timer = 0;
       #100;
        // Reset signals
      



   
    end
    


endmodule
