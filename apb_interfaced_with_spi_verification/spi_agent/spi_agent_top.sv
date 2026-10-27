class spi_agent_top extends uvm_env;

	`uvm_component_utils(spi_agent_top)

	spi_agent agnth;

	function new(string name="spi_agent_top",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		agnth=spi_agent::type_id::create("agnth",this);

	endfunction

endclass
