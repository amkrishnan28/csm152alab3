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
    input wire adjust, 
    input wire select,
    output reg [5:0] minutes,
    output reg [5:0] seconds
    
    );

    always @ (posedge timer or posedge reset) begin
        if (reset) begin
            seconds <= 0;
            minutes <= 0;
        end
        else if(adjust && enable) begin
            if(select == 0) begin
                if(minutes == 59) begin
                    minutes <= 0;
                end
                else begin
                    minutes <= minutes + 1; 
                end             
            end
            if (select == 1) begin 
                if(seconds == 59) begin
                    seconds <= 0;
                end
                else begin
                    seconds <= seconds + 1;
                end
            end
        end
       

        else if (seconds == 59) begin
            seconds <= 0;
            if(minutes == 59) begin
                minutes <= 0;
            end
            
            else begin
             minutes <= minutes + 1;
         
            end     
        end    
        else  begin
                if(enable) begin
                  seconds <= seconds + 1;
                end
        end     
        

    end
endmodule