class virtual_sequencer extends uvm_sequencer;

	`uvm_component_utils(virtual_sequencer)

	apb_sequencer apb_seqrh;

	spi_sequencer spi_seqrh;

	function new(string name="virtual_sequencer",uvm_component parent);

		super.new(name,parent);
	
	endfunction
	
	function void build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		
	endfunction

endclass