`ifndef VipMonitorBase__svh
`define VipMonitorBase__svh

virtual class VipMonitorBase extends uvm_monitor; // {

	uvm_analysis_port #(VipResetTrans) resetP;
	VipResetStatus currentSt;


	function new(string name="VipMonitorBase",uvm_component parent=null);
		super.new(name,parent);
		currentSt = resetUnknown;
	endfunction



	pure virtual task mainProcess();
	pure virtual task waitResetStatusChanged(VipResetStatus currentSt,VipResetStatus newSt);

	extern task run_phase(uvm_phase phase);
	extern task resetMonitor( );
endclass // }

task VipMonitorBase::resetMonitor( ); // {
	VipResetTrans newSt;
	forever begin // {
		newSt = new("st");
		waitResetStatusChanged(currentSt,newSt.st);
		resetP.send(newSt);
		currentSt = newSt.st;
	end // }
endtask // }

task VipMonitorBase::run_phase(uvm_phase phase); // {
	fork
		resetMonitor();
		mainProcess();
	join
endtask // }

`endif
