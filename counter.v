module counter (
input clk,
input reset,
output reg [3:0] counter // 4 bits — can represent 0–15
);
always @(posedge clk) begin
if (reset) //if reset=1,
counter <= 4'b0000; //reset the count to 0 
else 
counter <= counter+1; //otherwise increment the counter by 1
end 
endmodule