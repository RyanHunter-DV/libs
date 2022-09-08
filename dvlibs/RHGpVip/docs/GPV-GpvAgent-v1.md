# source code
## contents
- [[#fields]]
- public APIs
	- [[#build_phase]]
	- [[#connect_phase]]
- private APIs
## head of code file
**prototype**
```
`ifndef GpvAgent__svh
`define GpvAgent__svh
```
## class declaration
**prototype**
```
class GpvAgent#(type REQ=GpvSeqItem,RSP=REQ,IMAP=GpvInterfaceMap)
	extends uvm_agent;
```
## fields
```
	GpvDriver#(REQ,RSP,IMAP) drv;
	GpvSeqr#(REQ,RSP) sesqr;
	// TODO, GpvMonitor#(REQ,RSP,IMAP) mon;

	`uvm_component_utils(GpvAgent#(REQ,RSP,IMAP))
```
## constructor
**prototype**
```
	function new(string name="GpvAgent",uvm_component parent=null);
		super.new(name,parent);
	endfunction
```
## *build_phase*
**prototype**
```
	extern function void build_phase(uvm_phase phase);
```
**procedures**
```
function void GpvAgent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (is_active) begin
		drv = GpvDriver#(REQ,RSP,IMAP)::type_id::create("drv",this);
		seqr= GpvSeqr#(REQ,RSP)::type_id::create("seqr",this);
	end
endfunction
```
## *connect_phase*
**prototype**
```
	extern function void connect_phase(uvm_phase phase);
```
**procedures**
```
function void GpvAgent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if (is_active) begin
		drv.seq_item_port.connect(seqr.seq_item_export);
	end
endfunction
```