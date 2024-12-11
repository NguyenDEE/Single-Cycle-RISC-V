module tb_sim();

    // Các khai báo tín hiệu và biến
    logic  i_clk;
    logic  i_rst;
    logic  [31:0] i_io_sw;
//    logic  [3:0] i_io_btn;
    logic  o_ins_n_vld;
    logic  [31:0] o_io_lcd;
    logic  [31:0] o_io_ledg;
    logic  [31:0] o_io_ledr;
    logic  [6:0]  o_io_hex0;
    logic  [6:0]  o_io_hex1;
    logic  [6:0]  o_io_hex2;
    logic  [6:0]  o_io_hex3;
    logic  [6:0]  o_io_hex4;
    logic  [6:0]  o_io_hex5;
    logic  [6:0]  o_io_hex6;
    logic  [6:0]  o_io_hex7;
    logic [31:0] pc_debug;
    logic [17:0]   o_SRAM_ADDR;
    logic [15:0]   o_SRAM_DQ  ;
    logic          o_SRAM_CE_N;
    logic          o_SRAM_WE_N;
    logic          o_SRAM_LB_N;
    logic          o_SRAM_UB_N;
    logic          o_SRAM_OE_N; 
    // Tạo xung nhịp
    always begin
        i_clk <= 1'b0;
        #50;  // Thay đổi độ rộng xung nhịp nếu cần
        i_clk <= 1'b1;
        #50;
    end

    // Khởi tạo tín hiệu
    initial begin
        i_rst = 1'b0;
        i_io_sw = 32'hffffffff;
  //      i_io_btn = 4'hf;
        #25;
        i_rst = 1'b1;
        #50000000;
        $finish;
    end

    // Ghi dạng sóng
    initial begin
        $dumpfile("waveform.vcd");  // Tên file VCD
        $dumpvars(0, tb_sim);       // Ghi tất cả biến trong module tb_all
    end

    // Khởi tạo mô-đun DUT
    singlecycle dut (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_io_sw(i_io_sw),
 //       .i_io_btn(i_io_btn),
        .o_insn_vld(o_ins_n_vld),
        .o_io_lcd(o_io_lcd),
        .o_io_ledg(o_io_ledg),
        .o_io_ledr(o_io_ledr),
        .o_io_hex0(o_io_hex0),
        .o_io_hex1(o_io_hex1),
        .o_io_hex2(o_io_hex2),
        .o_io_hex3(o_io_hex3),
        .o_io_hex4(o_io_hex4),
        .o_io_hex5(o_io_hex5),
        .o_io_hex6(o_io_hex6),
        .o_io_hex7(o_io_hex7),
        .o_pc_debug(pc_debug)
        /*
        .o_SRAM_ADDR (o_SRAM_ADDR),
        .o_SRAM_DQ  (o_SRAM_DQ ),
        .o_SRAM_CE_N (o_SRAM_CE_N),
        .o_SRAM_WE_N (o_SRAM_WE_N),
        .o_SRAM_LB_N (o_SRAM_LB_N),
        .o_SRAM_UB_N (o_SRAM_UB_N),
        .o_SRAM_OE_N (o_SRAM_OE_N)
        */
    );

endmodule
