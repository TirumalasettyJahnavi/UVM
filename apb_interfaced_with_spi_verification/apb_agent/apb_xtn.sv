class apb_xtn extends uvm_sequence_item;

	`uvm_object_utils(apb_xtn)

	function new(string name="apb_xtn");

		super.new(name);
	
	endfunction
	
	rand bit psel;

	rand bit preset_n;

	rand bit pwrite;

	rand bit penable;

	rand bit [7:0] pwdata;

	rand bit [2:0]paddr;

	bit pready;

	bit pslverr;

	bit [7:0]prdata;

	constraint PAADR_CON {if(pwrite==0)
		
					paddr inside {[0:3],5};

				else 

					paddr inside {0,1,2,5};

				}

	function void do_print(uvm_printer printer);

		super.do_print(printer);

		printer.print_field("PSEL",this.psel,1,UVM_BIN);

		printer.print_field("PRESET",this.preset_n,1,UVM_BIN);

		printer.print_field("PENABLE",this.penable,1,UVM_BIN);

		printer.print_field("PWDATA",this.pwdata,8,UVM_BIN);

		printer.print_field("PADDR",this.paddr,3,UVM_BIN);

		printer.print_field("PSLVERR",this.pslverr,1,UVM_BIN);

		printer.print_field("PRDATA",this.prdata,8,UVM_BIN);

		printer.print_field("PREADY",this.pready,1,UVM_BIN);

		printer.print_field("PWRITE",this.pwrite,1,UVM_BIN);

	endfunction

endclass
		
		
		
		


		