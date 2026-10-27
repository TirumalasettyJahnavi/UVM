class apb_agent extends uvm_agent;

	`uvm_component_utils(apb_agent)

	apb_driver drvh;

	apb_monitor monh;

	apb_sequencer seqrh;

	apb_agent_config apb_cfg;

	function new(string name="apb_agent",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))

			`uvm_fatal(get_full_name(),"apb configuration is not getting");

		if(apb_cfg.is_active==UVM_ACTIVE)

		begin

			drvh=apb_driver::type_id::create("drvh",this);

			seqrh=apb_sequencer::type_id::create("seqrh",this);

		end

		monh=apb_monitor::type_id::create("monh",this);


	endfunction

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);

		if(apb_cfg.is_active==UVM_ACTIVE)

			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction

endclass