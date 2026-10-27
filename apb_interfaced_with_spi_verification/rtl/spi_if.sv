interface spi_if(input bit clock);

	logic miso;

	logic mosi;

	logic sclk;

	logic ss;

	logic spi_interrupt_request;

	clocking spi_drv_cb @(posedge clock);

		default input #1 output #0;

		output miso;

		input ss;

		input sclk;

	endclocking

	clocking spi_mon_cb @(posedge clock);

		default input #1 output #0;

		input sclk;

		input ss;

		input mosi;

		input miso;

		input spi_interrupt_request;

	endclocking

	modport spi_drv_mp (clocking spi_drv_cb);

	modport spi_mon_mp (clocking spi_mon_cb);

endinterface

		