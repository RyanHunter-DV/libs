`ifndef rhGpvProtocolBase__svh
`define rhGpvProtocolBase__svh

class RhGpvProtocolBase extends uvm_object;
	RhGpvSigPos_t signalMap[string];
	`uvm_object_utils_begin(RhGpvProtocolBase)
	`uvm_object_utils_end
	extern local function void __register__(string name,int s,int e);
	extern function  new(string name="RhGpvProtocolBase");
	extern virtual function void setupSignalMap();
endclass
function void RhGpvProtocolBase::__register__(string name,int s,int e);
	RhgpvSigPos_t pos= {s,e};
	signalMap[name] = pos;
endfunction
function  RhGpvProtocolBase::new(string name="RhGpvProtocolBase");
	super.new(name);
	setupSignalMap();
endfunction
function void RhGpvProtocolBase::setupSignalMap();
endfunction

`endif
