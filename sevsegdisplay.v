`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 03:42:07 PM
// Design Name: 
// Module Name: sevsegdisplay
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


module sevsegdisplay(
        input wire [5:0] min,
        input wire [5:0] sec,
        input wire adjust,
        input clk,
        output reg [0:6] seg,
        output reg [3:0] digit
        
    );
    
    
    
    

    
    reg hex;
    reg [1:0] digit_select;
    reg [3:0] secondOnes;
    reg [3:0] secondTens;
    reg [3:0] minuteOnes;
    reg [3:0] minuteTens;
    
    reg [16:0] refreshTimer;
    reg [16:0] blinkTimer;
    reg blink;
    initial begin
        refreshTimer = 0;
        secondOnes = 0;
        secondTens = 0;
        minuteOnes =0 ;
        minuteTens = 0;
        digit_select = 0;
        seg = 0;
        digit = 0;
        blink = 0;
    end
   always @ (posedge clk) begin
       if(adjust) begin
            if(blinkTimer == 100) begin
                 blinkTimer <= 0;
                 blink = ~blink;
            end
            
            else begin
                blinkTimer <= blinkTimer + 1;
            end
             
        end
        
        else begin
            blink <= 0;
            blinkTimer <= 0;
        end
        
 
        digit_select <= digit_select + 1;
      
   end
   
   
   always @(digit_select) begin
        case (digit_select)
            2'b00 : digit = 4'b1110; 
            2'b01 : digit = 4'b1101;
            2'b10 : digit = 4'b1011;
            2'b11 : digit = 4'b0111;
        endcase
   end
   
     always @ (secondOnes, secondTens, minuteOnes, minuteTens) begin
        secondOnes = sec % 10;
        secondTens = sec / 10;
        minuteOnes = min % 10;
        minuteTens = min / 10;
        if(blink == 1) begin
            seg = 7'b111_1111;
        end
        
        else begin
           case(digit_select)
                2'b00 : begin
                case(secondOnes)
                   4'b0000: seg= 7'b000_0001;    // digit 0
                   4'b0001: seg = 7'b100_1111;    // digit 1
                   4'b0010: seg = 7'b001_0010;    // digit 2
                   4'b0011: seg = 7'b000_0110;    // digit 3
                   4'b0100: seg = 7'b100_1100;    // digit 4
                   4'b0101: seg = 7'b010_0100;    // digit 5
                   4'b0110: seg = 7'b010_0000;    // digit 6
                   4'b0111: seg = 7'b000_1111;    // digit 7
                   4'b1000: seg= 7'b000_0000;    // digit 8
                   4'b1001: seg = 7'b000_0100;    // digit 9
                   default: seg= 7'b000_0100;  
                endcase 
                end
                2'b01 : begin
                case(secondTens)
                      4'b0000: seg= 7'b000_0001;    // digit 0
                                  4'b0001: seg = 7'b100_1111;    // digit 1
                                  4'b0010: seg = 7'b001_0010;    // digit 2
                                  4'b0011: seg = 7'b000_0110;    // digit 3
                                  4'b0100: seg = 7'b100_1100;    // digit 4
                                  4'b0101: seg = 7'b010_0100;    // digit 5
                                  4'b0110: seg = 7'b010_0000;    // digit 6
                                  4'b0111: seg = 7'b000_1111;    // digit 7
                                  4'b1000: seg= 7'b000_0000;    // digit 8
                                  4'b1001: seg = 7'b000_0100;    // digit 9
                                  default: seg= 7'b000_0100;  
                endcase
                end
                2'b10 : begin
                case(minuteOnes)
                4'b0000: seg= 7'b000_0001;    // digit 0
                                  4'b0001: seg = 7'b100_1111;    // digit 1
                                  4'b0010: seg = 7'b001_0010;    // digit 2
                                  4'b0011: seg = 7'b000_0110;    // digit 3
                                  4'b0100: seg = 7'b100_1100;    // digit 4
                                  4'b0101: seg = 7'b010_0100;    // digit 5
                                  4'b0110: seg = 7'b010_0000;    // digit 6
                                  4'b0111: seg = 7'b000_1111;    // digit 7
                                  4'b1000: seg= 7'b000_0000;    // digit 8
                                  4'b1001: seg = 7'b000_0100;    // digit 9
                                  default: seg= 7'b000_0100;  
                endcase
                end
                2'b11 : begin
                case(minuteTens)
                     4'b0000: seg= 7'b000_0001;    // digit 0
                                  4'b0001: seg = 7'b100_1111;    // digit 1
                                  4'b0010: seg = 7'b001_0010;    // digit 2
                                  4'b0011: seg = 7'b000_0110;    // digit 3
                                  4'b0100: seg = 7'b100_1100;    // digit 4
                                  4'b0101: seg = 7'b010_0100;    // digit 5
                                  4'b0110: seg = 7'b010_0000;    // digit 6
                                  4'b0111: seg = 7'b000_1111;    // digit 7
                                  4'b1000: seg= 7'b000_0000;    // digit 8
                                  4'b1001: seg = 7'b000_0100;    // digit 9
                                  default: seg= 7'b000_0100;  
                endcase
               end
         endcase
         end
       end
endmodule
