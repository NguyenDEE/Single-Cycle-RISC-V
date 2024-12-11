module demux_sel_mem (
    input logic [15:0] i_lsu_addr,
    output logic en_datamem,
    output logic en_op_buf  
);
parameter start_datamem = 16'h2000;
parameter end_datamem = 16'h4000;
parameter start_op_bf = 16'h7000;
parameter end_op_bf = 16'h7040;
always_comb begin 
    if ((i_lsu_addr >= start_datamem) && (i_lsu_addr < end_datamem)) begin
        en_datamem = 1'b1;
        en_op_buf = 1'b0;
    end
    else if ((i_lsu_addr >= start_op_bf) && (i_lsu_addr < end_op_bf)) begin
            en_datamem = 1'b0;
            en_op_buf = 1'b1;
    end
    else begin
        en_datamem = 1'b0;
        en_op_buf = 1'b0;
    end
end
endmodule
