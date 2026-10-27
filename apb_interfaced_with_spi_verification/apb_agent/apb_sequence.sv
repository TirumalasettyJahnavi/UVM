class apb_sequence extends uvm_sequence#(apb_xtn);

	`uvm_object_utils(apb_sequence)

	function new(string name="apb_sequence");

		super.new(name);

	endfunction

endclass

class cpol0_cpha0_lsb extends apb_sequence;

	`uvm_object_utils(cpol0_cpha0_lsb)

	function new(string name="cpol0_cpha0_lsb");

		super.new(name);

	endfunction

	task body();
	
	begin

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00010001;});
		
		//req.print();

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		//req.print();

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		//req.print();

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		//req.print();

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;});
		
		finish_item(req);
		
		end

	endtask

endclass

class cpol0_cpha1_lsb extends apb_sequence;

	`uvm_object_utils(cpol0_cpha1_lsb)

	function new(string name="cpol0_cpha1_lsb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00010101;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;});
		
		finish_item(req);

	endtask

endclass

class cpol1_cpha0_lsb extends apb_sequence;

	`uvm_object_utils(cpol1_cpha0_lsb)

	function new(string name="cpol1_cpha0_lsb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00011001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		#1000;

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;});
		
		finish_item(req);

	endtask

endclass

class cpol1_cpha1_lsb extends apb_sequence;

	`uvm_object_utils(cpol1_cpha1_lsb)

	function new(string name="cpol1_cpha1_lsb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00011101;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass

class cpol0_cpha0_msb extends apb_sequence;

	`uvm_object_utils(cpol0_cpha0_msb)

	function new(string name="cpol0_cpha0_msb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00010000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass
	
class cpol0_cpha1_msb extends apb_sequence;

	`uvm_object_utils(cpol0_cpha1_msb)

	function new(string name="cpol0_cpha1_msb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00010100;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass

class cpol1_cpha0_msb extends apb_sequence;

	`uvm_object_utils(cpol1_cpha0_msb)

	function new(string name="cpol1_cpha0_msb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00011001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass

class cpol1_cpha1_msb extends apb_sequence;

	`uvm_object_utils(cpol1_cpha1_msb)

	function new(string name="cpol1_cpha1_msb");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00011101;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000000;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass


class reset_n_seq extends apb_sequence;

	`uvm_object_utils(reset_n_seq)

	function new(string name="reset_n_seq");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b0;});

		finish_item(req);
		
	endtask

endclass


class low_power_mode extends apb_sequence;

	`uvm_object_utils(low_power_mode)

	function new(string name="low_power_mode");

		super.new(name);

	endfunction

	task body();

		req=apb_xtn::type_id::create("req");

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b000; pwrite==1; pwdata==8'b00011101;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b001; pwrite==1; pwdata==8'b00000010;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b010; pwrite==1; pwdata==8'b00010001;});

		finish_item(req);

		start_item(req);		

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101; pwrite==1; pwdata==8'b11111111;});

		finish_item(req);

		start_item(req);

		assert(req.randomize() with {preset_n==1'b1;paddr==3'b101;pwrite==0;pwdata==8'b11111111;});
		
		finish_item(req);

	endtask

endclass

