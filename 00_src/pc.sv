module pc(
  input  logic i_clk               , 
  input  logic i_rst              ,
 // input  logic i_stall            ,
  input  logic [31:0] i_next_pc    ,
  output logic [31:0] o_pc_current
);

always_ff @(posedge i_clk or posedge i_rst) begin
    if (i_rst)
        o_pc_current <= 32'd0;
    else// if (!i_stall)
         o_pc_current <= i_next_pc;
end
endmodule
