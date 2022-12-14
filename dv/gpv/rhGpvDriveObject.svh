`ifndef rhGpvDriveObject__svh
`define rhGpvDriveObject__svh

class RhGpvDriveObject extends uvm_object;
	uvm_bitstream_t vectors[];
	uvm_bitstream_t bitsens[];
	local int __currentCycle;
	`uvm_object_utils_begin(RhGpvDriveObject)
	`uvm_object_utils_end
	extern function  new(string name="RhGpvDriveObject");
	extern function void nextCycle();
	extern function void addToVector(uvm_bitstream_t val,RhGpvSigPos_t pos);
endclass
function  RhGpvDriveObject::new(string name="RhGpvDriveObject");
	super.new(name);
	// init one new vector/bitsen item.
	vectors.push_back('h0);
	bitsens.push_back('h0);
endfunction
function void RhGpvDriveObject::nextCycle();
endfunction
function void RhGpvDriveObject::addToVector(uvm_bitstream_t val,RhGpvSigPos_t pos);
	int size = pos.e-pos.s+1;
	vectors[__currentCycle][pos.e:pos.s] = val[size-1:0];
	bitsens[__currentCycle][pos.e:pos.s] = {size{1'b1}};
endfunction

`endif
