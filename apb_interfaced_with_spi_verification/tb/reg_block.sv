class reg_block extends uvm_reg_block;

	`uvm_object_utils(reg_block)
	
	ctrl1 cr1;
	
	ctrl2 cr2;
	
	baud bd;
	
	status st;
	
	data dt;
	
	uvm_reg_map APB_map;
	
	function new(string name="reg_block");
	
		super.new(name,build_coverage(UVM_CVR_ADDR_MAP));
		
	endfunction
	
	virtual function void build();
	
		cr1=ctrl1::type_id::create("cr1");
		
		cr1.configure(this,null,"");
		
		cr1.build();
		
		cr1.add_hdl_path_slice("b4.SPI_cr1",0,8);
		
		cr2=ctrl2::type_id::create("cr2");
		
		cr2.configure(this,null,"");

		cr2.build();
		
		cr2.add_hdl_path_slice("b4.SPI_cr2",0,8);
		
		bd=baud::type_id::create("bd");
		
		bd.configure(this,null,"");
		
		bd.build();
		
		bd.add_hdl_path_slice("b4.SPI_br",0,8);
		
		st=status::type_id::create("st");
		
		st.configure(this,null,"");
		
		st.build();
		
		st.add_hdl_path_slice("b4.SPI_sr",0,8);
		
		dt=data::type_id::create("dt");
		
		dt.configure(this,null,"");
		
		dt.build();
		
		dt.add_hdl_path_slice("b4.SPI_dr",0,8);
		
		//-------------------------------------------
		
		APB_map=create_map("APB_map",'h0,4,UVM_LITTLE_ENDIAN);
		
		APB_map.add_reg(cr1,8'b00000000,"RW");
		
		APB_map.add_reg(cr2,8'b00000001,"RW");
		
		APB_map.add_reg(bd,8'b00000010,"RW");
		
		APB_map.add_reg(st,8'b00000011,"RO");
		
		APB_map.add_reg(dt,8'b00000101,"RW");
		
		
		
		add_hdl_path("top.dut","RTL");
		
		lock_model();
		
	endfunction
	
endclass
		
		