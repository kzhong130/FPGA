module format_input(sw4,sw3,sw2,sw1,sw0,outdt);
	input sw4,sw3,sw2,sw1,sw0;
	output [31:0] outdt;
	assign outdt[4]=sw4;
	assign outdt[3]=sw3;
	assign outdt[2]=sw2;
	assign outdt[1]=sw1;
	assign outdt[0]=sw0;
endmodule