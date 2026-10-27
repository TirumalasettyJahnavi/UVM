class env extends uvm_env;
	
	`uvm_component_utils(env)

	spi_agent_top spi_agt_top;

	apb_agent_top apb_agt_top;

	virtual_sequencer vseqrh;
	
	env_config m_cfg;
	
	scoreboard sb;

	function new(string name="env",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))

			`uvm_fatal(get_full_name(),"didn't get configuration from the test");

		if(m_cfg.has_apb_agent)

			begin

				uvm_config_db#(apb_agent_config)::set(this,"*","apb_agent_config",m_cfg.apb_cfg);

				apb_agt_top=apb_agent_top::type_id::create("apb_agt_top",this);

			end

		if(m_cfg.has_spi_agent)

			begin

				uvm_config_db#(spi_agent_config)::set(this,"*","spi_agent_config",m_cfg.spi_cfg);

				spi_agt_top=spi_agent_top::type_id::create("api_agt_top",this);

			end	

		//spi_agt_top=spi_agent_top::type_id::create("spi_agt_top",this);

		//apb_agt_top=apb_agent_top::type_id::create("apb_agt_top",this);

		if(m_cfg.has_virtual_sequencer)

			vseqrh=virtual_sequencer::type_id::create("vseqrh",this);
			
		if(m_cfg.is_scoreboard)
		
			sb=scoreboard::type_id::create("sb",this);
		
		

	endfunction

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);
		
		if(m_cfg.has_apb_agent)

			vseqrh.apb_seqrh=apb_agt_top.agnth.seqrh;
		
		if(m_cfg.has_spi_agent)

			vseqrh.spi_seqrh=spi_agt_top.agnth.seqrh;
		
		if(m_cfg.is_scoreboard)
		
		
			apb_agt_top.agnth.monh.monitor_port.connect(sb.apb_mon.analysis_export);
			
			spi_agt_top.agnth.monh.mon_port.connect(sb.spi_mon.analysis_export);
			

	endfunction
	
endclass




