module  ctrl_unit  (
	//  input
	/* Verilator lint_off UNUSED */
	input  logic  [31:0]  i_instr      ,
	/* Verilator lint_on UNUSED */
	input  logic          i_br_less    ,
	input  logic          i_br_equal   ,
	//  output
  output  logic         o_insn_vld  ,
  output  logic  [2:0]  o_slt_sl     ,
	output  logic         o_pc_sel     ,
	output  logic         o_br_unsigned,
	output  logic         o_rd_wren    ,
	output  logic         o_op_a_sel   ,
	output  logic         o_op_b_sel   ,
	output  logic  [3:0]  o_alu_op    ,
	output  logic         o_mem_wren   ,
	output  logic  [1:0]  o_wb_sel    ,
	output  logic  [2:0]  o_imm_sel
);
    always_comb  begin
        o_insn_vld    =  1'b0;
        o_slt_sl         =  3'b000;
        o_pc_sel       =  1'b0;  
        o_br_unsigned  =  1'b0;  
        o_rd_wren      =  1'b0;  
        o_op_a_sel     =  1'b0;  
        o_op_b_sel     =  1'b0;  
        o_mem_wren     =  1'b0;  
        o_wb_sel      =  2'b00;  
        o_alu_op      =  4'd0;  
        o_imm_sel      =  3'b000;
      case  (i_instr  [6:0])
        // R-type 
        7'b0110011:  begin
            case  (i_instr  [14:12])  // function 3  điều khiển con alu
              3'b000  :  o_alu_op =  (i_instr[30]) ?  4'h1   : 4'h0;
              3'b010  :  o_alu_op =  4'd2;  // slt
              3'b011  :  o_alu_op =  4'd3;  // sltu
              3'b100  :  o_alu_op =  4'd4;  // xor
              3'b110  :  o_alu_op =  4'd5;  // or
              3'b111  :  o_alu_op =  4'd6;  // and
              3'b001  :  o_alu_op =  4'd7;  // sll
              3'b101  :  o_alu_op =  (i_instr[30])  ?  4'd9  :  4'd8;  // srl or sra
              default :  o_alu_op =  4'd0;
            endcase
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b0;  // khong lay kq tu ALU
            o_br_unsigned  =  (o_alu_op ==  4'h3)? 1'b1 :1'b0;  // kiem tra thang fun3 xem co phai la lenh co unsign k
            o_rd_wren      =  1'b1;  // cho phep gh vao regfile
            o_op_a_sel     =  1'b0;  // dung toan hang tu thanh ghi
            o_op_b_sel     =  1'b0;  // tuong tu cai tren
            o_mem_wren     =  1'b0;
            o_wb_sel      =  2'b00;  // lay kq tu alu
            o_imm_sel      =  3'b000;
          end
        // I-type
        7'b0010011:  begin
            case  (i_instr  [14:12])  // function 3  điều khiển con alu
              3'b000  :  o_alu_op =  4'd0;  // add
              3'b010  :  o_alu_op =  4'd2;  // slt
              3'b011  :  o_alu_op =  4'd3;  // sltu
              3'b100  :  o_alu_op =  4'd4;  // xor
              3'b110  :  o_alu_op =  4'd5;  // or
              3'b111  :  o_alu_op =  4'd6;  // and
              3'b001  :  o_alu_op =  4'd7;  // sll
              3'b101  :  o_alu_op =  (i_instr[30]  ?  4'd9  :  4'd8);  // srl or sra
              default :  o_alu_op =  4'd0;
            endcase
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b0;  // PC+4
            o_br_unsigned  =  (o_alu_op ==  4'h3)? 1'b1 :1'b0;  // kiem tra thang fun3 xem co phai la lenh co unsign k
            o_rd_wren      =  1'b1;  // cho phep ghi vao
            o_op_a_sel     =  1'b0;  //chon thanh ghi
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b00;  // lay tu alu
            o_imm_sel      =  3'b001;
          end
      // van la I-type nma dung cho LW
      7'b0000011:  begin
            o_insn_vld    =  1'b1;
            o_pc_sel       =  1'b0;  // PC+4
            o_br_unsigned  =  1'b0;  // do la tuy dinh nen em de 0
            o_rd_wren      =  1'b1;  // cho phep ghi vao
            o_op_a_sel     =  1'b0;  //chon thanh ghi
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b01;  // lay tu lsu
            o_alu_op      =  4'd0;  // chon cau lenh add
            o_imm_sel      =  3'b001;
            case(i_instr[14:12])
              3'b000: o_slt_sl = 3'b011; // lb
              3'b001: o_slt_sl = 3'b100; // lh
              3'b010: o_slt_sl = 3'b101; // lw
              3'b100: o_slt_sl = 3'b110; // lbu
              3'b101: o_slt_sl = 3'b111; // lhu
              default o_slt_sl = 3'b101;
            endcase
          end
      //  S-type
      7'b0100011:  begin
            o_insn_vld    =  1'b1;
            o_pc_sel       =  1'b0;  // PC+4
            o_br_unsigned  =  1'b0;  // do la tuy dinh nen em de 0
            o_rd_wren      =  1'b0;  // khong cho phep ghi vao
            o_op_a_sel     =  1'b0;  //chon thanh ghi
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b1;  // write vao dmem
            o_wb_sel      =  2'b01;  // lay tu lsu
            o_alu_op      =  4'd0;  // chon cau lenh add
            o_imm_sel      =  3'b010;
          case(i_instr[14:12])
            3'b000: o_slt_sl = 3'b000; // sb
            3'b001: o_slt_sl = 3'b001; // sh
            3'b010: o_slt_sl = 3'b010; // sw
            default o_slt_sl = 3'b010;
          endcase
          end
       7'b0110111:  begin  // LUI
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b0;  //PC+4
            o_br_unsigned  =  1'b0;  
            o_rd_wren      =  1'b1;  // cho ghi vao
            o_op_a_sel     =  1'b0;  // chon thanh ghi
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b00;  // ALU
            o_alu_op      =  4'd10;  
            o_imm_sel      =  3'b101;
             end     
      //  AUIPC
      7'b0010111:    begin
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b0;  //PC+4
            o_br_unsigned  =  1'b0;  
            o_rd_wren      =  1'b1;  // cho ghi vao
            o_op_a_sel     =  1'b1;  // chon PC
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b00;  // ALU
            o_alu_op      =  4'd0;  // add
            o_imm_sel      =  3'b101;
           end
      7'b1101111:  begin  //JAL
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b1;  // ALU
            o_br_unsigned  =  1'b0;  
            o_rd_wren      =  1'b1;  // cho ghi vao
            o_op_a_sel     =  1'b1;  // chon PC
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b10;  // PC+4
            o_alu_op      =  4'd0;  // add
            o_imm_sel      =  3'b100;
           end
      7'b1100111:  begin  //JARL
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_pc_sel       =  1'b1;  // ALU
            o_br_unsigned  =  1'b0;  
            o_rd_wren      =  1'b1;  // cho ghi vao
            o_op_a_sel     =  1'b0;  // chon thanh ghi
            o_op_b_sel     =  1'b1;  // chon immediate
            o_mem_wren     =  1'b0;  // read
            o_wb_sel      =  2'b10;  // PC+4
            o_alu_op      =  4'd0;  // add
            o_imm_sel      =  3'b001;
           end
      //  B-type
      7'b1100011:  begin
            o_insn_vld    =  1'b1;
            o_slt_sl         =  3'b000;
            o_br_unsigned =  ((i_instr  [14:12]  ==   3'b111)  ?  1'b1  :  ((i_instr  [14:12]  ==   3'b110)  ?  1'b1  :   1'b0));
            o_pc_sel       =  ((i_instr  [14:12]  ==  3'b000)  ?  (i_br_equal  ?  1'b1  :  1'b0)  :  ((i_instr  [14:12]  ==  3'b100)  ?  
                              (i_br_less  ?  1'b1  :  1'b0)  :  ((i_instr  [14:12]  ==  3'b110)  ?  (i_br_less  ?  1'b1  :  1'b0)  : 
                              ((i_instr  [14:12]  ==  3'b001)  ?  (i_br_equal  ?  1'b0  :  1'b1)  :  (i_br_less  ?  1'b0  :  1'b1))))); 
            o_rd_wren      =  1'b0;
            o_op_a_sel     =  1'b1;
            o_op_b_sel     =  1'b1;  
            o_mem_wren     =  1'b0;  
            o_wb_sel      =  2'b01;  //  tuy dinh  
            o_alu_op      =  4'd0; 
            o_imm_sel      =  3'b011;
           end
      default:  begin
          o_insn_vld    =  1'b0;
          o_slt_sl         =  3'b000;
          o_pc_sel       =  1'b0;  // ALU
          o_br_unsigned  =  1'b0;  //tuy dinh
          o_rd_wren      =  1'b0;  // cho ghi vao
          o_op_a_sel     =  1'b0;  // chon thanh ghi
          o_op_b_sel     =  1'b0;  // chon immediate
          o_mem_wren     =  1'b0;  // read
          o_wb_sel      =  2'b00;  // PC+4
          o_alu_op      =  4'd0;  // add  
          o_imm_sel      =  3'b000;
           end
        endcase
    end
endmodule    
