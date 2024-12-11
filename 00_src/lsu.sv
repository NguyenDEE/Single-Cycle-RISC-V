module lsu(
  //input
  input logic         i_clk,
  input logic         i_rst,
  input logic  [31:0] i_st_data,
  input logic  [31:0] i_lsu_addr,
  input logic         i_lsu_wren,
  input logic  [31:0] i_io_sw,
//  input logic [3:0] i_io_btn,
  input logic [2:0] slt_sl,
  //sram
 /* output logic o_stall,
  output logic [17:0]   o_SRAM_ADDR,
  inout  wire [15:0]   o_SRAM_DQ  ,
  output logic          o_SRAM_CE_N,
  output logic          o_SRAM_WE_N,
  output logic          o_SRAM_LB_N,
  output logic          o_SRAM_UB_N,
  output  logic          o_SRAM_OE_N, 
  */
  //out put
  output logic [31:0] o_ld_data ,
  output logic [31:0] o_io_ledr, 
  output logic [31:0] o_io_ledg ,
  output logic [6:0] o_io_hex0, 
  output logic [6:0] o_io_hex1, 
  output logic [6:0] o_io_hex2,   
  output logic [6:0] o_io_hex3, 
  output logic [6:0] o_io_hex4, 
  output logic [6:0] o_io_hex5, 
  output logic [6:0] o_io_hex6,   
  output logic [6:0] o_io_hex7, 
  output logic [31:0] o_io_lcd
  );
  logic en_datamem;
  logic en_op_buf;
  logic [31:0] data_out_1,data_out_2,io_sw;
  logic [31:0] INPUT;
  logic ACK;
always_ff @(posedge i_clk) begin
        INPUT <= i_io_sw; 
     end
assign io_sw = i_rst ? 32'd0: INPUT; 
  demux_sel_mem demux_1 (
    .i_lsu_addr(i_lsu_addr[15:0]),
    .en_datamem(en_datamem),
    .en_op_buf(en_op_buf)  
  );
  /*
  logic read_signal;
  logic write_signal;
  assign write_signal = ((slt_sl == 3'b010) & (~ACK)) ? 1'b1: 1'b0;
  assign read_signal = ((slt_sl == 3'b101) & (~ACK)) ? 1'b1: 1'b0; 
  assign o_stall = (en_datamem & ((slt_sl == 3'b101)|(slt_sl == 3'b010)) & (~ACK)) ? 1'b1: 1'b0;
  */
datamem mem (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_wren(i_lsu_wren),
    .i_enb(en_datamem),
    .i_addr(i_lsu_addr[14:1]),
    .i_data(i_st_data),
    .o_data(data_out_1)
);

  /*
 data_mem mem_sdram
(
    .in_CLK(i_clk),
    .in_CSn(i_rst),              // CHIP SELECT (active low)
    .in_write_en(i_lsu_wren),         // 1 = Write, 0 = Read
    .in_CASn(1'b1),             // Column Address Strobe (active low)
    .in_RASn(~en_datamem),             // Row Address Strobe (active low)
    .in_bank_select(i_lsu_addr[13:12]),      // Bank selection (2-bit)
    .in_sdram_addr(i_lsu_addr[12:0]),      // Row address (13-bit)
    .in_sdram_write_data(i_st_data),
    .out_sdram_read_data(data_out_1),
    .o_stall(o_stall) 
);
*/					
/*  sram_IS61WV25616_controller_32b_3lr sram_mem (
    .i_ADDR (i_lsu_addr[17:0]),
    .i_WDATA (i_st_data),
    .i_BMASK (4'b1111),
    .i_WREN  (write_signal),
    .i_RDEN  (read_signal) ,
    .o_RDATA (data_out_1) ,
    .o_ACK   (ACK) ,
    .SRAM_ADDR(o_SRAM_ADDR),
    .SRAM_DQ  (o_SRAM_DQ),
    .SRAM_CE_N (o_SRAM_CE_N),
    .SRAM_WE_N (o_SRAM_WE_N),
    .SRAM_LB_N (o_SRAM_LB_N),
    .SRAM_UB_N (o_SRAM_UB_N),
    .SRAM_OE_N (o_SRAM_OE_N),
    .i_clk (i_clk),
    .i_reset (en_datamem)
);
*/
  output_buffer  outputperiph (
    .slt_sl (slt_sl),
    .st_data_2_i   (i_st_data), 
    .addr_2_i      (i_lsu_addr[15:0]),
    .en_bf         (en_op_buf), 
    .st_en_2_i     (i_lsu_wren),
    .i_clk         (i_clk), 
    .i_rst         (i_rst),
    .data_out_2_o  (data_out_2), 
    .io_lcd_o      (o_io_lcd), 
    .io_ledg_o     (o_io_ledg), 
    .io_ledr_o     (o_io_ledr), 
    .io_hex0_o     (o_io_hex0), 
    .io_hex1_o     (o_io_hex1), 
    .io_hex2_o     (o_io_hex2), 
    .io_hex3_o     (o_io_hex3), 
    .io_hex4_o     (o_io_hex4), 
    .io_hex5_o     (o_io_hex5), 
    .io_hex6_o     (o_io_hex6), 
    .io_hex7_o     (o_io_hex7)
	  );
  mux_3_1_lsu mux31  (
    .in_data_3_i	(data_out_1), 
    .in_data_2_i	(data_out_2), 
    .in_data_1_i	(io_sw), 
    .i_lsu_addr     (i_lsu_addr[15:0]),
    .o_ld_data      (o_ld_data)
    );					
endmodule
