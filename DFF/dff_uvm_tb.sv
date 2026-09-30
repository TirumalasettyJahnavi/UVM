`include "uvm_macros.svh"
import uvm_pkg::*;

//-----------------------------------sequence_item_class--------------------------------

class dff_xtn extends uvm_sequence_item;
  //factory registration
  `uvm_object_utils(dff_xtn)
  //properties
  rand bit d_in;
  bit rst;
  
  bit d_out;
  //constructor new
  function new(string name="dff_xtn");
    super.new(name);
  endfunction
  
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    printer.print_field("rst",this.rst,1,UVM_BIN);
    
    printer.print_field("d_in",this.d_in,1,UVM_BIN);
    
    printer.print_field("d_out",this.d_out,1,UVM_BIN);
    
  endfunction
    
endclass  

//-------------------------------sequence_class--------------------------------------------

class dff_seq extends uvm_sequence#(dff_xtn);
  //sequence is parameterised with uvm_sequence_item
  `uvm_object_utils(dff_seq)
  //constructor
  function new(string name="dff_seq");
    super.new(name);
  endfunction
  //task body to send the randomized data to the driver
  virtual task body();
    dff_xtn xtn;
    repeat(10)
      begin
    //creating instance for randomising the data
  		  xtn=dff_xtn::type_id::create("xtn");
        //strting the sequence and sending 
   		  start_item(xtn);
    //randomizing the data
  		  assert(xtn.randomize())
            
           // xtn.print();
            
            `uvm_info(get_type_name() , $sformatf("IN sequence\n %s",xtn.sprint()) , UVM_LOW);
            
   			//`uvm_info(get_type_name(),"randomized the data in seq body",UVM_LOW);
   		  //else
     		//`uvm_info(get_type_name(),"not randomized the data in seq task body",UVM_LOW);
      
   		  finish_item(xtn);
  	  end
    
    //printing the data
   // `uvm_info("sequence_class",$sformatf("sequence data_in is %0d d_out is %0d",xtn.d_in,xtn.d_out),UVM_LOW);
    
  endtask
endclass

//------------------------------------sequencer-------------------------------------------

class dff_seqr extends uvm_sequencer#(dff_xtn);
  `uvm_component_utils(dff_seqr)
  function new(string name="dff_seqr",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

//---------------------------------dff_configuration-------------------------------------

class dff_config extends uvm_object;
  `uvm_object_utils(dff_config)
  virtual dff_if vif;
  
  uvm_active_passive_enum is_active=UVM_ACTIVE;
  
  function new(string name="dff_config");
    super.new(name);
  endfunction
endclass

//------------------------------------driver_class----------------------------------------

class dff_drv extends uvm_driver#(dff_xtn);
  `uvm_component_utils(dff_drv)
  //virtual interface handle
  virtual dff_if.drv_mp vif;
  dff_config d_cfg;
  //getting the virtual interface from uvm_config_db built_in database in uvm 
  function new(string name="dff_drv",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(dff_config)::get(this,"","dff_config",d_cfg))
      `uvm_fatal(get_type_name(),"didnt get configaration to driver");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif=d_cfg.vif;
  endfunction
  //task run_phase to get the data randomized from the sequence
  
  task run_phase(uvm_phase phase);
   // super.run_phase(phase);
    dff_xtn xtn;
    
    reset();
    
    forever 
    begin
      seq_item_port.get_next_item(xtn);
      drive(xtn);
      seq_item_port.item_done();
    end
    //`uvm_info(get_type_name(),$sformatf("in driver run phase",xtn.sprint()),UVM_LOW);
  endtask
  
  //reset logic 
  
  task reset();
    @(vif.drv_cb)
    
    	vif.drv_cb.rst<=1'b1;
    
    @(vif.drv_cb)
    
    	vif.drv_cb.rst<=1'b0;
    
  endtask
    	
  
  //driving logic
  
  task drive(dff_xtn xtn);
    
    @( vif.drv_cb);
    
    vif.drv_cb.d_in<=xtn.d_in;
    
    `uvm_info(get_type_name(),$sformatf("in driver run phase %s",xtn.sprint()),UVM_LOW);
  endtask
  
endclass
 
//-----------------------------------monitor-----------------------------------------------

class dff_mon extends uvm_monitor;
  `uvm_component_utils(dff_mon)
  //virtual interface handle
  virtual dff_if.mon_mp vif;
  dff_config d_cfg;
  //analysis port
  uvm_analysis_port#(dff_xtn) mon_ap;
  
  function new(string name="dff_mon",uvm_component parent);
    super.new(name,parent);
    mon_ap=new("mon_ap",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(dff_config)::get(this,"","dff_config",d_cfg))
      `uvm_fatal(get_type_name(),"didnt get configaration to monitor");
  endfunction
  
   function void connect_phase(uvm_phase phase);
    vif=d_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
   // super.run_phase(phase);
    
    repeat(10)begin
      @(vif.mon_cb);
      
     // #1;
    begin
    	dff_xtn xtn_mon;
     	xtn_mon=dff_xtn::type_id::create("xtn_mon");
    	xtn_mon.d_in=vif.mon_cb.d_in;
    	xtn_mon.d_out=vif.mon_cb.d_out;
     	mon_ap.write(xtn_mon);
      
      
       `uvm_info(get_type_name(),$sformatf("in monitor run phase %s",xtn_mon.sprint()),UVM_LOW);
    end
      
   // `uvm_info(get_type_name(),"in run_phase of monitor",UVM_LOW);
    end
  endtask
