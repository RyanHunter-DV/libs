`ifndef rhGpvInterfaceControl__svh
`define rhGpvInterfaceControl__svh

class RhGpvInterfaceControl extends uvm_object;
	virtual RhGpvIf vif;
	`uvm_object_utils_begin(RhGpvInterfaceControl)
	`uvm_object_utils_end
	extern task sync(int cycle);
	extern task drive(logic v,int pos);
	extern function  new(string name="RhGpvInterfaceControl");
endclass
task RhGpvInterfaceControl::sync(int cycle);
	repeat (cycle) @(posedge vif.clock[0]);
endtask
task RhGpvInterfaceControl::drive(logic v,int pos);
	vif.vector[pos] <= v;
endtask
function  RhGpvInterfaceControl::new(string name="RhGpvInterfaceControl");
	super.new(name);
endfunction

`endif
