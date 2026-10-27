class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo #(spi_xtn) spi_mon;
	
	uvm_tlm_analysis_fifo #(apb_xtn) apb_mon;
	
	apb_xtn xtn_apb;
	
	spi_xtn xtn_spi;

	apb_xtn apb_cov;
	
	spi_xtn spi_cov;
	
	env_config m_cfg;
	
	reg_block reg_model;
	
	uvm_status_e status_e;
	
	bit [7:0] ctrl1;
	
	bit [7:0] ctrl2;
	
	bit [7:0] status;
	
	bit [7:0] baud; 
	
	bit [7:0] data;
	
covergroup apb_coverage;

	option.per_instance=1;
	
	SEL     :coverpoint apb_cov.psel {bins sel = {0,1};}
	
	PRESET_N:coverpoint apb_cov.preset_n {bins preset_n = {0,1};}
	
	PWRITE  :coverpoint apb_cov.pwrite {bins pwrite = {0,1};}
	
	PENABLE :coverpoint apb_cov.penable {bins penable ={ 0,1};}
	
	PWDATA  :coverpoint apb_cov.pwdata {bins pwadata = {[8'h00 : 8'hff]};}
	
	PRDATA  :coverpoint apb_cov.prdata {bins prdata = {[8'h00 : 8'hff]};}
	
	PADDR   :coverpoint apb_cov.paddr {bins paddr = {[ 3'b000 : 3'b111]};}
	
	PREADY  : coverpoint apb_cov.pready {bins pready = {0,1};}
	
	SEL_ENABLE :cross SEL,PENABLE;
	
	SEL_ENABLE_PREADY: cross SEL,PENABLE,PREADY;

endgroup

covergroup spi_coverage;

	option.per_instance=1;

	MISO  :coverpoint spi_cov.miso {bins miso = {[8'h00 : 8'hff]};}
	
	MOSI  :coverpoint spi_cov.mosi {bins mosi = {[8'h00 : 8'hff]};}
	
	SS    :coverpoint spi_cov.ss   {bins ss = {0,1};}
	
