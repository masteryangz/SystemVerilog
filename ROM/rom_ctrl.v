module rom_ctrl (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire key1_flag,   //key1 after filtering
    input wire key2_flag,   //key2 after filtering
    output reg [7:0] addr   //address in ROM
);
    
    //parameter define
    parameter CNT_MAX = 9999999;    //0.2s counter largest

    //reg define
    reg addr_flag1;
    reg addr_flag2;
    reg [23:0] cnt_200ms;

    //generate addr_flag1
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) addr_flag1 <= 1'b0;
        else if(key2_flag) addr_flag1 <= 1'b0;
        else if(key1_flag) addr_flag1 <= ~addr_flag1;
    end

    //generate addr_flag2
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) addr_flag2 <= 1'b0;
        else if(key1_flag) addr_flag2 <= 1'b0;
        else if(key2_flag) addr_flag2 <= ~addr_flag2;
    end

    //0.2s recursive counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) cnt_200ms <= 24'd0;
        else if((cnt_200ms == CNT_MAX) || addr_flag1 || addr_flag2) cnt_200ms <= 24'd0;
        else cnt_200ms <= cnt_200ms + 1'b1;
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) addr <= 8'd0;
        else if(addr == 8'd255 && cnt_200ms == CNT_MAX) addr <= 8'd0;
        else if(addr_flag1) addr <= 8'd99;
        else if(addr_flag2) addr <= 8'd199;
        else if(cnt_200ms == CNT_MAX) addr <= addr + 1'b1;
    end

endmodule