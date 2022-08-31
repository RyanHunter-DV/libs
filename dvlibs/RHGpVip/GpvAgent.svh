`ifndef GpvAgent__svh
`define GpvAgent__svh

class GpvAgent #(type REQ=GpvSeqItem,RSP=REQ) extends uvm_agent; // {

	GpvDriver#(REQ,RSP) drv;
	GpvSeqr#(REQ,RSP)   seqr;

	`uvm_component_utils(GpvAgent#(REQ,RSP))

	function new (string name="GpvAgent",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual function void build_phase(uvm_phase phase);
endclass // }

function void GpvAgent::connect_phase(uvm_phase phase); // {
	super.connect_phase(phase);
	if (is_active) begin
		drv.seq_item_port.connect(seqr.seq_item_export);
	end
endfunction // }

function void GpvAgent::build_phase(uvm_phase phase); // {
	// PLACEHOLDER, auto generated function, add content here
	super.build_phase(phase);
	if (is_active) begin
		drv = GpvDriver#(REQ,RSP)::type_id::create("drv",this);
		seqr= GpvSeqr#(REQ,RSP)::type_id::create("seqr",this);
	end
endfunction // }

`endif
