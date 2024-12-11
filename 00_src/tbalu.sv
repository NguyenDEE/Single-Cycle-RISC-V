module tbalu
();
logic  [31:0]  i_operand_a;
logic  [31:0]  i_operand_b;
logic [3:0]  i_alu_op;
logic  [31:0]  o_alu_data;
alu dut (
    .i_operand_a(i_operand_a),
    .i_operand_b(i_operand_b),
    .i_alu_op(i_alu_op),
    .o_alu_data(o_alu_data)
);
initial begin
    i_operand_a = 32'h1;
    i_operand_b = 32'h2;
    i_alu_op = 4'b0000;
    #5;
    $display("ADD = %h",o_alu_data);
    //
    #5;
    i_operand_a = 32'h1;
    i_operand_b = 32'h2;
    i_alu_op = 4'b0001;
    #5;
    $display("SUB = %h",o_alu_data);
    //
    i_operand_a = 32'h00000001;
    i_operand_b = 32'h00000002;
    i_alu_op = 4'b0010;
    #5;
    $display("SLT so duong = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h2;
    i_alu_op = 4'b0010;
    #5;
    $display("SLT so am = %h",o_alu_data);
        //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'hfffffffe;
    i_alu_op = 4'b0010;
    #5;
    $display("SLT so am voi so am  = %h",o_alu_data);
            //
    i_operand_a = 32'h02;
    i_operand_b = 32'h01;
    i_alu_op = 4'b0010;
    #5;
    $display("SLT so duong voi so duong  = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h02;
    i_alu_op = 4'b0010;
    #5;
    $display("SLT so am voi so duong= %h",o_alu_data);
     //
    i_operand_a = 32'h01;
    i_operand_b = 32'h02;
    i_alu_op = 4'b0011;
    #5;
    $display("SLTU so duong = %h",o_alu_data);
    //
    i_operand_a = 32'hfffffffe;
    i_operand_b = 32'hffffffff;
    i_alu_op = 4'b0011;
    #5;
    $display("SLTU so am voi am = %h",o_alu_data);
    //
    i_operand_a = 32'hffff0000;
    i_operand_b = 32'h0000ffff;
    i_alu_op = 4'b0011;
    #5;
    $display("XOR = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h3;
    i_alu_op = 4'b0010;
    #5;
    $display("SLTU = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h3;
    i_alu_op = 4'b0110;
    #5;
    $display("AND = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h0000ffff;
    i_alu_op = 4'b0101;
    #5;
    $display("OR = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h0000ffff;
    i_alu_op = 4'b0101;
    #5;
    $display("OR = %h",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h3;
    i_alu_op = 4'b0110;
    #5;
    $display("SLL = %b",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h3;
    i_alu_op = 4'b1000;
    #5;
    $display("SRL = %b",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h3;
    i_alu_op = 4'b1001;
    #5;
    $display("SRA = %b",o_alu_data);
    //
    i_operand_a = 32'hffffffff;
    i_operand_b = 32'h0000ffff;
    i_alu_op = 4'b1010;
    #5;
    $display("LUI = %h",o_alu_data);
    $finish;
end
endmodule

