module inst_memory 
  (
  output logic [31:0]       o_rdata,

  /* verilator lint_off UNUSED */
  input  logic [13:0] i_addr ,
  input  logic              i_rst
  /* verilator lint_on UNUSED */
);

  logic [31:0] imem [2048:0];
  initial begin
    $readmemh("/mnt/d/RTL/Milestone2_submit/02_test/dump/mem.dump", imem);
  end
always_comb begin
    if (i_rst) begin
      o_rdata = 32'h0;  
    end else begin
      o_rdata = imem[i_addr[13:2]];  
    end
  end
endmodule
