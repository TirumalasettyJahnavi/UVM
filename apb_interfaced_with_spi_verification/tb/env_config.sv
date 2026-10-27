class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	uvm_active_passive_enum is_active;
	
	bit no_of_duts;
	
	bit has_apb_agent=1;
	
	bit has_spi_agent=1;
	
	bit is_scoreboard=1;
	
	apb_agent_config apb_cfg;
	
	spi_agent_config spi_cfg;
	
	bit has_functional_coverage;
	
	bit has_virtual_sequencer=1;
	
	reg_block reg_model;
	
	function new(string name ="env_config" );
	
		super.new(name);
		
	endfunction
	
endclass