module pcdebug (
    input logic i_clk,
    input logic [31:0] i_pc,
    output logic [31:0] o_pc_debug
);
logic [31:0] reg_pc;
always_ff @(posedge i_clk) begin
    reg_pc <= i_pc;
end
assign o_pc_debug = reg_pc;
endmodule
