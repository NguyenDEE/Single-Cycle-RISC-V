module mux_2_1 (
  input logic [31:0] data_1_i    ,
  input logic [31:0] data_0_i    ,
  input logic        sel_i       ,
  output logic [31:0] data_out_o		
  );
  
  always_comb begin
    case (sel_i)
      1'b0 : data_out_o = data_0_i;
      1'b1 : data_out_o = data_1_i;
    endcase
  end
endmodule 
