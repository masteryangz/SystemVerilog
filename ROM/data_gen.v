module data_gen #(
    parameter CNT_MAX = 23'd4999999,
    parameter DATA_MAX = 20'd999999
) (
    input wire sys_clk,
    input wire sys_rst_n,
    output reg [19:0] data,     //data to be displayed
    output reg [5:0] point,     //decimal point placement
    output reg seg_en,          //display segment enable
    output reg sign             //sign is negative when signal is positive
);
    
    //reg define
    reg [22:0] cnt_100ms;   //100ms counter
    reg cnt_flag;           //100ms flag

    //cnt_100ms reset when it reaches CNT_MAX
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) begin
            cnt_100ms <= 23'd0;
            point <= 6'b000_000;
            sign <= 1'b0;
        end
        else if(cnt_100ms == CNT_MAX) cnt_100ms <= 23'd0;
        else cnt_100ms <= cnt_100ms + 1'b1;
    end

    //cnt_flag is positive every 100ms(cnt_100ms==CNT_MAX)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) cnt_flag <= 1'b0;
        else if(cnt_100ms == CNT_MAX - 1'b1) cnt_flag <= 1'b1;
        else cnt_flag <= 1'b0;
    end

    //assign values for data
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) data <= 20'd0;
        else if((data == DATA_MAX)&&(cnt_flag == 1'b1)) data <= 20'd0;
        else if(cnt_flag == 1'b1) data <= data + 1'b1;
        else data <= data;
    end

    //assign seg_en
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) seg_en <= 1'b0;
        else seg_en <= 1'b1;
    end

endmodule