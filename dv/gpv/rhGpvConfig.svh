`ifndef rhGpvConfig__svh
`define rhGpvConfig__svh

class RhGpvConfig extends uvm_object;
	string interfacePath;
	RhGpvInterfaceControl ifCtrl;
	`uvm_object_utils_begin(RhGpvConfig)
	`uvm_object_utils_end
	extern task sync(int cycle=1);
	extern task driveVectorBit(bit v,int pos);
	extern function  new(string name="RhGpvConfig");
endclass
task RhGpvConfig::sync(int cycle=1);
	ifCtrl.sync(cycle);
endtask
task RhGpvConfig::driveVectorBit(bit v,int pos);
	ifCtrl.drive(v,pos);
endtask
function  RhGpvConfig::new(string name="RhGpvConfig");
	super.new(name);
endfunction

`endif
