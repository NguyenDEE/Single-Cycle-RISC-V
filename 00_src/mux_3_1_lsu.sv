/* verilator lint_off UNUSED */
module mux_3_1_lsu(
  input logic [31:0] in_data_1_i,
  input logic [31:0] in_data_2_i,
  input logic [31:0] in_data_3_i,
  input logic [15:0] i_lsu_addr,
  output logic [31:0] o_ld_data
);
  logic [1:0] addr_sel ;
 
always_comb begin
  case (i_lsu_addr[15:4])
     12'h780:  addr_sel  =  2'b00; // SW
     12'h703:  addr_sel  =  2'b01; //LCD
     12'h702:  addr_sel  =  2'b01; //7-seg
     12'h701:  addr_sel  =  2'b01; //GRL
     12'h700:  addr_sel  =  2'b01; //RL
     default addr_sel = 2'b10; // MEM
  endcase
end
always_comb begin
  case(addr_sel)
  2'b00:o_ld_data = in_data_1_i; //input
  2'b01:o_ld_data = in_data_2_i; // op_bf
  2'b10:o_ld_data = in_data_3_i; // mem
  default: o_ld_data = 32'd0;    
  endcase
  end
endmodule

  

