`ifndef rhGpvDriver__svh
`define rhGpvDriver__svh

class RhGpvDriver #( type REQ=uvm_sequence_item,RSP=REQ) extends RhDriverBase;
	`uvm_component_utils_begin(RhGpvDriver#(REQ,RSP))
	`uvm_component_utils_end
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task mainProcess();
	extern task __driveTheDriveObject__(RhGpvDriveObject dobj);
	extern function  new(string name="RhGpvDriver",uvm_component parent=null);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
endclass
function void RhGpvDriver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	protocol = RhGpvProtocolBase::type_id::create("protocol");
endfunction
task RhGpvDriver::mainProcess();
	RhGpvDriveObject dobj=new("dobj");
	seq_item_port.get_next_item(req);
	protocol.translateReqToDriveObject(req,dobj);
	__driveTheDriveObject__(dobj);
	config.sync(1); // sync to next clock cycle.
	seq_item_port.item_done(); // no response available for now.
endtask
task RhGpvDriver::__driveTheDriveObject__(RhGpvDriveObject dobj);
	foreach (dobj.vectors[i]) begin
		foreach (dobj.bitsens[i][pos])
			if (dobj.bitsens[i][pos]) config.driveVectorBit(dobj.vectors[i][pos],pos);
		config.sync(1);
	end
endtask
function  RhGpvDriver::new(string name="RhGpvDriver",uvm_component parent=null);
	super.new(name,parent);
endfunction
function void RhGpvDriver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction
task RhGpvDriver::run_phase(uvm_phase phase);
	super.run_phase(phase);
endtask

`endif
