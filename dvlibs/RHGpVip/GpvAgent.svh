`ifndef GpvAgent__svh
`define GpvAgent__svh
class GpvAgent#(type REQ=GpvSeqItem,RSP=REQ,IMAP=GpvInterfaceMap)
	extends uvm_agent;
	GpvDriver#(REQ,RSP,IMAP) drv;
	GpvSeqr#(REQ,RSP) sesqr;
	// TODO, GpvMonitor#(REQ,RSP,IMAP) mon;

	`uvm_component_utils(GpvAgent#(REQ,RSP,IMAP))
	function new(string name="GpvAgent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass
function void GpvAgent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (is_active) begin
		drv = GpvDriver#(REQ,RSP,IMAP)::type_id::create("drv",this);
		seqr= GpvSeqr#(REQ,RSP)::type_id::create("seqr",this);
	end
endfunction
function void GpvAgent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if (is_active) begin
		drv.seq_item_port.connect(seqr.seq_item_export);
	end
endfunction
`endif
