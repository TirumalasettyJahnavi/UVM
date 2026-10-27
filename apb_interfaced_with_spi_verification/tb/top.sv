module top();


	import uvm_pkg::*;

	import test_pkg::*;

	bit clock;

	always #5 clock=~clock;

	apb_if in0(clock);

	spi_if in1(clock);

	top_module dut ( .pclk(clock),
		  .preset_n(in0.preset_n),
		  .PADDR_i(in0.paddr),
		  .PWRITE_i(in0.pwrite),
		  .PSEL_i(in0.psel),
		  .PENABLE_i(in0.penable),
		  .PWDATA_i(in0.pwdata),
		  .miso_i(in1.miso),
		  .ss_o(in1.ss),
		  .sclk_o(in1.sclk),
		  .spi_interrupt_request(in1.spi_interrupt_request),
		  .mosi_o(in1.mosi),
		  .PRDATA_o(in0.prdata),
		  .PREADY_o(in0.pready),
		  .PSLVERR_o(in0.pslverr));


	initial begin

		uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",in0);

		uvm_config_db#(virtual spi_if)::set(null,"*","spi_if",in1);

		run_test("");

	end

endmodule