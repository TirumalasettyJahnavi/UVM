class apb_agent_top extends uvm_env;

	`uvm_component_utils(apb_agent_top)

	apb_agent agnth;

	function new(string name="apb_agent_top",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		agnth=apb_agent::type_id::create("agenth",this);

	endfunction

endclass