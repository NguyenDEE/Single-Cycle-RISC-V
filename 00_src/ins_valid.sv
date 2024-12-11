module ins_valid (
    input logic i_clk,
    input logic i_ins_n_vld,
    output logic o_ins_n_vld
);
logic reg_ins_vld;
always_ff @(posedge i_clk) begin
    reg_ins_vld <= i_ins_n_vld;
end
assign o_ins_n_vld = reg_ins_vld;
endmodule
