module seg_dynamic (
    input wire sys_clk,         //system clk, 50MHz
    input wire sys_rst_n,       //reset at low
    input wire [19:0] data,     //data to be displayed
    input wire [5:0] point,     //decimal point to be displayed at high
    input wire seg_en,          //segment enable at high
    input wire sign,            //negative sign at high
    output reg [5:0] sel,       //digital selection signal
    output reg [7:0] seg        //segment selection signal
);
    
    parameter CNT_MAX = 16'd49999;  //counter to be refreshed

    wire [3:0] unit;
    wire [3:0] ten;
    wire [3:0] hun;
    wire [3:0] tho;
    wire [3:0] t_tho;
    wire [3:0] h_hun;

    reg [23:0] data_reg;    //reg holding data to be displayed
    reg [15:0] cnt_1ms;     //1ms counter
    reg flag_1ms;           //1ms flag
    reg [2:0] cnt_sel;      //digital selection counter
    reg [5:0] sel_reg;      //reg for selection signal
    reg [3:0] data_disp;    //current data displaying
    reg dot_disp;           //current dot displaying

    //data_reg: control data to be displayed
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) data_reg <= 24'b0;
        else if(h_hun||point[5]) data_reg <= {h_hun,t_tho,tho,hun,ten,unit};
        else if((t_tho || point[4]) && sign) data_reg <= {4'd10,t_tho,tho,hun,ten,unit};
        else if((t_tho || point[4]) && !sign) data_reg <= {4'd11,t_tho,tho,hun,ten,unit};
        else if((tho || point[3]) && sign) data_reg <= {4'd11,4'd10,tho,hun,ten,unit};
        else if((tho || point[3]) && !sign) data_reg <= {4'd11,4'd11,tho,hun,ten,unit};
        else if((hun || point[2]) && sign) data_reg <= {4'd11,4'd11,4'd10,hun,ten,unit};
        else if((hun || point[2]) && !sign) data_reg <= {4'd11,4'd11,4'd11,hun,ten,unit};
        else if((ten || point[1]) && sign) data_reg <= {4'd11,4'd11,4'd11,4'd10,ten,unit};
        else if((ten || point[1]) && !sign) data_reg <= {4'd11,4'd11,4'd11,4'd11,ten,unit};
        else if((unit || point[0]) && sign) data_reg <= {4'd11,4'd11,4'd11,4'd11,4'd10,unit};
        else data_reg <= {4'd11,4'd11,4'd11,4'd11,4'd11,unit};
    end

    //cnt_1ms: 1ms counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) cnt_1ms <= 16'd0;
        else if(cnt_1ms == CNT_MAX) cnt_1ms <= 16'd0;
        else cnt_1ms <= cnt_1ms + 1'b1;
    end

    //flag_1ms: high every 1ms
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) flag_1ms <= 1'b0;
        else if(cnt_1ms == CNT_MAX - 1'b1) flag_1ms <= 1'b1;
        else flag_1ms <= 1'b0;
    end

    //cnt_sel: counter from 0 to 5 to select the current segment to display
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) cnt_sel <= 3'd0;
        else if((cnt_sel == 3'd5)&&(flag_1ms)) cnt_sel <= 3'd0;
        else if(flag_1ms) cnt_sel <= cnt_sel + 1'b1;
        else cnt_sel <= cnt_sel;
    end

    //sel_reg: reg for selection signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) sel_reg <= 6'b0;
        else if((cnt_sel == 3'd0)&&(flag_1ms)) sel_reg <= 6'b000001;
        else if(flag_1ms) sel_reg <= sel_reg << 1;
        else sel_reg <= sel_reg;
    end

    //data_disp: digital selection signal to display digits sequentially
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) data_disp <= 4'b0;
        else if((seg_en)&&(flag_1ms)) begin
            case (cnt_sel)
                3'd0: data_disp <= data_reg[3:0];
                3'd1: data_disp <= data_reg[7:4];
                3'd2: data_disp <= data_reg[11:8];
                3'd3: data_disp <= data_reg[15:12];
                3'd4: data_disp <= data_reg[19:16];
                3'd5: data_disp <= data_reg[23:20];
                default: data_disp <= 4'b0;
            endcase
        end
        else data_disp <= data_disp;
    end

    //dot_disp: decimal point low when effective
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) dot_disp <= 1'b1;
        else if(flag_1ms) dot_disp <= ~point[cnt_sel];
        else dot_disp <= dot_disp;
    end

    //seg: number to be displayed
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) seg <= 8'b11111111;
        else begin
            case (data_disp)
                4'd0: seg <= {dot_disp,7'b1000000};
                4'd1: seg <= {dot_disp,7'b1111001};
                4'd2: seg <= {dot_disp,7'b0100100};
                4'd3: seg <= {dot_disp,7'b0110000};
                4'd4: seg <= {dot_disp,7'b0011001};
                4'd5: seg <= {dot_disp,7'b0010010};
                4'd6: seg <= {dot_disp,7'b0000010};
                4'd7: seg <= {dot_disp,7'b1111000};
                4'd8: seg <= {dot_disp,7'b0000000};
                4'd9: seg <= {dot_disp,7'b0010000};
                4'd10: seg <= {dot_disp,8'b10111111};
                4'd11: seg <= {dot_disp,8'b11111111};
                default: seg <= 8'b11000000;
            endcase
        end
    end

    //sel: sel signal from sel_reg
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(sys_rst_n == 1'b0) sel <= 6'b000000;
        else sel <= sel_reg;
    end

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

endmodule