endclass
      	
//-----------------------------------agent-------------------------------------------------

class dff_agent extends uvm_agent;
  `uvm_component_utils(dff_agent)
  //handles of sequencer,monitor,driver,configuration
  dff_drv drvh;
  dff_mon monh;
  dff_seqr seqrh;
  dff_config d_cfg;
  
  //virtual interface handle
 // virtual dff_if vif;
  
  function new(string name="dff_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(dff_config)::get(this,"","dff_config",d_cfg))
      `uvm_fatal(get_type_name(),"didnt get configaration to agent");
    
    monh=dff_mon::type_id::create("monh",this);
    
    if(d_cfg.is_active==UVM_ACTIVE)
      begin
        drvh=dff_drv::type_id::create("drvh",this);
        seqrh=dff_seqr::type_id::create("seqrh",this);
      end
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(d_cfg.is_active==UVM_ACTIVE)
      drvh.seq_item_port.connect(seqrh.seq_item_export);
  endfunction
endclass
  
//-----------------------------------scoreboard--------------------------------------------

class dff_sb extends uvm_scoreboard;
  `uvm_component_utils(dff_sb)
  int no_of_transaction=0;
  int compared=0;
  int failed;
  uvm_analysis_imp#(dff_xtn,dff_sb) sb_imp;
  
  function new(string name="dff_sb",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	sb_imp=new("sb_imp",this);
  endfunction
  
  function void write(dff_xtn xtn);
    no_of_transaction++;
    if(xtn.d_out==xtn.d_in)
      begin
        compared++;
        `uvm_info(get_type_name(),"the data is compared and success",UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("the transaction is d_in= %0d , d_out= %0d",xtn.d_in,xtn.d_out),UVM_LOW);
      end
    else
      begin
        failed++;
        `uvm_info(get_type_name(),"the data is failed",UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("the transaction is d_in= %0d , d_out= %0d",xtn.d_in,xtn.d_out),UVM_LOW);
      end
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("number of trasactions %0d",no_of_transaction),UVM_LOW);
    `uvm_info(get_type_name(),$sformatf("number of compared %0d",compared),UVM_LOW);
    `uvm_info(get_type_name(),$sformatf("number of failed %0d",failed),UVM_LOW);
  endfunction
endclass
  
//-----------------------------------environment-------------------------------------------

class dff_env extends uvm_env;
  `uvm_component_utils(dff_env)
  
  dff_agent agnth;
  dff_sb sbh;
  function new(string name="dff_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnth=dff_agent::type_id::create("agnth",this);
    sbh=dff_sb::type_id::create("sbh",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnth.monh.mon_ap.connect(sbh.sb_imp);
  endfunction
  
endclass
  
//-----------------------------------test--------------------------------------------------
  
class dff_test extends uvm_test;
  `uvm_component_utils(dff_test)
  dff_config d_cfg;
  dff_env envh;
  
  dff_seq seqh;
  function new(string name="dff_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d_cfg=dff_config::type_id::create("d_cfg");
    d_cfg.is_active=UVM_ACTIVE;
    if(!uvm_config_db#(virtual dff_if)::get(this,"","virtual dff_if",d_cfg.vif))
    	`uvm_info(get_type_name(),"virtual interface from top to test is not getting",UVM_LOW);
    uvm_config_db#(dff_config)::set(this,"*","dff_config",d_cfg);
    envh=dff_env::type_id::create("envh",this);
    seqh=dff_seq::type_id::create("seqh");
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
  	uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seqh.start(envh.agnth.seqrh);
    #100;
    phase.drop_objection(this);
  endtask
    
  
endclass
  
//-----------------------------------top---------------------------------------------------
module dff(clk,d_in,rst,d_out);
	input bit d_in;
	input bit clk;
	input bit rst;
	output logic d_out;
	always@(posedge clk)
	begin
		if(rst)
			d_out<=1'b0;
		else
			d_out<=d_in;
	end
endmodule

interface dff_if(input bit clk);
	logic d_in;
	logic rst;
	logic d_out;
  
  clocking drv_cb@(posedge clk);
    
    default input #1 output #0;
    
    output d_in;
    
    output rst;
    
    //input d_out;
    
  endclocking
  
   clocking mon_cb @(posedge clk);
        default input #0 output #0;
        input d_in;
        input rst;
        input d_out;
    endclocking
  
  modport drv_mp (clocking drv_cb);
    
    modport mon_mp (clocking mon_cb);
    
endinterface
	
module top();
	bit clk;
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	dff_if vif(clk);
	/*initial begin
		vif.rst=1;
		#15;
		vif.rst=0;
		end */
	//dff in0(clk);
	
	dff dut(.clk(vif.clk),.d_in(vif.d_in),.rst(vif.rst),.d_out(vif.d_out));
	
  initial begin
    uvm_config_db#(virtual dff_if)::set(null,"*","virtual dff_if",vif);
    run_test("dff_test");
  end
  
endmodule

