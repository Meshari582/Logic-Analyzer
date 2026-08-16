module rate_div (
    input  clk,
    input  reset,
    output reg sample_en   // pulses high for 1 cycle every N clock ticks
);
    parameter N = 5;   // divide-by value — change this number to change the sample rate
	 
	  wire [3:0] count;
	  wire counter_reset;
	   assign counter_reset = reset || (count == N-1); //the module's own external reset input.
	                                                  //If a person/system asserts this, it's true (1).
																	  
     // continuously drive this wire's value based  on whatever's on the right-hand side,
	  //updating instantly anytime the right side changes
	  
	  //(count == N-1) — true (1) exactly when the counter has counted all the way up and hit its target value.
	  
	  counter counter1 (
        .clk(clk),
        .reset(counter_reset),
        .counter(count)
		 );
		 
always @(posedge clk) begin
		 
		     if (count == N-1) begin 
        sample_en <= 1;
		  end
    else
        sample_en <= 0;
   
	 end 
	 endmodule 