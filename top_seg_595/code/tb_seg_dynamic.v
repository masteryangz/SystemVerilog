`timescale 1ns/1ns
module tb_seg_dynamic();

reg sys_clk;
reg sys_rst_n;
reg [19:0] data;
reg [5:0] point;
reg seg_en;
reg sign;
wire [5:0] sel;
wire [7:0] seg;

seg_dynamic seg_dynamic_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .data(data),
    .point(point),
    .seg_en(seg_en),
    .sign(sign),
    .sel(sel),
    .seg(seg)
);

// Clock generation (50MHz clock as an example)
initial sys_clk = 1'b0;
always #10 sys_clk = ~sys_clk;  // 20ns period = 50MHz

// Reset logic
initial begin
    sys_rst_n = 1'b0;
    point = 6'b000010;
    seg_en = 1'b0;
    data = 20'd9876;
    sign = 1'b0;
    #32;
    sys_rst_n = 1'b1;
    #18
    seg_en = 1'b1;
    sign = 1'b1;
    #1000000000;
    $stop;
end



endmodule