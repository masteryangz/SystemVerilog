`timescale 1ns/1ns
module tb_rom();

reg sys_clk;
reg sys_rst_n;
reg [1:0] key;
wire stcp;
wire shcp;
wire ds;
wire oe;

ROM ROM_inst(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key(key),
    .stcp(stcp),
    .shcp(shcp),
    .ds(ds),
    .oe(oe)
);

// Reset logic
initial begin
    sys_clk = 1'b1;
    sys_rst_n = 1'b0;
    key <= 2'b11;
    #200 sys_rst_n = 1'b1;
    #2000000 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #2000000 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #2000000 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #2000000 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #20 key[1] <= 1'b0;
    #20 key[1] <= 1'b1;
    #2000000 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #2000000 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
    #20 key[0] <= 1'b0;
    #20 key[0] <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

defparam rom_inst.key1_filter_inst.CNT_MAX=5;
defparam rom_inst.key2_filter_inst.CNT_MAX=5;
defparam rom_inst.rom_ctrl_inst.CNT_MAX=99;

endmodule