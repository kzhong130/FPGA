module format_out_0(indt,outdt9,outdt8,outdt7,outdt6,outdt5,outdt4,outdt3,outdt2,outdt1,outdt0);
	input [31:0] indt;
	output outdt9,outdt8,outdt7,outdt6,outdt5,outdt4,outdt3,outdt2,outdt1,outdt0;
	
	assign outdt9=indt[9];
	assign outdt8=indt[8];
	assign outdt7=indt[7];
	assign outdt6=indt[6];
	assign outdt5=indt[5];
	assign outdt4=indt[4];
	assign outdt3=indt[3];
	assign outdt2=indt[2];
	assign outdt1=indt[1];
	assign outdt0=indt[0];
	
endmodule