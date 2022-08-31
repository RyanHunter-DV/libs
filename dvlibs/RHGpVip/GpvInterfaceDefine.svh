`ifndef GpvInterfaceDefine__svh
`define GpvInterfaceDefine__svh

virtual class GpvInterfaceDefine extends uvm_object; // {

	function new(string name="GpvInterfaceDefine");
		super.new(name);
	endfunction

	pure virtual function GpvDriveVector map(
		string name,
		logic [`GpvVectorMaxWidth-1:0] val
	);

endclass // }

`endif
