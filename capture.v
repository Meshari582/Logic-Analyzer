module capture (
    input  clk,
    input  output_trigger,
    input  sample_en,     // from rate_div — only sample when this is high
    input  arm,   	 // from MCU — kicks FULL back to IDLE for next capture
	 input reset,
    output reg done, //
    output reg [13:0] sample_counter,
    output reg we
);
    parameter IDLE    = 2'b00;
    parameter RUNNING = 2'b01;
    parameter FULL    = 2'b10;
    parameter MAX_SAMPLES = 16384;
    reg [1:0]  state;

    always @(posedge clk or posedge reset) begin
	if (reset) begin
        done           <= 0;
        sample_counter <= 0;
        we             <= 0;
        state          <= IDLE;     
    end
else begin 
        case (state)
            IDLE: begin
                sample_counter <= 0;   // reset ready for next capture
                done           <= 0;   // clear done flag from any previous run
                we             <= 0;   // not sampling in IDLE, every tick
                if (output_trigger)
                    state <= RUNNING;
                else
                    state <= IDLE;
            end
            RUNNING: begin
                if (sample_en) begin
                    we             <= 1;   // write THIS tick's sample — every pulse, including the last
                    sample_counter <= sample_counter + 1;
                    if (sample_counter == MAX_SAMPLES - 1)
                        state <= FULL;
                    else
                        state <= RUNNING;
                end
                else begin
                    we    <= 0;   // no sample_en pulse this tick, don't write
                    state <= RUNNING;   // no sample tick yet, just wait
                end
            end
            FULL: begin
                we   <= 0;   // done sampling, never write here
                done <= 1;
                if (arm)
                    state <= IDLE;
                else
                    state <= FULL;
            end
            default: state <= IDLE;   //if state doesn't match IDLE, RUNNING, or FULL, do this instead.
                                          //safety net against unknown/undefined states

        endcase
    end
	 end
endmodule
