`ifndef VipResetHandler__svh
`define VipResetHandler__svh

class VipResetHandler#(type TR=VipResetTrans) extends uvm_object; // {

	uvm_analysis_imp#(TR,VipResetHandler#(TR)) resetI;
	local VipResetStaus st;

	`uvm_object_utils(VipResetHandler#(TR))

	function new(string name="VipResetHandler");
		super.new(name);
		resetI = new("resetI");
	endfunction


	extern function void write(VipResetTrans _t);
	extern task threadControl(process p);
	extern task waitResetDone( );
endclass // }

task VipResetHandler::waitResetDone( ); // {
	wait(st==resetInActive);
endtask // }

task VipResetHandler::threadControl(process p); // {
	wait (st==resetActive);
	if (p.status() == process::RUNNING) p.kill();
endtask // }

function void VipResetHandler::write(VipResetTrans _t); // {
	st = _t;
endfunction // }

`endif
