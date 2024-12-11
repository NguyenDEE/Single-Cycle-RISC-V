`define RESETPERIOD 15
`define FINISH      50000

module tbench;

// Clock and reset generator
  logic i_clk;
  logic i_reset;
task tsk_clock_gen(output logic clk);
    begin
        forever #5 clk = ~clk; // Tạo xung nhịp với chu kỳ 10 đơn vị thời gian
    end
endtask

task tsk_reset(output logic rst, input int delay);
    begin
        rst = 1; // Đặt tín hiệu reset ban đầu
        #delay;  // Giữ tín hiệu reset trong khoảng thời gian `delay`
        rst = 0; // Thả tín hiệu reset
    end
endtask

task tsk_timeout(input int time_limit);
    begin
        #time_limit;
        $display("Simulation Timeout: Time limit reached!");
        $finish;
    end
endtask

  initial tsk_clock_gen(i_clk);
  initial tsk_reset(i_reset, `RESETPERIOD);
  initial tsk_timeout(`FINISH);

// Wave dumping
  initial begin : proc_dump_wave
    $dumpfile("wave.vcd");
    $dumpvars(0, tbench);
  end

  logic [31:0]       i_io_sw  ;
  logic [31:0]       o_io_lcd ;
  logic [31:0]       o_io_ledg;
  logic [31:0]       o_io_ledr;
  logic [ 6:0]       o_io_hex0;
  logic [ 6:0]       o_io_hex1;
  logic [ 6:0]       o_io_hex2;
  logic [ 6:0]       o_io_hex3;
  logic [ 6:0]       o_io_hex4;
  logic [ 6:0]       o_io_hex5;
  logic [ 6:0]       o_io_hex6;
  logic [ 6:0]       o_io_hex7;

  logic [31:0]       o_pc_debug;
  logic              o_insn_vld;

  driver driverUnit(
    .i_io_sw,
    .i_clk,
    .i_reset
  );

  singlecycle singlecycle(
    .i_io_sw   ,
    .o_io_lcd  ,
    .o_io_ledg ,
    .o_io_ledr ,
    .o_io_hex0 ,
    .o_io_hex1 ,
    .o_io_hex2 ,
    .o_io_hex3 ,
    .o_io_hex4 ,
    .o_io_hex5 ,
    .o_io_hex6 ,
    .o_io_hex7 ,
    .o_pc_debug,
    .o_insn_vld,
    .i_clk,
    .i_rst(i_reset)
  );

  scoreboard scoreboard(
    .i_io_sw   ,
    .o_io_lcd  ,
    .o_io_ledg ,
    .o_io_ledr ,
    .o_io_hex0 ,
    .o_io_hex1 ,
    .o_io_hex2 ,
    .o_io_hex3 ,
    .o_io_hex4 ,
    .o_io_hex5 ,
    .o_io_hex6 ,
    .o_io_hex7 ,
    .o_pc_debug,
    .o_insn_vld,
    .i_clk,
    .i_reset
  );

endmodule : tbench
