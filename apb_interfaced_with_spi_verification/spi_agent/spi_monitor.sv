class spi_monitor extends uvm_monitor;
	
	`uvm_component_utils(spi_monitor)
	
	logic [7:0]ctrl;
	
	logic cpol;
	
	logic cpha ;
	 
	logic lsb;
	
	virtual spi_if.spi_mon_mp vif;
	
	spi_agent_config spi_cfg;
	
	uvm_analysis_port #(spi_xtn) mon_port;

	function new(string name="spi_monitor",uvm_component parent);

		super.new(name,parent);
		
		mon_port=new("mon_port",this);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		if(!uvm_config_db#(bit [7:0])::get(this,"","bit [7:0]",ctrl))
		
			`uvm_fatal(get_full_name(),"didnt get the ctrl value in spi_moitor")
			
		if(!uvm_config_db#(spi_agent_config)::get(this,"","spi_agent_config",spi_cfg))
		
			`uvm_fatal(get_full_name(),"didnt get the  configuration in spi monitor class")
			
	endfunction
	
	function void connect_phase(uvm_phase phase);
	
		super.connect_phase(phase);
		
		vif=spi_cfg.vif_spi;
		
	endfunction
	
	task run_phase(uvm_phase phase);
	
		forever

			begin

			@(negedge vif.spi_mon_cb.ss)

			//phase.raise_objection(this);
		
			collect_data();
			
			//phase.drop_objection(this);

			end

	endtask
	
	task  collect_data();
	
		spi_xtn xtn;
		
		int bit_idx;
		
		xtn=spi_xtn::type_id::create("xtn");
		
		lsb=ctrl[0];
		
		cpol=ctrl[3];
		
		cpha=ctrl[2];
		
		@(vif.spi_mon_cb)
		
			wait(!vif.spi_mon_cb.ss);
			
			for(int i=0; i<8;i++)
			
			begin
			
				bit_idx=lsb?i:(7-i);
				
				if(cpha ^ cpol)
				
					@(negedge vif.spi_mon_cb.sclk);
					
				else 
				
					@(posedge vif.spi_mon_cb.sclk);
					
				xtn.miso[bit_idx]=vif.spi_mon_cb.miso;
				
				xtn.mosi[bit_idx]=vif.spi_mon_cb.mosi;
				
				xtn.ss=vif.spi_mon_cb.ss;
				
			end
			
	//	xtn.print();
	
		mon_port.write(xtn);

			@(vif.spi_mon_cb)

				`uvm_info(get_type_name(),$sformatf("IN SPI MONITOR \n%0s",xtn.sprint()),UVM_LOW)

endtask

endclass
