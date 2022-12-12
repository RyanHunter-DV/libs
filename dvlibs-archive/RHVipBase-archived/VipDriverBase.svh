`ifndef VipDriverBase__svh
`define VipDriverBase__svh

virtual class VipDriverBase#(type REQ=uvm_sequence_item,RSP=REQ)
	extends uvm_driver#(REQ,RSP); // {


	local VipResetHandler reseth;
	local process p;

	function new(string name="VipDriverBase",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	pure virtual task mainProcess();

	extern virtual task run_phase(uvm_phase phase);
	extern function void setResetHandler(VipResetHandler rh);
endclass // }

function void VipDriverBase::setResetHandler(VipResetHandler rh); // {
	reseth = rh;
endfunction // }

task VipDriverBase::run_phase(uvm_phase phase); // {
	// PLACEHOLDER, auto generated task, add content here
	forever begin
		p = process::self();
		fork reseth.threadControl(p); join_none
		reseth.waitResetDone();
		mainProcess();
	end
endtask // }

`endif
