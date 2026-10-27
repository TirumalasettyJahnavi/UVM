class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)

	apb_agent_config apb_cfg;

	
	virtual apb_if.apb_mon_mp vif;

	uvm_analysis_port#(apb_xtn) monitor_port;

	function new(string name="apb_monitor",uvm_component parent);

		super.new(name,parent);

		monitor_port=new("monitor_port",this);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))

			`uvm_fatal(get_full_name(),"didn't get the configuration of apb_agent_config");

	endfunction 

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);

		vif=apb_cfg.vif_apb;
	endfunction
	
	task run_phase(uvm_phase phase);

				
		`uvm_info(get_full_name(),"monitor block ",UVM_LOW);

		forever begin
		
			//@(posedge vif.apb_monitor_cb)

			collect_data();
			
			//monitor_port.write(xtn);
			
		end
			
			//`uvm_info(get_full_name(),"monitor block ",UVM_LOW);
			
		//	xtn.print();

	endtask

	task collect_data ();

	apb_xtn xtn;

	xtn=apb_xtn::type_id::create("xtn");

	
	@(vif.apb_monitor_cb)

		wait(vif.apb_monitor_cb.pready && vif.apb_monitor_cb.penable );

			xtn.psel=vif.apb_monitor_cb.psel;
		
			xtn.preset_n=vif.apb_monitor_cb.preset_n;

			xtn.penable=vif.apb_monitor_cb.penable;

			xtn.pwrite=vif.apb_monitor_cb.pwrite;
			
			xtn.paddr=vif.apb_monitor_cb.paddr;
			
			xtn.pready=vif.apb_monitor_cb.pready;

			xtn.pslverr=vif.apb_monitor_cb.pslverr;

									
			if(vif.apb_monitor_cb.pwrite)
			
				xtn.pwdata=vif.apb_monitor_cb.pwdata;

			else

				xtn.prdata=vif.apb_monitor_cb.prdata;

			//`uvm_info(get_full_name(),"monitor block ",UVM_LOW);
			
			@(vif.apb_monitor_cb)
			
			`uvm_info(get_type_name(),$sformatf("IN apb MONITOR \n%0s",xtn.sprint()),UVM_LOW)
			
			//xtn.print();

		monitor_port.write(xtn);
			
	endtask


endclass