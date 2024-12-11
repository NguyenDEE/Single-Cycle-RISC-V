module  brc (
	//  input
	input  logic  [31:0]  i_rs1_data,
	input  logic  [31:0]  i_rs2_data,
	input  logic          i_br_un,
	//  output
	output  logic  o_br_less,
	output  logic  o_br_equal
);
    logic  overFlag;
    logic  zeroFlag;
    logic  carryFlag;
    logic  [32:0]  sub;
    assign sub = {1'b0, i_rs1_data} + {1'b0, ~i_rs2_data} + 1'b1;  // Mở rộng thành 33 bit
    assign carryFlag = sub[32];  // Lấy bit carry từ sub
    assign  overFlag  =  ((i_rs1_data[31]  !=  i_rs2_data[31])  ?  ((i_rs1_data[31] == 1'b1)? 1'b1  :  1'b0)  :  !carryFlag);
    assign  zeroFlag  =  (sub  ==  0)? 1'b1: 1'b0;
    always_comb  begin
      o_br_equal = (zeroFlag == 1'b1) ? 1'b1: 1'b0;
      if (i_br_un) o_br_less = !carryFlag;
      else o_br_less = overFlag;
    end
endmodule 

