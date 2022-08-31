`ifndef GpvDriveVector__svh
`define GpvDriveVector__svh

class GpvDriveVector extends uvm_object; // {

	logic [`GpvVectorMaxWidth-1:0] value;
	int startPos;
	int endPos;

	`uvm_object_utils(GpvDriveVector)

	function new(string name="GpvDriveVector");
		super.new(name);
	endfunction

endclass // }

`endif
