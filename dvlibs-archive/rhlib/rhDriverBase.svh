`ifndef rhDriverBase__svh
`define rhDriverBase__svh

class RhDriverBase #( type REQ=uvm_sequence_item,RSP=REQ) extends uvm_driver#(REQ,RSP);
	uvm_analysis_imp_reset #(RhResetTransBase,RhDriverBase#(REQ,RSP)) resetI;
	RhResetState_enum resetState;
	process proc;
	`uvm_component_utils_begin(RhDriverBase#(REQ,RSP))
	`uvm_component_utils_end
	extern virtual task mainProcess();
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	extern local task __resetDetector__();
	extern function  new(string name="RhDriverBase",uvm_component parent=null);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual function void write_reset(RhResetTransBase _tr);
endclass
task RhDriverBase::mainProcess();
	// override in sub classes
endtask
function void RhDriverBase::build_phase(uvm_phase phase);
	super.build_phase(phase);
	resetI = new("resetI",this);
endfunction
task RhDriverBase::run_phase(uvm_phase phase);
	super.run_phase(phase);
	// extra run code here
	fork
		__resetDetector__();
		forever begin
			wait(resetState == RhResetInactive);
			proc = process::self();
			mainProcess();
		end
	join
endtask
task RhDriverBase::__resetDetector__();
	`uvm_info(get_type_name(),"start __resetDetect__",UVM_LOW)
	forever begin
		wait(resetState == RhResetActive);
		if (proc!=null && proc.status != process::FINISHED) proc.kill();
		wait(resetState == RhResetInactive);
	end
endtask
function  RhDriverBase::new(string name="RhDriverBase",uvm_component parent=null);
	super.new(name,parent);
endfunction
function void RhDriverBase::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction
function void RhDriverBase::write_reset(RhResetTransBase _tr);
	// extra code in write_reset, the input trans argument is _tr
	resetState = _tr.state;
endfunction

`endif
