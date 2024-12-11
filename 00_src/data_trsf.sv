module  data_trsf
(
    input logic [2:0] slt_sl,
    input logic [1:0] addr_sp,
    input logic wr_en,
    input logic [31:0] data_bf,
    input logic [31:0] data_bs,
    output logic [31:0] data_af
);
    // Định nghĩa giá trị SW, SB, SH, LW, LB, LH, LBU, LHU
    localparam SW = 3'b010, SB = 3'b000, SH = 3'b001;
    localparam LW = 3'b101, LB = 3'b011, LH = 3'b100;
    localparam LBU = 3'b110, LHU = 3'b111;
logic [31:0] memb_tmp,memh_tmp;
always_comb begin 
  case (addr_sp) 
  2'b00: begin
  memb_tmp = (data_bs & 32'h000000ff);
  memh_tmp = (data_bs & 32'h0000ffff);
  end
  2'b01: begin
  memb_tmp = (data_bs & 32'h0000ff00);
  memh_tmp = (data_bs & 32'h00ffff00);
  end
  2'b10: begin
  memb_tmp = (data_bs & 32'h00ff0000);
  memh_tmp = (data_bs & 32'hffff0000);
  end
  2'b11: begin
  memb_tmp = (data_bs & 32'hff000000);
  memh_tmp = (data_bs & 32'hffff0000);
  end
  endcase
end
always_comb begin
 if(wr_en) begin
   case (slt_sl) 
    SW: data_af = data_bf;
    SB: begin
    case(addr_sp)
    2'b00: data_af = (data_bf & 32'h000000ff) | (data_bs & 32'hffffff00);
    2'b01: data_af = ((data_bf & 32'h000000ff) << 8) | (data_bs & 32'hffff00ff);
    2'b10: data_af = ((data_bf & 32'h000000ff) << 16)| (data_bs & 32'hff00ffff);
    2'b11: data_af = ((data_bf & 32'h000000ff) << 24)| (data_bs & 32'h00ffffff);
    endcase
    end
    SH: begin
    case (addr_sp)
    2'b00: data_af = (data_bf & 32'h0000ffff) | (data_bs & 32'hffff0000); 
    2'b01: data_af = ((data_bf & 32'h0000ffff) << 8) | (data_bs & 32'hff0000ff); 
    2'b10: data_af = ((data_bf & 32'h0000ffff) << 16) | (data_bs & 32'hffff0000);
    2'b11: data_af = ((data_bf & 32'h0000ffff) << 16) | (data_bs & 32'hffff0000); 
    endcase 
    end
	 default: data_af = data_bf;
	 endcase
 end
 else begin
  case (slt_sl) 
   LW: data_af = data_bs;
   LB: data_af = memb_tmp;
   LH: data_af = memh_tmp;
   LBU: data_af = (memb_tmp[7] == 1)? (memb_tmp | 32'hffffff00): memb_tmp;
   LHU: data_af = (memh_tmp[13] == 1)? (memh_tmp | 32'hffff0000): memh_tmp;
	default: data_af = 32'h00000000;
  endcase
 end
end
endmodule
