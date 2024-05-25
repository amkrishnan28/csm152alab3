`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 02:27:51 PM
// Design Name: 
// Module Name: clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk(
 input clk_100MHz,  // 100 MHz master clock input
   
   output reg clk_2Hz,    // 2 Hz clock output
   output reg clk_1Hz,    // 1 Hz clock output
   output reg clk_fast,   // Faster clock output (50 - 700 Hz)
   output reg clk_adjust  // Clock for blinking in adjust mode (>1 Hz)

    );
    
    reg [32:0] counter_2Hz;
    reg [32:0] counter_1Hz;
    reg [32:0] counter_fast;
    reg [32:0] counter_adjust;
    
    initial begin 
         clk_2Hz <= 0;
         clk_1Hz <= 0;
         clk_fast <= 0;
         clk_adjust <= 0;
     counter_2Hz <= 0;
       counter_1Hz <= 0;
       counter_fast <=0;
       counter_adjust <= 0;
    end
    
    always @(posedge clk_100MHz) begin
        counter_2Hz <= counter_2Hz + 1;
        counter_1Hz <= counter_1Hz + 1;
        counter_fast <= counter_fast + 1;
        counter_adjust <= counter_adjust + 1;
    
        if (counter_2Hz == 25_000_000) begin
            clk_2Hz <= ~clk_2Hz;
            counter_2Hz <= 0;
        end
    
        if (counter_1Hz == 50_000_000) begin
            clk_1Hz <= ~clk_1Hz;
            counter_1Hz <= 0;
        end
    
        if (counter_fast == 142857) begin
            clk_fast <= ~clk_fast;
            counter_fast <= 0;
        end
    
        if (counter_adjust == 50_000_000) begin
            clk_adjust <= ~clk_adjust;
            counter_adjust <= 0;
        end
    end
endmodule