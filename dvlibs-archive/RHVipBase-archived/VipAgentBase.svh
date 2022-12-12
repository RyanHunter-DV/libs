`ifndef VipAgentBase__svh
`define VipAgentBase__svh

virtual class VipAgentBase extends uvm_agent; // {

	VipResetHandler reseth;
	VipDriverBase   drv;
	VipMonitorBase  mon;
	VipSeqrBase     seqr;


	function new(string name="VipAgentBase",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	extern virtual function void connect_phase(uvm_phase phase);
endclass // }

function void VipAgentBase::connect_phase(uvm_phase phase); // {
	if (is_active) begin
		drv.setResetHandler(reseth);
		// @RyanH,TODO, mon.resetP.connect(drv.resetI);
	end
endfunction // }

`endif
