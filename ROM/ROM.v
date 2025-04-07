module ROM (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire [1:0] key,
    output wire stcp,
    output wire shcp,
    output wire ds,
    output wire oe
);
    
    //wire define
    wire [7:0] addr;
    wire [7:0] rom_data;    //rom data read out
    wire key1_flag;         //key1 filtering
    wire key2_flag;         //key2 filtering

    rom_ctrl rom_ctrl_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key1_flag(key1_flag),
        .key2_flag(key2_flag),
        .addr(addr)

    );

    key_filter key1_filter_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key[0]),        //key input
        .key_flag(key1_flag)    //key detected being pressed when high
    );

    key_filter key2_filter_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key[1]),
        .key_flag(key2_flag)
    );

    seg_595_dynamic seg_595_dynamic_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .data({12'd0,rom_data}),
        .point(0),
        .seg_en(1'b1),
        .sign(0),
        .stcp(stcp),
        .shcp(shcp),
        .ds(ds),
        .oe(oe)
    );

    rom_256x8 rom_256x8_inst(
        .address(addr),
        .clock(sys_clk),
        .q(rom_data)
    );

endmodule