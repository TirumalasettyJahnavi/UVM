class apb_driver extends uvm_driver#(apb_xtn);

	`uvm_component_utils(apb_driver)

	apb_agent_config apb_cfg;

	virtual apb_if.apb_drv_mp vif;

	function new(string name="apb_driver",uvm_component parent);
		
		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);

		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))

			`uvm_fatal(get_full_name(),"didint get the configuration");

	endfunction

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);

		vif=apb_cfg.vif_apb;

	endfunction

	task reset();

		@(vif.apb_driver_cb)

			vif.apb_driver_cb.preset_n<=1'b0;

		@(vif.apb_driver_cb)
		
			vif.apb_driver_cb.preset_n<=1'b1;

	endtask

	task run_phase(uvm_phase phase);

	reset();

	forever

		begin
		
		//phase.raise_objection(this);

		seq_item_port.get_next_item(req);
		
		//reset();

		send_to_dut(req);
		
		//req.print();

		seq_item_port.item_done();
		
		//`uvm_info(get_full_name(),"driver ",UVM_LOW);
		
	//	req.print();
		
		//phase.drop_objection(this);
		end
		
	endtask

	task send_to_dut(apb_xtn xtn);
	
		@(vif.apb_driver_cb)
		
	/*	vif.apb_driver_cb.preset_n<=xtn.preset_n;

		vif.apb_driver_cb.paddr<=xtn.paddr;

		vif.apb_driver_cb.pwrite<=xtn.pwrite;*/

		vif.apb_driver_cb.psel<=1'b1;

		vif.apb_driver_cb.penable<=1'b0;
		vif.apb_driver_cb.preset_n<=xtn.preset_n;

		vif.apb_driver_cb.paddr<=xtn.paddr;

		vif.apb_driver_cb.pwrite<=xtn.pwrite;


	//	vif.apb_driver_cb.psel<=1'b0;

	//	vif.apb_driver_cb.penable<=1'b1;


		if(xtn.pwrite)

			vif.apb_driver_cb.pwdata<=xtn.pwdata;

		@(vif.apb_driver_cb)

			vif.apb_driver_cb.penable<=1'b1;

		wait(vif.apb_driver_cb.pready)

			@(vif.apb_driver_cb)

				if(xtn.pwrite==0)

					xtn.prdata=vif.apb_driver_cb.prdata;

				vif.apb_driver_cb.psel<=1'b0;

				vif.apb_driver_cb.penable<=1'b0;
				
			//@(vif.apb_driver_cb);
				
	`uvm_info(get_type_name(),$sformatf("IN apb driver \n%0s",xtn.sprint()),UVM_LOW)

	endtask

//	function void report_phase(uvm_phase phase);
	
	//	req.print();
		
//	endfunction
				
endclass

