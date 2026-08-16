module readout (
    input clk,
    input reset,           // resets raddr back to page 0 at the start of a new capture
    input rd_strobe,            
    input rdata,           
    output reg [13:0] raddr,   // which page to read from
    output reg data_out       // the bit that comes back off that page
);
always @(posedge clk) begin
    if (reset) begin
        raddr <= 0;             // start over at page 0
    end
    else if (rd_strobe) begin
        data_out <= rdata;
        raddr    <= raddr+1;    // move on to the next page for next time
    end
end
endmodule