# source code
## head of code file
**prototype**
```
`ifndef GpvSeqr__svh
`define GpvSeqr__svh
```
## class GpvSeqr
**prototype**
```
class GpvSeq#(type REQ=GpvSeqItem,RSP=REQ) extends uvm_sequencer;
```
## fields
```

	`uvm_component_utils(GpvSeqItem#(REQ,RSP))
```
## constructor
**prototype**
```
	function new(string name="GpvSeqr",uvm_component parent=null);
		super.new(name,parent);
	endfunction
```

## end of code file
**prototype**
```
endclass
```
**procedures**
```
`endif
```