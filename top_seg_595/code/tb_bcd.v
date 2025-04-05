`timescale 1ns/1ns
module tb_bcd();

reg sys_clk;
reg sys_rst_n;
reg [19:0] data;
wire [3:0] unit;
wire [3:0] ten;
wire [3:0] hun;
wire [3:0] tho;
wire [3:0] t_tho;
wire [3:0] h_hun;

bcd_8421 bcd_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .data(data),
    .unit(unit),
    .ten(ten),
    .hun(hun),
    .tho(tho),
    .t_tho(t_tho),
    .h_hun(h_hun)
);

// Clock generation (50MHz clock as an example)
initial sys_clk = 1'b0;
always #10 sys_clk = ~sys_clk;  // 20ns period = 50MHz

// Reset logic
initial begin
    sys_rst_n = 0;
    data = 20'd987654;
    #12;
    sys_rst_n = 1;
    #1000000000;
    $stop;
end



endmodule