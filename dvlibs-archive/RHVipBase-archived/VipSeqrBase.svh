`ifndef VipSeqrBase__svh
`define VipSeqrBase__svh

class VipSeqrBase #(type REQ=uvm_sequence_item,RSP=REQ)
	extends uvm_sequencer#(REQ,RSP); // {

	`uvm_component_utils(VipSeqrBase#(REQ,RSP))

	function new(string name="VipSeqrBase",uvm_component parent=null);
		super.new(name,parent);
	endfunction


endclass // }

`endif
