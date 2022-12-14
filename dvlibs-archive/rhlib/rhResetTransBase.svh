`ifndef rhResetTransBase__svh
`define rhResetTransBase__svh

class RhResetTransBase extends uvm_sequence_item;
	RhResetState_enum state;
	`uvm_object_utils_begin(RhResetTransBase)
	`uvm_object_utils_end
	extern function  new(string name="RhResetTransBase");
endclass
function  RhResetTransBase::new(string name="RhResetTransBase");
	super.new(name);
endfunction

`endif
