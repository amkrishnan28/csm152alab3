module top (
    input wire clk,
    input btnD,
    input btnU,
    input wire [15:0] sw, 
    output wire [0:6] seg,
    output wire [3:0] an
);
    reg enable;
    reg selection;
    reg adjust;
    reg reset;
    wire [5:0] minutes;
    wire [5:0] seconds;
    wire clk_100MHz; // 100 MHz master clock input
    wire reset_state;
    wire pause_state;
    wire  clk_2Hz;    // 2 Hz clock output
    wire  clk_1Hz;    // 1 Hz clock output
    wire  clk_fast;   // Faster clock output (50 - 700 Hz)
    wire clk_adjust;
    wire intermediate_rst;
    reg clk_counting;
    reg clk_display;
    initial begin 
        enable = 1;
        reset = 0;
        adjust = 0;
        selection = 0;
        clk_counting = clk_1Hz;
        clk_display = clk_fast;
    end
    
    clk clock (
        .clk_100MHz(clk),  // 100 MHz master clock input
        .clk_2Hz(clk_2Hz),
        .clk_1Hz(clk_1Hz),
        .clk_fast(clk_fast),
        .clk_adjust(clk_adjust)
    );
    debouncer rst_btn (
       .button(btnD),
       .clk(clk), 
       .btn_state(reset_state)
    );
   debouncer rst_pause (
       .button(btnU),
       .clk(clk), 
       .btn_state(pause_state)
    );
    
    
    
   
    always @ (posedge pause_state) begin
        if (pause_state) begin
            enable <= ~enable;
        
        end
    end
    // Instantiate the counting module
    counting uut (
        .timer(clk_counting),
        .reset(reset_state),
        .enable(enable),
        .adjust(adjust),
        .select(selection),
        .minutes(minutes),
        .seconds(seconds)
    );
    
    
   
    


    
    // Instantiate the 7-segment display module
    sevsegdisplay display (
        .min(minutes),
        .sec(seconds),
        .clk(clk_fast),
        .adjust(adjust),
        .selection(selection),
        .seg(seg),
        .digit(an)
    );
    
//    always @ (intermediate_rst) begin
//        reset <= intermediate_rst;
//    end
    
    reg[15:0] counter;
    reg [15:0] counter2;
    initial begin
        counter = 0;
        counter2 =0;
    end
   
//   always @ (posedge clk) begin
//        if(btnD == 0) begin
//            counter <= 0;
//            reset <= 0;
//        end
//        else begin
//            counter <= counter + 1;
//             if(counter == 16'b1111_1111_1111_1111) begin
//                reset <= 1;
//                counter <= 0;
//            end
//        end
//   end
   
   
   
    
    
    always @ (posedge clk) begin
   
        if (sw[0] == 0) begin
            selection <= 0;
        end
        
        if (sw[0] == 1) begin 
            selection <= 1;
        end
        
        if (sw[1] == 0) begin 
            adjust <= 0;
            clk_counting <= clk_1Hz;
        end
        
        if (sw[1] == 1) begin
            adjust <= 1;
            clk_counting <= clk_2Hz;
        end
    end
endmodule
