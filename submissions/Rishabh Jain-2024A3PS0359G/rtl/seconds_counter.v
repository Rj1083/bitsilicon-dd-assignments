module seconds_counter(input wire clk,rst_n,start,reset,output reg [5:0]second,output wire minup);
always@(posedge clk,negedge rst_n) begin
	if(!rst_n) second<=6'd0;
	else if(reset) second<=6'd0;
	else if(start) begin
		if(second==6'd59) second<=6'd0;
		else second<=second+1'd1;
	end
end
assign minup=(start && second==6'd59);
endmodule

