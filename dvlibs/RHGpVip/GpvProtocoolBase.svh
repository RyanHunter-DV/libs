`ifndef GpvProtocoolBase__svh
`define GpvProtocoolBase__svh

class GpvProtocolBase extends uvm_object; // {

	virtual GpvInterface vif;

	`uvm_object_utils(GpvProtocolBase)

	function new(string name="GpvProtocolBase");
		super.new(name);
	endfunction

	virtual function bit translate(
		uvm_sequence_item breq,
		ref GpvDriveObject dObj
	); endfunction

	extern virtual task drive(GpvDriveObject dObj);
endclass // }

task GpvProtocolBase::drive(GpvDriveObject dObj); // {
	// PLACEHOLDER, auto generated task, add content here
	GpvDriveVectorPool pool;
	for (int i=0;i<dObj.cycles();i++) begin
		GpvDriveVector vector;
		pool = dObj.getVectorsOfCycle(i);
		vif.sync();
		do begin // {
			vector = pool.pop();
			vif.drive("vector",
				vector.value,
				vector.startPos,
				vector.endPos
			);
		end while(vector != null); // }
		// @RyanH dObj.syncCycle();
	end
endtask // }

`endif
