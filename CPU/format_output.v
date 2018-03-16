//module format_output(indt,outdt8,outdt7,outdt6,outdt5,outdt4,outdt3,outdt2,outdt1,outdt0,hex0,hex1,hex2,hex3,hex4,hex5);
module format_output(indt,hex0,hex1);

	input [31:0] indt;
	/*
	output outdt8,outdt7,outdt6,outdt5,outdt4,outdt3,outdt2,outdt1,outdt0;
	output [6:0] hex0,hex1,hex2,hex3,hex4,hex5;
	*/
	
	output [6:0] hex0,hex1;
	
	/*
	assign outdt8=1;
	assign outdt7=indt[7];
	assign outdt6=indt[6];
	assign outdt5=indt[5];
	assign outdt4=indt[4];
	assign outdt3=indt[3];
	assign outdt2=indt[2];
	assign outdt1=indt[1];
	assign outdt0=indt[0];
	*/
	
	/*
	sevenseg num1(indt[11:8],hex0);
	sevenseg num2(indt[15:12],hex1);
	sevenseg num3(indt[19:16],hex2);
	sevenseg num4(indt[23:20],hex3);
	sevenseg num5(indt[27:24],hex4);
	sevenseg num6(indt[31:28],hex5);
	*/
	reg [3:0] num0,num1;
	
	sevenseg anum1(num0,hex0);
	sevenseg anum2(num1,hex1);
	reg counter=1;
	always @ (indt)
	begin
		if(counter==1) counter=0;
		else counter=1;
		num0 = counter;
		num1 = indt[7:4];
	end
	
endmodule


module sevenseg (data, ledsegments);
    input [3:0] data;
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
