module stopwatch(
    input clk,   
    input reset,  
    input start,   

    output reg [31:0] timer,           
    output reg enable_counting,        
    output reg enable_pause            
);

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            timer <= 0;
            enable_counting <= 0;
            enable_pause <= 0;
            state <= 0; 
        end
            if (state == 1) begin 
                if (start == 1) begin
                    enable_counting <= 1;
                    enable_pause <= 0;
                end
                else begin
                    enable_counting <= 0;
                    enable_pause <= 1;
                    state <= 2;
                end
            
           if (state == 2) begin 
                if (start) begin
                    enable_counting <= 0;
                    enable_pause <= 1;
                end
                else begin
                    enable_counting <= 1;
                    enable_pause <= 0;
                    state <= 1;
                end
            end
            else begin 
                if (start) begin
                    enable_counting <= 1;
                    enable_pause <= 0;
                    state <= 1;

                end
                else begin
                    enable_counting <= 0;
                    enable_pause <= 1;
                    state <= 2;
                end
            end
        end
    end

    // Modules for Paused and Counting states (assuming these are separate modules)
    // You need to define these modules separately

   // Paused pause_state(.en_p(enable_pause), .timer(timer));
    //Counting counting_state(.en_c(enable_counting), .timer(timer));

endmodule