module pc_plus4(
  input  logic [31:0] pc_current_i,
  input  logic i_rst,
  output logic [31:0] pc_plus4_o
);always_comb begin
  if (i_rst) pc_plus4_o = 32'h0;
  else pc_plus4_o = pc_current_i + 32'd4;
end
endmodule
