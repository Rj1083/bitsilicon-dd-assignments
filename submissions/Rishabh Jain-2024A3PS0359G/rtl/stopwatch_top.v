module stopwatch_top (
input wire clk,
input wire rst_n,
input wire start,
input wire stop,
input wire reset,
output wire [7:0] minutes,
output wire [5:0] seconds,
output wire [1:0] status
);
wire count_en,clear,minup;
control_fsm f1(.clk(clk),.rst_n(rst_n),.start(start),.stop(stop),.reset(reset),.count_en(count_en),.clear(clear),.state_out(status));
seconds_counter s1(.clk(clk),.rst_n(rst_n),.start(count_en),.reset(clear),.second(seconds),.minup(minup));
minutes_counter m1(.clk(clk),.rst_n(rst_n),.reset(reset),.minup(minup),.minutes(minutes));
/*.count_en(count_en_global),.clear(clear_internal),
input wire clk,rst_n,start,reset,output reg [5:0]second,output wire minup*/

endmodule
