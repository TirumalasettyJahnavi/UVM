class ctrl1 extends uvm_reg;

	`uvm_object_utils(ctrl1)
	
	rand uvm_reg_field spie;
	
	rand uvm_reg_field spe;
	
	rand uvm_reg_field sptie;
	
	rand uvm_reg_field mstr;
	
	rand uvm_reg_field cpha;
	
	rand uvm_reg_field cpol;
	
	rand uvm_reg_field ssoe;
	
	rand uvm_reg_field lsbfe;
	
	function new(string name ="ctrl1");
	
		super.new(name,8,UVM_NO_COVERAGE);
		
	endfunction
	
	virtual function void build();
	
		spie=uvm_reg_field::type_id::create("spie");
		
		spe=uvm_reg_field::type_id::create("spe");		
		
		sptie=uvm_reg_field::type_id::create("sptie");	
		
		mstr=uvm_reg_field::type_id::create("mstr");	
		
		cpol=uvm_reg_field::type_id::create("cpol");	
				
		cpha=uvm_reg_field::type_id::create("cpha");		
		
		ssoe=uvm_reg_field::type_id::create("ssoe");			
				
		lsbfe=uvm_reg_field::type_id::create("lsbfe");		
		
		//reg_filed.configure(parent,size,lsb_position,permisiion(type of memory volatile or not),reset value,reset is applicable or not,rand mode is enabled or not,bit accessiblility)	
		
		spie.configure(this,1,7,"RW",0,1'b0,1,1,0);	
		
		spe.configure(this,1,6,"RW",0,1'b0,1,1,0);
		
		sptie.configure(this,1,5,"RW",0,1'b0,1,1,0);
		
		mstr.configure(this,1,4,"RW",0,1'b0,1,1,0);
		
		cpol.configure(this,1,3,"RW",0,1'b0,1,1,0);
		
		cpha.configure(this,1,2,"RW",0,1'b1,1,1,0);
		
		ssoe.configure(this,1,1,"RW",0,1'b0,1,1,0);
		
		lsbfe.configure(this,1,0,"RW",0,1'b0,1,1,0);		
		
	endfunction
	
endclass

class ctrl2 extends uvm_reg;

	`uvm_object_utils(ctrl2)

	uvm_reg_field reserved;
		
	uvm_reg_field reserved1;

	uvm_reg_field reserved2;
		
	rand uvm_reg_field modfen;
	
	rand uvm_reg_field bidiroe;
	
	uvm_reg_field reserved3;
	
	rand uvm_reg_field spiswai;
	
	rand uvm_reg_field spc0;
	
	function new(string name ="ctrl2");
	
		super.new(name,8,UVM_NO_COVERAGE);
		
	endfunction
	
	virtual function void build();
	
		reserved=uvm_reg_field::type_id::create("reserved");
		
		reserved1=uvm_reg_field::type_id::create("reserved1");		
		
		reserved2=uvm_reg_field::type_id::create("reserved2");	
		
		modfen=uvm_reg_field::type_id::create("modfen");	
		
		bidiroe=uvm_reg_field::type_id::create("bidiroe");	
				
		reserved3=uvm_reg_field::type_id::create("reserved3");		
		
		spiswai=uvm_reg_field::type_id::create("spiswai");			
				
		spc0=uvm_reg_field::type_id::create("spc0");		
		
		//reg_filed.configure(parent,size,lsb_position,permisiion(type of memory volatile or not),reset value,reset is applicable or not,rand mode is enabled or not,bit accessiblility)	
		
		reserved.configure(this,1,7,"RO",0,1'b0,1,0,0);	
		
		reserved1.configure(this,1,6,"RO",0,1'b0,1,0,0);
		
		reserved2.configure(this,1,5,"RO",0,1'b0,1,0,0);
		
		modfen.configure(this,1,4,"RW",0,1'b0,1,1,0);
		
		bidiroe.configure(this,1,3,"RW",0,1'b0,1,1,0);
		
		reserved3.configure(this,1,2,"RO",0,1'b0,1,0,0);
		
		spiswai.configure(this,1,1,"RW",0,1'b0,1,1,0);
		
		spc0.configure(this,1,0,"RW",0,1'b0,1,1,0);		
		
	endfunction
	
endclass
		
class baud extends uvm_reg;

	`uvm_object_utils(baud)

	uvm_reg_field reserved;
		
	rand uvm_reg_field sppr2;
		
	rand uvm_reg_field sppr1;
	
	rand uvm_reg_field sppr0;
	
	uvm_reg_field reserved1;
	
	rand uvm_reg_field spr2;
	
	rand uvm_reg_field spr1;
	
	rand uvm_reg_field spr0;	
	
	function new(string name ="baud");
	
		super.new(name,8,UVM_NO_COVERAGE);
		
	endfunction
	
	virtual function void build();
	
		reserved=uvm_reg_field::type_id::create("reserved");		
		
		sppr2=uvm_reg_field::type_id::create("sppr2");	
		
		sppr1=uvm_reg_field::type_id::create("sppr1");	
		
		sppr0=uvm_reg_field::type_id::create("sppr0");
		
		reserved1=uvm_reg_field::type_id::create("reserved1");	
				
		spr2=uvm_reg_field::type_id::create("spr2");		
		
		spr1=uvm_reg_field::type_id::create("spr1");			
				
		spr0=uvm_reg_field::type_id::create("spr0");		
		
		//reg_filed.configure(parent,size,lsb_position,permisiion(type of memory volatile or not),reset value,reset is applicable or not,rand mode is enabled or not,bit accessiblility)	
		
		reserved.configure(this,1,7,"RO",0,1'b0,1,0,0);	
		
		sppr2.configure(this,1,6,"RW",0,1'b0,1,1,0);
		
		sppr1.configure(this,1,5,"RW",0,1'b0,1,1,0);
		
		sppr0.configure(this,1,4,"RW",0,1'b0,1,1,0);
		
		reserved1.configure(this,1,3,"RO",0,1'b0,1,0,0);
		
		spr2.configure(this,1,2,"RW",0,1'b1,1,1,0);
		
		spr1.configure(this,1,1,"RW",0,1'b0,1,1,0);
		
		spr0.configure(this,1,0,"RW",0,1'b0,1,1,0);		
		
	endfunction
	
endclass		

class status extends uvm_reg;

	`uvm_object_utils(status)

	uvm_reg_field spif;
		
	uvm_reg_field reserved;
		
	uvm_reg_field sptef;
	
	uvm_reg_field modf ;
	
	uvm_reg_field reserved1;
	
	 uvm_reg_field reserved2;
	
	uvm_reg_field reserved3;
	
	uvm_reg_field reserved4;	
	
	function new(string name ="status");
	
		super.new(name,8,UVM_NO_COVERAGE);
		
	endfunction
	
	virtual function void build();
	
		spif=uvm_reg_field::type_id::create("spif");		
		
		reserved=uvm_reg_field::type_id::create("reserved");	
		
		sptef=uvm_reg_field::type_id::create("sptef");	
		
		modf=uvm_reg_field::type_id::create("modf");
		
		reserved1=uvm_reg_field::type_id::create("reserved1");	
				
		reserved2=uvm_reg_field::type_id::create("reserved2");		
		
		reserved3=uvm_reg_field::type_id::create("reserved3");			
				
		reserved4=uvm_reg_field::type_id::create("reserved4");		
		
		//reg_filed.configure(parent,size,lsb_position,permisiion(type of memory volatile or not),reset value,reset is applicable or not,rand mode is enabled or not,bit accessiblility)	
		
		spif.configure(this,1,7,"RO",0,1'b0,1,0,0);	
		
		reserved.configure(this,1,6,"RO",0,1'b0,1,0,0);
		
		sptef.configure(this,1,5,"RO",0,1'b1,1,0,0);
		
		modf.configure(this,1,4,"RO",0,1'b0,1,0,0);
		
		reserved1.configure(this,1,3,"RO",0,1'b0,1,0,0);
		
		reserved2.configure(this,1,2,"RO",0,1'b1,1,0,0);
		
		reserved3.configure(this,1,1,"RO",0,1'b0,1,0,0);
		
		reserved4.configure(this,1,0,"RO",0,1'b0,1,0,0);		
		
	endfunction
	
endclass
		
		
class data extends uvm_reg;

	`uvm_object_utils(data)

	rand uvm_reg_field data;
		
	rand uvm_reg_field data1;
		
	rand uvm_reg_field data2;
	
	rand uvm_reg_field data3 ;
	
	rand uvm_reg_field data4;
	
	rand uvm_reg_field data5;
	
	rand uvm_reg_field data6;
	
	rand uvm_reg_field data7;	
	
	function new(string name ="data");
	
		super.new(name,8,UVM_NO_COVERAGE);
		
	endfunction
	
	virtual function void build();
	
		data=uvm_reg_field::type_id::create("data");		
		
		data1=uvm_reg_field::type_id::create("data1");	
		
		data2=uvm_reg_field::type_id::create("data2");	
		
		data3=uvm_reg_field::type_id::create("data3");
		
		data4=uvm_reg_field::type_id::create("data4");	
				
		data5=uvm_reg_field::type_id::create("data5");		
		
		data6=uvm_reg_field::type_id::create("data6");			
				
		data7=uvm_reg_field::type_id::create("data7");		
		
		//reg_filed.configure(parent,size,lsb_position,permisiion(type of memory volatile or not),reset value,reset is applicable or not,rand mode is enabled or not,bit accessiblility)	
		
		data.configure(this,1,7,"RW",0,1'b0,1,1,0);	
		
		data1.configure(this,1,6,"RW",0,1'b0,1,1,0);
		
		data2.configure(this,1,5,"RW",0,1'b0,1,1,0);
		
		data3.configure(this,1,4,"RW",0,1'b0,1,1,0);
		
		data4.configure(this,1,3,"RW",0,1'b0,1,1,0);
		
		data5.configure(this,1,2,"RW",0,1'b0,1,1,0);
		
		data6.configure(this,1,1,"RW",0,1'b0,1,1,0);
		
		data7.configure(this,1,0,"RW",0,1'b0,1,1,0);		
		
	endfunction
	
endclass
	
		
		
		
		
				