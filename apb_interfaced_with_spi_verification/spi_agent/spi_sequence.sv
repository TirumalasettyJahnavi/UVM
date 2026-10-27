class spi_sequence extends uvm_sequence#(spi_xtn);

	`uvm_object_utils(spi_sequence)

	function new(string name="spi_sequence");

		super.new(name);

	endfunction

//	function void build_phase(uvm_phase phase);

//		super.build_phase(phase);

//	endfunction

endclass

class miso_sequence extends spi_sequence;

	`uvm_object_utils(miso_sequence)

	function new (string name="miso_sequence");

		super.new(name);
	
	endfunction

	task body();

		begin
		
		//$display("********************sequence*******************************");

		req=spi_xtn::type_id::create("req");
		
		start_item(req);
		
		assert(req.randomize());
		
		//req.print();
		//assert(req.randomize()with {miso==8'b11111111;});
		
		finish_item(req);
		
		//req.print();
		
		end
		
	endtask

endclass

	