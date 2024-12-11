module  immgen  (
	input   logic  [31:0]  i_inst,
	input   logic  [2 :0]  i_immsel,
	output  logic  [31:0]  o_imm
);
    always_comb  begin
      case  (i_immsel)
        3'b000  :   // R
            o_imm  =  0;
        3'b001  :  //I
          begin
            o_imm[31:11]  =  {21{i_inst[31]}};
            o_imm[10:5]  =  i_inst[30:25];
            o_imm[4:1]  =  i_inst[24:21];
            o_imm[0]  =  i_inst[20];
          end
        3'b010  :  //  S-imm
          begin
            o_imm[31:11]  =  {21{i_inst[31]}};
            o_imm[10:5]  =  i_inst[30:25];
            o_imm[4:1]  =  i_inst[11:8];
            o_imm[0]  =  i_inst[7];
          end
        3'b011  :  //  B-imm
          begin
            o_imm[31:12]  =  {20{i_inst[31]}};
            o_imm[11]  =  i_inst[7];
            o_imm[10:5]  =  i_inst[30:25];
            o_imm[4:1]  =  i_inst[11:8];
            o_imm[0]  =  1'b0;
          end
        3'b100:  // j-imm
          begin
            o_imm[31:20]  =  {12{i_inst[31]}};
            o_imm[19:12]  =  i_inst[19:12];
            o_imm[11]     =  i_inst[20];
            o_imm[10:1]   =  i_inst[30:21];
            o_imm[0]      =  1'b0;
          end
        3'b101:  o_imm  =  {i_inst  [31:12],  12'd0};  // U-imm
        default  :  o_imm  =  i_inst;
      endcase
    end
endmodule  :  immgen
