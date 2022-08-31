`ifndef GpvDriveObject__svh
`define GpvDriveObject__svh

class GpvDriveObject#(type T=GpvInterfaceDefine) extends GpvDriveObjectBase; // {

	T interfaceMap;
	int cycleIndex;
	GpvDriveVectorPool vectors[$];
	GpvDriveVectorPool clocks[$];
	GpvDriveVectorPool resets[$];
	bit respEn;

	`uvm_object_utils(GpvDriveObject#(T))

	function new(string name="GpvDriveObject");
		GpvDriveVectorPool pool = new("pool");
		super.new(name);
		// create first vector item
		vectors.push_back(pool);
		cycleIndex = 0;
		respEn = 1'b0;
		// TODO, same as clock/reset map
	endfunction

	extern function void nextCycle( );
	extern function int cycles( );
	extern function void vector(
		string name,
		logic [`GpvVectorMaxWidth-1:0] val
	);
	extern function GpvDriveVectorPool getVectorsOfCycle(int i);
	extern function bit needResponse( );
endclass // }

function bit GpvDriveObject::needResponse( ); // {
	// PLACEHOLDER, auto generated function, add content here
	return respEn;
endfunction // }


function GpvDriveVectorPool GpvDriveObject::getVectorsOfCycle(int i); // {
	// if i > cycleIndex, return null
	if (i>cycleIndex) return null;
	return vectors[i];
endfunction // }

function void GpvDriveObject::vector(
	string name,
	logic [`GpvVectorMaxWidth-1:0] val
); // {
	// to call parameter T's interface to setup the position and value of vector.
	GpvDriveVector v = interfaceMap.map(name,val);
	vectors[cycleIndex].add(v);
endfunction // }

function int GpvDriveObject::cycles( ); // {
	// PLACEHOLDER, auto generated function, add content here
	return cycleIndex+1;
endfunction // }

function void GpvDriveObject::nextCycle( ); // {
	// PLACEHOLDER, auto generated function, add content here
	// create a new vector for next cycle driving
	GpvDriveVectorPool pool = new("vector");
	vectors.push_back(pool);
	// same as clock/reset map
	cycleIndex++;
endfunction // }

`endif
