module datamem (
    input logic i_clk,
    input logic i_rst,
    input logic i_wren,
    input logic i_enb,
    input logic [13:0] i_addr,
    input logic [31:0] i_data,
    output logic [31:0] o_data
);
logic [31:0] data_mem [2048:0];
always_ff @ (posedge i_clk) begin
    if (i_enb && i_wren) begin
        data_mem[i_addr[13:2]] <= i_data;
     end
    end
assign o_data = (i_rst == 1'b1) ? 32'h0: data_mem[i_addr[13:2]];
endmodule

