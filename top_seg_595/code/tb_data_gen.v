`timescale 1ns/1ns
module tb_data_gen();

reg sys_clk;
reg sys_rst_n;
//wire [22:0] cnt_100ms;
//wire cnt_flag;
wire [19:0] data;
wire [5:0] point;
wire sign;
wire seg_en;

data_gen data_gen_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .data(data),
    .point(point),
    .seg_en(seg_en),
    .sign(sign)
);

// Clock generation (50MHz clock as an example)
initial sys_clk = 1'b0;
always #10 sys_clk = ~sys_clk;  // 20ns period = 50MHz

// Reset logic
initial begin
    sys_rst_n = 1'b0;
    #12;
    sys_rst_n = 1'b1;
    #1000000000;
    $stop;
end



endmodule