endgroup

	function new(string name="scoreboard",uvm_component parent);

		super.new(name,parent);
		
		spi_mon=new("spi_mon",this);
		
		apb_mon=new("apb_mon",this);
		
		apb_coverage=new();
		
		spi_coverage=new();

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		
			`uvm_fatal(get_type_name(),"didnt get config in scoreboard")
			
		reg_model=m_cfg.reg_model;

	endfunction
	
	task run_phase(uvm_phase phase);
	
	//phase.raise_objection(this);
	
	fork
	
		begin
		
			forever
			
				begin 
				
					apb_mon.get(xtn_apb);
					
					`uvm_info(get_full_name(),$sformatf("in scoreboard \n%s",xtn_apb.sprint()),UVM_LOW)
					
					apb_cov=xtn_apb;
					
					apb_coverage.sample();
					
					ral();
					
					compare_data();
					
				end
				
		end
		
		begin
		
			forever
			
				begin
				
					spi_mon.get(xtn_spi);
					
					`uvm_info(get_full_name(),"in scoreboard spi",UVM_LOW)
					
					xtn_spi.print();
					
					spi_cov=xtn_spi;
					
					spi_coverage.sample();
					
					ral();
					
					compare_data();
					
				end
				
		end
		
	join
	
	//phase.drop_objection(this);
	
endtask

task compare_data();

	wait(xtn_apb !=null)
	
	wait(xtn_spi !=null)
	begin
	if(xtn_apb.pwrite && (xtn_apb.paddr==3'b101))
	
	//$display("");
	
	begin
	
		if(xtn_apb.pwdata==xtn_spi.mosi)
		
			`uvm_info(get_full_name(),"COMPARISSION btw pwdata and mosi SUCCESSFULL",UVM_LOW)
			
		else
		
			`uvm_info(get_full_name(),"COMPARISSION btw pwdata and mosi NOT SUCCESSFULL",UVM_LOW)
			
	end
	
//else 

//	`uvm_fatal(get_full_name(),"not entered into pwrite=1")


	if(!xtn_apb.pwrite && xtn_apb.paddr==3'b101)
	
	begin
		//wait(xtn_spi !=null)
		if(xtn_apb.prdata == xtn_spi.miso)
		
			`uvm_info(get_full_name(),"COMPARISSION btw prdata and miso is SUCCESSFULL",UVM_LOW)
			
		else
		
			`uvm_info(get_full_name(),"COmparission  btw prdata and miso is not successfull",UVM_LOW)
			
	end
end

if(xtn_apb.pwrite && xtn_apb.paddr==3'b000)

	begin
	
		if(xtn_apb.pwdata==ctrl1)
		
		begin
		
			`uvm_info(get_type_name(),"==========CR1 COMPARISION SUCCESSFULL===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("CR1 DATA = %b apb_xtn %0b",ctrl1,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		else 
		
		begin
		
			`uvm_info(get_type_name(),"==========CR1 COMPARISION FAILED===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("CR1 DATA = %b apb_xtn %0b",ctrl1,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		
	end
	
if(xtn_apb.pwrite && xtn_apb.paddr==3'b001)

	begin
	
		if(xtn_apb.pwdata==ctrl2)
		
		begin
		
			`uvm_info(get_type_name(),"==========CR2 COMPARISION SUCCESSFULL===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("CR2 DATA = %b apb_xtn %0b",ctrl2,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		else 
		
		begin
		
			`uvm_info(get_type_name(),"==========CR2 COMPARISION FAILED===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("CR2 DATA = %b apb_xtn %0b",ctrl2,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		
	end

if(xtn_apb.pwrite && xtn_apb.paddr==3'b010)

	begin
	
		if(xtn_apb.pwdata==baud)
		
		begin
		
			`uvm_info(get_type_name(),"==========baud COMPARISION SUCCESSFULL===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("baud DATA = %b apb_xtn %0b",baud,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		else 
		
		begin
		
			`uvm_info(get_type_name(),"==========baud COMPARISION FAILED===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("baud DATA = %b apb_xtn %0b",baud,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		
	end
	
if(xtn_apb.pwrite && xtn_apb.paddr==3'b011)

	begin
	
		if(xtn_apb.pwdata==status)
		
		begin
		
			`uvm_info(get_type_name(),"==========status COMPARISION SUCCESSFULL===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("status DATA = %b apb_xtn %0b",status,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		else 
		
		begin
		
			`uvm_info(get_type_name(),"==========status COMPARISION FAILED===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("status DATA = %b apb_xtn %0b",status,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		
	end
	
if(xtn_apb.pwrite && xtn_apb.paddr==3'b101)

	begin
	
		if(xtn_apb.pwdata==data)
		
		begin
		
			`uvm_info(get_type_name(),"==========data COMPARISION SUCCESSFULL===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("data DATA = %b apb_xtn %0b",data,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		else 
		
		begin
		
			`uvm_info(get_type_name(),"==========data COMPARISION FAILED===========",UVM_LOW)
			
			`uvm_info(get_type_name(),$sformatf("data DATA = %b apb_xtn %0b",data,xtn_apb.pwdata),UVM_LOW)
			
		end
		
		
	end
	
	
	
endtask

task ral();

	reg_model.cr1.read(status_e,ctrl1,UVM_BACKDOOR,.map(reg_model.APB_map));
	
	`uvm_info(get_type_name(),$sformatf("CTRL1 %b",ctrl1),UVM_LOW)
	
	reg_model.cr2.read(status,ctrl2,UVM_BACKDOOR,.map(reg_model.APB_map));
	
	`uvm_info(get_type_name(),$sformatf("CTRL2 %b",ctrl2),UVM_LOW)
	
	reg_model.bd.read(status,baud,UVM_BACKDOOR,.map(reg_model.APB_map));
	
	`uvm_info(get_type_name(),$sformatf("baud %b",baud),UVM_LOW)
	
	reg_model.st.read(status,status,UVM_BACKDOOR,.map(reg_model.APB_map));
	
	`uvm_info(get_type_name(),$sformatf("status %b",status),UVM_LOW)
	
	reg_model.dt.read(status,data,UVM_BACKDOOR,.map(reg_model.APB_map));
	
	`uvm_info(get_type_name(),$sformatf("data %b",data),UVM_LOW)
	

endtask
endclass






















