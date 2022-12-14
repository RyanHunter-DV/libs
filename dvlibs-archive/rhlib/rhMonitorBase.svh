`ifndef rhMonitorBase__svh
`define rhMonitorBase__svh

class RhMonitorBase extends uvm_monitor;
	uvm_analysis_port #(RhResetTransBase) resetP;
	RhResetState_enum currentResetState;
	`uvm_component_utils_begin(RhMonitorBase)
	`uvm_component_utils_end
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task waitResetStateChanged(output RhResetState_enum s);
	extern virtual task run_phase(uvm_phase phase);
	extern virtual task mainProcess();
	extern task resetMonitor();
	extern function  new(string name="RhMonitorBase",uvm_component parent=null);
	extern virtual function void connect_phase(uvm_phase phase);
endclass
function void RhMonitorBase::build_phase(uvm_phase phase);
	super.build_phase(phase);
	currentResetState = RhResetUnknow;
	resetP = new("resetP",this);
endfunction
task RhMonitorBase::waitResetStateChanged(output RhResetState_enum s);
endtask
task RhMonitorBase::run_phase(uvm_phase phase);
	super.run_phase(phase);
	fork
		resetMonitor();
		mainProcess();
	join
endtask
task RhMonitorBase::mainProcess();
endtask
task RhMonitorBase::resetMonitor();
	RhResetTransBase _t = new("initReset");
	`uvm_info(get_type_name(),"resetMonitor started",UVM_LOW)
	_t.state = currentResetState;
	resetP.write(_t);
	forever begin
		RhResetTransBase updatedTrans = new("updatedReset");
		waitResetStateChanged(currentResetState);
		`uvm_info(get_type_name(),$sformatf("reset state changed to:%s",currentResetState.name),UVM_LOW)
		updatedTrans.state = currentResetState;
		resetP.write(updatedTrans);
	end
endtask
function  RhMonitorBase::new(string name="RhMonitorBase",uvm_component parent=null);
	super.new(name,parent);
endfunction
function void RhMonitorBase::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction

`endif
