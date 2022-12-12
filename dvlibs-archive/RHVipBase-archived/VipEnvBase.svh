`ifndef VipEnvBase__svh
`define VipEnvBase__svh

class VipEnvBase extends uvm_env; // { 


	`uvm_component_utils_begin(VipEnvBase)
	`uvm_component_utils_end

	function new(string name="VipEnvBase",uvm_component parent=null);
		super.new(name,parent);
	endfunction

endclass // }

`endif
