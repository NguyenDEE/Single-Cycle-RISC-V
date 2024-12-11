module alu
(
	//  input
	input  logic  [31:0]  i_operand_a,
	input  logic  [31:0]  i_operand_b,
    input  logic   [3:0]  i_alu_op,
	//  output
	output  logic  [31:0]  o_alu_data
);
     // Định nghĩa các hằng số cho các phép toán ALU
    localparam logic [3:0] A_ADD  = 4'b0000;
    localparam logic [3:0] A_SUB  = 4'b0001;
    localparam logic [3:0] A_SLT  = 4'b0010;
    localparam logic [3:0] A_SLTU = 4'b0011;
    localparam logic [3:0] A_XOR  = 4'b0100;
    localparam logic [3:0] A_OR   = 4'b0101;
    localparam logic [3:0] A_AND  = 4'b0110;
    localparam logic [3:0] A_SLL  = 4'b0111;
    localparam logic [3:0] A_SRL  = 4'b1000;
    localparam logic [3:0] A_SRA  = 4'b1001;
    localparam logic [3:0] A_LUI  = 4'b1010;
    logic  carryFlag, overFlag;
    logic  [32:0]  sub;
    logic [31:0] srl_tmp,srr_tmp,sra_tmp;
    assign sub = {1'b0, i_operand_a} + {1'b0, ~i_operand_b} + 1'b1;  // Mở rộng thành 33 bit
    assign carryFlag = sub[32];  // Lấy bit carry từ sub
    assign  overFlag  =  ((i_operand_a[31]  !=  i_operand_b[31])  ?  ((i_operand_a[31] == 1'b1)?  1'b1  :  1'b0)  :  !carryFlag);
    shift_l shiftl_1(
        .i_rs(i_operand_a),
        .i_amount(i_operand_b[4:0]),
        .result(srl_tmp)
    );
    shift_r shiftr_1 (
        .i_rs(i_operand_a),
        .i_amount(i_operand_b[4:0]),
        .result(srr_tmp)
    );
    shift_ra shiftra_1 
    (
        .i_rs(i_operand_a),
        .i_amount(i_operand_b[4:0]),
        .result(sra_tmp)
    );
    always_comb begin 
        case  (i_alu_op)
        A_ADD:  o_alu_data  =  i_operand_a  +  i_operand_b;
           
        A_SUB:  o_alu_data  =  sub[31:0];
           
        A_SLT:  o_alu_data  =  {31'd0,  overFlag};
           
        A_SLTU:  o_alu_data  =  {31'd0,  !carryFlag};
           
        A_XOR:  o_alu_data  =  i_operand_a  ^  i_operand_b;
           
        A_OR:  o_alu_data  =  i_operand_a  |  i_operand_b;
           
        A_AND:  o_alu_data  =  i_operand_a  &  i_operand_b;
           
        A_SLL:  o_alu_data  =  srl_tmp;
           
        A_SRL:  o_alu_data  =  srr_tmp;
           
        A_SRA   :  o_alu_data  =  sra_tmp;

        A_LUI   :  o_alu_data  =  i_operand_b;
        default    o_alu_data  = 32'd0 ;
        endcase
    end
endmodule

