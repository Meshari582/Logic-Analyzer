module trigger (
    input  clk,             // Sample clock — this module reacts once per tick
    input  probe_in,  	 // The (synced) signal we're watching for an edge
	 input polarity,
    output reg output_trigger  // Fires HIGH for exactly one tick when the edge happens
);

    reg prev_sample;   // The "sticky note" — holds what probe_in was ONE TICK AGO.
                        // Declared as reg (not wire) because it's written inside
                        // an always block. Lives outside the port list because
                        // nothing outside this module ever needs to see it —
                        // it's private, internal memory only.

 always @(posedge clk) begin
    if (polarity) begin
        // polarity = 1 means "watch for rising edges"
        if ((!prev_sample) && probe_in)
            output_trigger <= 1;
        else
            output_trigger <= 0;
    end else begin
        // polarity = 0 means "watch for falling edges"
        if (prev_sample&&(!probe_in))  
		  
            output_trigger <= 1;
        else
            output_trigger <= 0;
    end

    prev_sample <= probe_in;   // this still runs every tick, no matter what
end
      
 
endmodule