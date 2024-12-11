
module output_buffer(
     input logic [2:0] slt_sl,
     input logic [31:0] st_data_2_i  ,
	 input logic [15:0] addr_2_i ,
     input logic en_bf, 
	 input logic st_en_2_i           ,
	 input logic i_clk               ,
     input logic i_rst              ,
	 output logic [31:0] data_out_2_o,
	 output logic [31:0] io_lcd_o    ,
	 output logic [31:0] io_ledg_o   ,
	 output logic [31:0] io_ledr_o   ,
	 output logic [6:0] io_hex0_o   ,
	 output logic [6:0] io_hex1_o   ,
	 output logic [6:0] io_hex2_o   ,
	 output logic [6:0] io_hex3_o   ,
	 output logic [6:0] io_hex4_o   ,
	 output logic [6:0] io_hex5_o   ,
	 output logic [6:0] io_hex6_o   ,
	 output logic [6:0] io_hex7_o
	 );
     logic [31:0] data_bs,data_tmp;
     logic [31:0] MEMBF [0:4];
     always_comb begin
        case(addr_2_i[15:4])
        12'h700: data_bs = MEMBF[0]; // LED Red
        12'h701: data_bs = MEMBF[1]; // led green
        12'h702: begin
            if (addr_2_i[2] == 1'b0) data_bs = MEMBF[2];// HEX 0-3
            else data_bs = MEMBF[3]; //HEX 4-7
        end
        12'h703: data_bs = MEMBF[4]; //lcd
        default data_bs = 32'h0;
        endcase
     end
    data_trsf trsf_st (
        .slt_sl(slt_sl),
        .addr_sp(addr_2_i[1:0]),
        .wr_en(st_en_2_i),
        .data_bf(st_data_2_i),
        .data_bs(data_bs),
        .data_af(data_tmp)
    );

	 always_ff @(posedge i_clk, posedge i_clk) begin
        if (i_rst) begin
            MEMBF[0] <= '0;
            MEMBF[1] <= '0;
            MEMBF[2] <= '0;
            MEMBF[3] <= '0;
            MEMBF[4] <= '0;
        end
        else if (en_bf) begin
           if (st_en_2_i) begin
        case(addr_2_i[15:4])
        12'h700: MEMBF[0] <= data_tmp; // LED Red
        12'h701: MEMBF[1] <= data_tmp; // led green
        12'h702: begin
            if (addr_2_i[2] == 1'b0) MEMBF[2] <= data_tmp;// HEX 0-3
            else MEMBF[3] <= data_tmp; //HEX 4-7
        end
        12'h703: MEMBF[4]<= data_tmp;
        default begin
             MEMBF[0] <= MEMBF[0];
             MEMBF[1] <= MEMBF[1];
             MEMBF[2] <= MEMBF[2];
             MEMBF[3] <= MEMBF[3];
             MEMBF[4] <= MEMBF[4];
            end
        endcase
           end          
        end
     end
    assign data_out_2_o = (i_rst == 1'b1) ? 32'h0: data_tmp;
    assign  io_ledr_o =  MEMBF[0];
    assign  io_ledg_o =  MEMBF[1];
    assign  io_hex0_o =  MEMBF[2][6:0];  
    assign  io_hex1_o =  MEMBF[2][14:8];
    assign  io_hex2_o =  MEMBF[2][22:16]; 
    assign  io_hex3_o =  MEMBF[2][30:24];
    assign  io_hex4_o =  MEMBF[3][6:0];
    assign  io_hex5_o =  MEMBF[3][14:8]; 
    assign  io_hex6_o =  MEMBF[3][22:16];
    assign  io_hex7_o =  MEMBF[3][30:24];    
    assign	io_lcd_o  =  MEMBF[4];               
  endmodule
  
