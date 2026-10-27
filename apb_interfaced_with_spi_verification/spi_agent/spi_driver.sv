class spi_driver extends uvm_driver#(spi_xtn);

	`uvm_component_utils(spi_driver)

	virtual spi_if.spi_drv_mp vif;

	spi_agent_config spi_cfg;

	logic [7:0]ctrl;

	logic cpol,cpha,lsb;

	function new(string name="spi_driver",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_cfg))
		
			`uvm_fatal(get_full_name(),"config in class spi_driver is not done")

		if(!uvm_config_db#(bit[7:0])::get(this,"","bit [7:0]",ctrl))

			`uvm_fatal(get_full_name(),"ctrl bit not getting in driver ")

	//	$display("**************************8in build_phase of spi");

	endfunction

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);

		vif=spi_cfg.vif_spi;

	endfunction

	task run_phase(uvm_phase phase);

//	$display("****************************");


		forever

			begin

		//	phase.raise_objection(this);

		//	$display("****************************");

			seq_item_port.get_next_item(req);

		//	$display("****************************");

			send_to_dut(req);

			seq_item_port.item_done();

		//	req.print();

		//	phase.drop_objection(this);

			end

	endtask

	task send_to_dut(spi_xtn xtn);

		//$display("****************************");


	//	xtn.print();

		cpol = ctrl[3];

		cpha = ctrl[2];

		lsb = ctrl[0];
		
		

	//	$display("s value is ",xtn.ss);

		wait(!vif.spi_drv_cb.ss)

			@(vif.spi_drv_cb);

				if(!cpha)

					vif.spi_drv_cb.miso <= xtn.miso[lsb?0:7];

				for(int i=(cpha?0:1);i<8;i++)

				begin

					if(cpha ^ cpol)

						@(posedge vif.spi_drv_cb.sclk);

					else

						@(negedge vif.spi_drv_cb.sclk);

					vif.spi_drv_cb.miso <=xtn.miso[lsb?i:(7-i)];
					
					//$display("in spi driver miso bit %d",xtn.miso[lsb?i:(7-i)]);

				end

				`uvm_info(get_type_name() , $sformatf("IN SPI DRIVER\n %s",xtn.sprint()) , UVM_LOW);
				//xtn.print();
				@(vif.spi_drv_cb);
				

		endtask	

endclass
