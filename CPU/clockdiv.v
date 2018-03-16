module clockdiv(clk,clock,mem_clk);
	input clk;
	output clock, mem_clk;
	reg clock, mem_clk;
	reg [10:0] counter;
	always @(posedge clk)
	begin
		counter <= counter + 1;
		//if (counter==125)
		if(counter==50000000)
		begin
			mem_clk <= ~mem_clk;
			counter <= 0;
		end
	end
		
	always @(posedge mem_clk)
	begin
		clock <= ~clock;
	end
endmodule
