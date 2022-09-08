`ifndef VipResetTrans__svh
`define VipResetTrans__svh


class VipResetTrans extends uvm_sequence_item; // {

	VipResetStatus st;

	local time __start;
	local time __end;
	bool started;

	`uvm_object_utils_begin(VipResetTrans)
	`uvm_object_utils_end

	function new(string name="VipResetTrans");
		super.new(name);
		started = false;
	endfunction

endclass // }

`endif
