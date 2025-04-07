`timescale 1ns/1ns
module tb_hc595_ctrl();

reg sys_clk;
reg sys_rst_n;
reg [5:0] sel;
reg [7:0] seg;
wire stcp;
wire shcp;
wire ds;
wire oe;

hc595_ctrl hc595_ctrl_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .sel(sel),
    .seg(seg),
    .stcp(stcp),
    .shcp(shcp),
    .ds(ds),
    .oe(oe)
);

// Clock generation (50MHz clock as an example)
initial sys_clk = 1'b0;
always #10 sys_clk = ~sys_clk;  // 20ns period = 50MHz

// Reset logic
initial begin
    sys_rst_n = 1'b0;
    seg = 8'b1010;
    sel = 6'b110;
    #50;
    sys_rst_n = 1'b1;
    #1000000000;
    $stop;
end



endmodule