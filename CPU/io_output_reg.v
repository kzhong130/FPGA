module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,out_port0,out_port1 );
	input [31:0] addr,datain;
	input write_io_enable,io_clk;
	input clrn;
	//reset signal. if necessary,can use this signal to reset the output to 0.
	output [31:0] out_port0,out_port1;
	reg [31:0] out_port0; // output port0
	reg [31:0] out_port1; // output port1
	always @(posedge io_clk or negedge clrn)
	begin
	if (clrn == 0)
		begin // reset
		out_port0 <=0;
		out_port1 <=0; // reset all the output port to 0.
		end
	else
		begin
		if (write_io_enable == 1)
			case (addr[7:2])
			6'b100000: out_port0 <= datain; // 80h
			6'b100001: out_port1 <= datain; // 84h
	// more ports���ɸ�����Ҫ���Ƹ����������˿ڡ�
			endcase
		end
	end
endmodule

/*
module sevenseg (data, ledsegments);
    input [31:0] data;
    output ledsegments;
    reg [6:0] ledsegments;
    always @ (*)
		case(data)
			0: ledsegments = 7'b100_0000;
			1: ledsegments = 7'b111_1001;
			2: ledsegments = 7'b010_0100;
			3: ledsegments = 7'b011_0000;
			4: ledsegments = 7'b001_1001;
			5: ledsegments = 7'b001_0010;
			6: ledsegments = 7'b000_0010;
			7: ledsegments = 7'b111_1000;
			8: ledsegments = 7'b000_0000;
			9: ledsegments = 7'b001_0000;
			//10: ledsegments = 7'b011_1111;
			'ha: ledsegments = 7'b000_1000;
			'hb: ledsegments = 7'b000_0011;
			'hc: ledsegments = 7'b100_0110;
			'hd: ledsegments = 7'b010_0001;
			'he: ledsegments = 7'b000_0100;
			'hf: ledsegments = 7'b000_1110;
			default: ledsegments = 7'b111_1111;
		endcase
endmodule	
*/

/*module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7);
	input [31:0] addr,datain;
	input write_io_enable,io_clk;
	input clrn;
	//reset signal. if necessary,can use this signal to reset the output to 0.
	output [6:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
	
	//output [31:0] out_port0,out_port1;
	//reg [31:0] out_port0; // output port0
	//reg [31:0] out_port1; // output port1
	reg [31:0] out_port0_high, out_port0_low;
	reg [31:0] out_port1_high, out_port1_low;
	reg [31:0] res_3, res_2, res_1, res_0;
	
	always @(posedge io_clk or negedge clrn)
	begin
		if (clrn == 0)
		begin // reset
			out_port0_high <= 0; 
			out_port0_low <= 0;
			out_port1_high <= 0; 
			out_port1_low <= 0; // reset all the output port to 0.
		end
		else
		begin
			if (write_io_enable == 1)
				case (addr[7:2])
				6'b100000: // 80h
				begin
					out_port0_high <= datain[7:0]/10;
					out_port0_low <= datain[7:0]%10;
				end
				6'b100001: // 84h
				begin
					out_port1_high <= datain[7:0]/10;
					out_port1_low <= datain[7:0]%10;
				end
				6'b100010: // 88h
				begin
					res_3 <= datain[15:0]/1000;
					res_2 <= (datain[15:0]%1000)/100;
					res_1 <= (datain[15:0]%100)/10;
					res_0 <= datain[15:0]%10;
				end
				// more ports���ɸ�����Ҫ���Ƹ����������˿ڡ�
				endcase
		end
	end
	
	sevenseg LED8_out_port1_high (out_port0_high, hex7);
	sevenseg LED8_out_port1_low (out_port0_low, hex6);
	sevenseg LED8_out_port0_high (out_port1_high, hex5);
	sevenseg LED8_out_port0_low (out_port1_low, hex4);
	
	sevenseg LED8_res_3 (res_3, hex3);
	sevenseg LED8_res_2 (res_2, hex2);
	sevenseg LED8_res_1 (res_1, hex1);
	sevenseg LED8_res_0 (res_0, hex0);
	
endmodule

module sevenseg (data, ledsegments);
    input [31:0] data;
    output ledsegments;
    reg [6:0] ledsegments;
    always @ (*)
		case(data)
			0: ledsegments = 7'b100_0000;
			1: ledsegments = 7'b111_1001;
			2: ledsegments = 7'b010_0100;
			3: ledsegments = 7'b011_0000;
			4: ledsegments = 7'b001_1001;
			5: ledsegments = 7'b001_0010;
			6: ledsegments = 7'b000_0010;
			7: ledsegments = 7'b111_1000;
			8: ledsegments = 7'b000_0000;
			9: ledsegments = 7'b001_0000;
			//10: ledsegments = 7'b011_1111;
			'ha: ledsegments = 7'b000_1000;
			'hb: ledsegments = 7'b000_0011;
			'hc: ledsegments = 7'b100_0110;
			'hd: ledsegments = 7'b010_0001;
			'he: ledsegments = 7'b000_0100;
			'hf: ledsegments = 7'b000_1110;
			default: ledsegments = 7'b111_1111;
		endcase
endmodule



/*
module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,out_port0,out_port1 );
	input [31:0] addr,datain;
	input write_io_enable,io_clk;
	input clrn;
	//reset signal. if necessary,can use this signal to reset the output to 0.
	output [31:0] out_port0,out_port1;
	reg [31:0] out_port0; // output port0
	reg [31:0] out_port1; // output port1
	always @(posedge io_clk or negedge clrn)
	begin
		if (clrn == 0)
		begin // reset
			out_port0 <=0;
			out_port1 <=0; // reset all the output port to 0.
		end
		else
		begin
		if (write_io_enable == 1)
			case (addr[7:2])
				6'b100000: out_port0 <= datain; // 80h
				6'b100001: out_port1 <= datain; // 84h
				// more ports���ɸ�����Ҫ���Ƹ����������˿ڡ�
			endcase
		end
	end
endmodule
*/