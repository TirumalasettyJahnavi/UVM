class test extends uvm_test;
	
	`uvm_component_utils(test)

	env envh;
	
	env_config m_cfg;
	
	apb_agent_config apb_cfg;
	
	spi_agent_config spi_cfg;

	virtual_sequence v_seq;
	
	reg_block reg_model;
	
	//int no_of_duts=1;

//	virtual apb_if vif_apb;

//	virtual spi_if vif_spi;
	
	int has_apb_agent=1;
	
	int has_spi_agent=1;
	
		bit [7:0] ctrl = 8'b00010001;

	function new(string name="test",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);
		
		m_cfg=env_config::type_id::create("m_cfg");
		
		reg_model=reg_block::type_id::create("reg_model");
		
		reg_model.build();
		
		m_cfg.reg_model=this.reg_model;
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

		if(has_apb_agent)

			begin
				
				apb_cfg=apb_agent_config::type_id::create("apb_cfg");

				if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_cfg.vif_apb))
			
					`uvm_fatal(get_full_name(),"apb_cfg is not getting.Did you set it?");

				apb_cfg.is_active=UVM_ACTIVE;

			//	$cast(m_cfg.apb_cfg,apb_cfg);

				m_cfg.apb_cfg=apb_cfg;

				
			
			end

		if(has_spi_agent)

			begin

				spi_cfg=spi_agent_config::type_id::create("api_cfg");
	
				if(!uvm_config_db#(virtual spi_if)::get(this,"","spi_if",spi_cfg.vif_spi))
		
					`uvm_fatal(get_full_name(),"spi_cfg is not getting .Did you set it?");

				spi_cfg.is_active=UVM_ACTIVE;

			//	$cast(m_cfg.spi_cfg,spi_cfg);

				m_cfg.spi_cfg=spi_cfg;

			end

		m_cfg.has_apb_agent=has_apb_agent;

		m_cfg.has_spi_agent=has_spi_agent;
		
		uvm_config_db#(env_config)::set(this,"*","env_config",m_cfg);

		super.build_phase(phase);

		envh=env::type_id::create("envh",this);

	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
	
		uvm_top.print_topology();
	
	endfunction
	


/*	function void report_phase(uvm_phase phase);
	
		uvm_top.print_topology();
	
	endfunction */

endclass


class test1 extends test;

	`uvm_component_utils(test1)

	sequence1 seq1;

		bit [7:0] ctrl = 8'b00010001;


	function new(string name="test1",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);


	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq1=sequence1::type_id::create("seq1");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq1.start(envh.vseqrh);

		#1000;

		phase.drop_objection(this);

	endtask

endclass

class test2 extends test; 

	`uvm_component_utils(test2)

	sequence2 seq2;

		bit [7:0] ctrl=8'b00010101;	

	function new(string name="test2",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

			uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);		

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq2=sequence2::type_id::create("seq2");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq2.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test3 extends test; 

	`uvm_component_utils(test3)

	sequence3 seq3;
	
	bit [7:0] ctrl=8'b00011001;	

	function new(string name="test3",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq3=sequence3::type_id::create("seq3");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq3.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass


class test4 extends test; 

	`uvm_component_utils(test4)

	sequence4 seq4;
	
	bit [7:0] ctrl=8'b00011101;	

	function new(string name="test4",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq4=sequence4::type_id::create("seq4");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq4.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test5 extends test; 

	`uvm_component_utils(test5)

	sequence5 seq5;
	
	bit [7:0] ctrl=8'b00010000;	

	function new(string name="test5",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq5=sequence5::type_id::create("seq5");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq5.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test6 extends test; 

	`uvm_component_utils(test6)

	sequence6 seq6;
	
	bit [7:0] ctrl=8'b00010100;	

	function new(string name="test6",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq6=sequence6::type_id::create("seq6");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq6.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test7 extends test; 

	`uvm_component_utils(test7)

	sequence7 seq7;
	
	bit [7:0] ctrl=8'b00011001;	

	function new(string name="test7",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq7=sequence7::type_id::create("seq7");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq7.start(envh.vseqrh);
		
		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test8 extends test; 

	`uvm_component_utils(test8)

	sequence8 seq8;
	
	bit [7:0] ctrl=8'b00011101;	

	function new(string name="test8",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq8=sequence8::type_id::create("seq8");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq8.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass

class test9 extends test; 

	`uvm_component_utils(test9)

	sequence9 seq9;
	
	bit [7:0] ctrl=8'b00011101;	

	function new(string name="test9",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq9=sequence9::type_id::create("seq9");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq9.start(envh.vseqrh);

		#1000;		

		phase.drop_objection(this);

	endtask

endclass


class test10 extends test; 

	`uvm_component_utils(test10)

	sequence10 seq10;
	
	bit [7:0] ctrl=8'b00011101;	

	function new(string name="test10",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
		
		uvm_config_db #(bit [7:0])::set(this,"*","bit [7:0]" ,ctrl);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);
		
		seq10=sequence10::type_id::create("seq10");

	//	seq1.start(envh.apb_agt_top.agnth.seqrh);

		seq10.start(envh.vseqrh);

		#1000;			

		phase.drop_objection(this);

	endtask

endclass