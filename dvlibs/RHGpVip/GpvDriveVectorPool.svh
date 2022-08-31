`ifndef GpvDriveVectorPool__svh
`define GpvDriveVectorPool__svh

class GpvDriveVectorPool extends uvm_object; // {

	GpvDriveVector items[$];

	`uvm_object_utils(GpvDriveVectorPool)

	function new(string name="GpvDriveVectorPool");
		super.new(name);
	endfunction

	extern function GpvDriveVector pop( );
	extern function void add(GpvDriveVector v);

endclass // }

function void GpvDriveVectorPool::add(GpvDriveVector v); // {
	// PLACEHOLDER, auto generated function, add content here
	items.push_back(v);
endfunction // }

function GpvDriveVector GpvDriveVectorPool::pop( ); // {
	// PLACEHOLDER, auto generated function, add content here
	if (items.size()==0) return null;
	return items.pop_front();
endfunction // }

`endif
