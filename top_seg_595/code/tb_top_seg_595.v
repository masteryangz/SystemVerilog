`timescale 1ns/1ns
module tb_top_seg_595();

reg sys_clk;
reg sys_rst_n;
wire stcp;
wire shcp;
wire ds;
wire oe;

top_seg_595 top_seg_595_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .stcp(stcp),
    .shcp(shcp),
    .ds(ds),
    .oe(oe)
);

// Reset logic
initial begin
    sys_clk = 1'b1;
    sys_rst_n = 1'b0;
    #100
    sys_rst_n = 1'b1;
end

always #10 sys_clk <= ~sys_clk;

defparam top_seg_595_inst.seg_595_dynamic_inst.seg_dynamic_inst.CNT_MAX=19;
defparam top_seg_595_inst.data_gen_inst.CNT_MAX = 49;

endmodule