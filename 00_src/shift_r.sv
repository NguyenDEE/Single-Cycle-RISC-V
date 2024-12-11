
module shift_r(
 input logic [31:0] i_rs,
 input logic [4:0]  i_amount,
 output logic [31:0] result
 );

 logic [31:0] b_1, b_2, b_3, b_4;
 
  mux_2_1 shift_16bit(.data_1_i({16'b0, i_rs[31:16]}), .data_0_i(i_rs),  .sel_i(i_amount[4]), .data_out_o(b_1)    );
  mux_2_1 shift_8bit (.data_1_i({8'b0 , b_1 [31:8] }), .data_0_i(b_1 ),  .sel_i(i_amount[3]), .data_out_o(b_2)    );
  mux_2_1 shift_4bit (.data_1_i({4'b0 , b_2 [31:4] }), .data_0_i(b_2 ),  .sel_i(i_amount[2]), .data_out_o(b_3)    );
  mux_2_1 shift_2bit (.data_1_i({2'b0 , b_3 [31:2] }), .data_0_i(b_3 ),  .sel_i(i_amount[1]), .data_out_o(b_4)    );
  mux_2_1 shift_1bit (.data_1_i({1'b0 , b_4 [31:1] }), .data_0_i(b_4 ),  .sel_i(i_amount[0]), .data_out_o(result) );
  

 endmodule





