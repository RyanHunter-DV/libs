`ifndef rhGpvAgent__svh
`define rhGpvAgent__svh

class RhGpvAgent #( type REQ=uvm_sequence_item,RSP=REQ) extends uvm_agent;
	`uvm_component_utils_begin(RhGpvAgent#(REQ,RSP))
	`uvm_component_utils_end
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern function RhGpvConfig createConfig(string name);
	extern function  new(string name="RhGpvAgent",uvm_component parent=null);
	extern virtual task run_phase(uvm_phase phase);
endclass
function void RhGpvAgent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (is_active==UVM_ACTIVE) begin
		drv = RhGpvDriver::type_id::create("drv",this);
		seqr= RhGpvSeqr::type_id::create("seqr",this);
		drv.config = config;
	end
	mon = RhGpvMonitor::type_id::create("mon",this);
	mon.config = config;
endfunction
function void RhGpvAgent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if (!uvm_config_db#(RhGpvInterfaceControl)::get(null,"*",config.interfacePath,config.ifCtrl))
		`uvm_error("NIFC",$sformatf("no interface got from path(%s)",config.interfacePath))
	
	// TLM connections
	mon.resetP.connect(drv.resetI);
	
endfunction
function RhGpvConfig RhGpvAgent::createConfig(string name);
		config = RhGpvConfig::type_id::create(name);
		return config;
endfunction
function  RhGpvAgent::new(string name="RhGpvAgent",uvm_component parent=null);
	super.new(name,parent);
endfunction
task RhGpvAgent::run_phase(uvm_phase phase);
	super.run_phase(phase);
endtask

`endif
