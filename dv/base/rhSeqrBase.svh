`ifndef rhSeqrBase__svh
`define rhSeqrBase__svh

class RhSeqrBase #(type REQ=uvm_sequence_item,RSP=REQ) extends uvm_sequencer #(REQ,RSP);
	
	`uvm_object_utils(RhSeqrBase#(REQ,RSP));

	function new(string name = "RhSeqrBase");
		super.new(name);
	endfunction
	
endclass
`endif
