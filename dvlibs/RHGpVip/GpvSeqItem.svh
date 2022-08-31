`ifndef GpvSeqItem__svh
`define GpvSeqItem__svh

class GpvSeqItem extends uvm_sequence_item; // {

	`uvm_object_utils(GpvSeqItem)

	function new(string name="GpvSeqItem");
		super.new(name);
	endfunction

endclass // }

`endif
