`timescale 1 ns / 100 ps
 module buffer_tb;

    reg clk;
    reg  we;
    reg  [13:0] waddr;
    reg  wdata;
    reg  [13:0] raddr;
    wire rdata;
    // Clock generation:  20ns 
    always begin
        #10;
        clk <= ~clk;
    end

initial begin
    // start everything at a known state
    clk   <= 1'b0;
    we    <= 1'b0;
    waddr <= 14'd0;
    wdata <= 1'b0;
    raddr <= 14'd0;
	 rdata <= 1'b0;
	 
    #20;

    // write a 1 onto page 5
    we    <= 1'b1;
    waddr <= 14'd5;
    wdata <= 1'b1;
    #20;
    we <= 1'b0;   // done writing

    #20;   // idle a tick, nothing happens


    raddr <= 14'd5;
    #20;   // one tick after setting raddr 

    $stop;
end
	  // Instantiate the DUT
    buffer dut (
        .clk(clk),
        .we(we),
        .waddr(waddr),
        .wdata(wdata),
        .raddr(raddr),
		  .rdata(rdata)
    );

endmodule
