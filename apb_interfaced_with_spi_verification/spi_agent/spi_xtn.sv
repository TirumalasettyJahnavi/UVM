class spi_xtn extends uvm_sequence_item;

	`uvm_object_utils(spi_xtn)

	function new(string name="spi_xtn");

		super.new(name);

	endfunction

	rand logic [7:0]miso;

	bit[7:0] mosi;

	bit ss;

	bit spi_interrupt_request;
	
	

	function void do_print(uvm_printer printer);

	super.do_print(printer);

		printer.print_field("MISO",this.miso,8,UVM_BIN);

		printer.print_field("MOSI",this.mosi,8,UVM_BIN);

		printer.print_field("SS",this.ss,1,UVM_BIN);

		printer.print_field("SPI_INTERRUPT_REQUEST",this.spi_interrupt_request,1,UVM_BIN);

	endfunction

endclass
