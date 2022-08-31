`ifndef GpvSeqr__svh
`define GpvSeqr__svh

class GpvSeqr#(type REQ=GpvSeqItem,RSP=REQ) extends uvm_sequencer#(REQ,RSP); // {

	`uvm_component_utils(GpvSeqr#(REQ,RSP))

	function new(string name="GpvSeqr",uvm_component parent=null);
		super.new(name,parent);
	endfunction

endclass // }

`endif
