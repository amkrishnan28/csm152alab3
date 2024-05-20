`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:55:13 PM
// Design Name: 
// Module Name: counting
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


module counting(
    input wire timer,
    input wire reset,
    input wire enable,
    output reg [5:0] minutes,
    output reg [5:0] seconds
    
    );
    initial begin
    minutes = 0;
    seconds = 0;
    
    end;
    

    
    always @ (posedge timer) begin
        if (reset) begin
            seconds <= 0;
            minutes <= 0;
        end
        if (enable) begin
            if(seconds == 59) begin
                minutes <= minutes + 1;
                seconds <= 0;
                if (minutes == 60) begin
                    minutes <= 0;
                    seconds <= 0;
                end
            end
            else begin
                 seconds <= seconds + 1;
            end
        end
    end
endmodule
