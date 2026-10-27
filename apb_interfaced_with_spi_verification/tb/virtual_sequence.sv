class virtual_sequence extends uvm_sequence#(uvm_sequence_item);

	`uvm_object_utils(virtual_sequence)

	spi_sequencer spi_seqrh;

	apb_sequencer apb_seqrh;

	virtual_sequencer vseqrh;

	env_config m_cfg;

	function new(string name="virtual_sequence");

		super.new(name);

	endfunction

	task body();

		if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",m_cfg))

			`uvm_fatal(get_full_name(),"not getting env configuration from the test to virtual sequence class");

		if(!$cast(vseqrh,m_sequencer))

			`uvm_fatal(get_full_name(),"m_sequencer is not assigned to virtual sequencer");

		spi_seqrh=vseqrh.spi_seqrh;

		apb_seqrh=vseqrh.apb_seqrh;
	endtask

endclass

class sequence1 extends virtual_sequence;

	`uvm_object_utils(sequence1)

	cpol0_cpha0_lsb seq1;	
	
	miso_sequence seq_m;

	function new(string name="sequence1");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq1=cpol0_cpha0_lsb::type_id::create("seq1");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		
		
			fork 
			   begin
			seq1.start(apb_seqrh);
			end
			begin
			seq_m.start(spi_seqrh);
			end
		join		

	endtask

endclass

class sequence2 extends virtual_sequence;

	`uvm_object_utils(sequence2)

	cpol0_cpha1_lsb seq2;	
	
	miso_sequence seq_m;

	function new(string name="sequence2");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq2=cpol0_cpha1_lsb::type_id::create("seq2");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq2.start(apb_seqrh);

			seq_m.start(spi_seqrh);
			
		join

	endtask

endclass

class sequence3 extends virtual_sequence;

	`uvm_object_utils(sequence3)

	cpol1_cpha0_lsb seq3;	
	
	miso_sequence seq_m;

	function new(string name="sequence3");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq3=cpol1_cpha0_lsb::type_id::create("seq3");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq3.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence4 extends virtual_sequence;

	`uvm_object_utils(sequence4)

	cpol1_cpha1_lsb seq4;
	
	miso_sequence seq_m;	

	function new(string name="sequence4");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq4=cpol1_cpha1_lsb::type_id::create("seq4");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq4.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence5 extends virtual_sequence;

	`uvm_object_utils(sequence5)

	cpol0_cpha0_msb seq5;	
	
	miso_sequence seq_m;

	function new(string name="sequence5");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq5=cpol0_cpha0_msb::type_id::create("seq5");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq5.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence6 extends virtual_sequence;

	`uvm_object_utils(sequence6)

	cpol0_cpha1_msb seq6;
	
	miso_sequence seq_m;	

	function new(string name="sequence6");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq6=cpol0_cpha1_msb::type_id::create("seq6");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq6.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence7 extends virtual_sequence;

	`uvm_object_utils(sequence7)

	cpol1_cpha0_msb seq7;
	
	miso_sequence seq_m;	

	function new(string name="sequence7");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq7=cpol1_cpha0_msb::type_id::create("seq7");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq7.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence8 extends virtual_sequence;

	`uvm_object_utils(sequence8)

	cpol1_cpha1_msb seq8;
	
	miso_sequence seq_m;	

	function new(string name="sequence8");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq8=cpol1_cpha1_msb::type_id::create("seq8");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq8.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence9 extends virtual_sequence;

	`uvm_object_utils(sequence9)

	reset_n_seq seq9;
	
	miso_sequence seq_m;	

	function new(string name="sequence9");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq9=reset_n_seq::type_id::create("seq9");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq9.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass


class sequence10 extends virtual_sequence;

	`uvm_object_utils(sequence10)

	low_power_mode seq10;	
	
	miso_sequence seq_m;

	function new(string name="sequence10");

		super.new(name);

	endfunction

	task body();

		super.body();

		seq10=low_power_mode::type_id::create("seq10");
		
		seq_m=miso_sequence::type_id::create("seq_m");
		
		fork

			seq10.start(apb_seqrh);
			
			seq_m.start(spi_seqrh);

		join

	endtask

endclass
