module control_fsm(input wire clk,input wire start,input wire reset,input wire stop,input wire rst_n,output reg count_en,output reg clear,output wire [1:0] state_out);
reg [1:0] ps,ns;
parameter res=2'b00,run=2'b01,pause=2'b10;
assign state_out=ps;
always @(*) begin
ns=ps;
case(ps)
res: if(start) ns=run;
run: if(stop) ns=pause;
pause: if(start) ns=run;
default:ns=res;
endcase
end
always@(posedge clk,negedge rst_n) begin
if(!rst_n) ps<=res;
else if(reset) ps<=res;
else ps<=ns;
end
always @(*) begin
        count_en = (ps == run);
        clear    = reset;
    end  
endmodule

