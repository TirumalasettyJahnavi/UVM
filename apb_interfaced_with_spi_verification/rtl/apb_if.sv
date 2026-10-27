interface apb_if(input bit clock);

	logic preset_n,
		
		pready,

		penable,

		pwrite,

		psel;

	logic [2:0]paddr;

	logic [7:0] pwdata;

	logic [7:0] prdata;

	logic pslverr;

	clocking apb_driver_cb@(posedge clock);

		default input #1 output #0;

		output preset_n;

		output pwrite;

		output penable;

		output psel;

		output paddr;

		output pwdata;

		//input sclk;

		//input ss;

		input prdata;

		input pready;

	endclocking:apb_driver_cb

	clocking apb_monitor_cb @(posedge clock);

		default input #1 output #0;

		input preset_n;

		input pready;

		input penable;

		input psel;

		input paddr;

		input pwdata;

		input pslverr;

		input prdata;

		input pwrite;

	endclocking 

	modport apb_drv_mp (clocking apb_driver_cb);

	modport apb_mon_mp (clocking apb_monitor_cb);

endinterface