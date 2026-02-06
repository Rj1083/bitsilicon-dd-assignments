module minutes_counter(input wire clk,rst_n,reset,minup,output reg [7:0] minutes);
always@(posedge clk,negedge rst_n) begin
	if(!rst_n) minutes<=8'd0;
	else if(reset) minutes<=8'd0;
	else if(minup) begin
		if(minutes==8'd99) minutes<=8'd0;
		else minutes<=minutes+1'd1;
		end
	end
endmodule

