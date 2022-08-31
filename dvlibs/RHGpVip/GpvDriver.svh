`ifndef GpvDriver__svh
`define GpvDriver__svh

class GpvDriver#(type REQ=GpvSeqItem,RSP=REQ) extends VipDriverBase#(REQ,RSP); // {

	GpvProtocolBase protocol;
	uvm_analysis_imp_gpvResp #(RSP) resp;
	uvm_event#(RSP) respWaiting;

	`uvm_component_utils(GpvDriver#(REQ,RSP))

	function new(string name="GpvDriver",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	extern virtual function void build_phase(uvm_phase phase);
	extern function void write_gpvResp(RSP _t);
	extern local task waitForResponse(output RSP _r);
	extern task mainProcess( );
endclass // }

task GpvDriver::mainProcess( ); // {
	// PLACEHOLDER, auto generated task, add content here
	RSP resp;
	bit result;
	GpvDriveObject driveObj=new("dObj");
	seq_item_port.get_next_item(req);
	result = protocol.translate(req,driveObj);
	protocol.drive(driveObj);
	if (driveObj.needResponse()) begin
		waitForResponse(resp);
		seq_item_port.item_done(resp);
	end else
		seq_item_port.item_done();
endtask // }

task GpvDriver::waitForResponse(output RSP _r); // {
	// PLACEHOLDER, auto generated task, add content here
	// @RyanH,TODO, respWaiting.wait_trigger(_r);
endtask // }

function void GpvDriver::write_gpvResp(RSP _t); // {
	// PLACEHOLDER, auto generated function, add content here
	// TODO, if respWaiting.waiters > 0 respWaiting.trigger_data(_t)
	// return
endfunction // }

function void GpvDriver::build_phase(uvm_phase phase); // {
	super.build_phase(phase);
	protocol = GpvProtocolBase::type_id::create("protocol");
	resp = new("resp",this);
	respWaiting = new("respWaiting");
endfunction // }

`endif
