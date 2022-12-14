This sequence item derived from uvm_sequence_item, and can be overridden by users, for their own purpose, just need to create a GPV object by specified sequence item. For example:
`GpvAgent#(derivedGpvSeqItem) gpv;`
# Features
## support response enable control
This sequence item has a builtin flag: `bit respEn;` which indicates to the response enable, when this flag is 1, then the driver is required to turn back a response transaction to the sequencer; else no response required, the driver will call item_done() immediated after sending the requests.
# file GpvSeqItem.svh
## head of code file
**prototype**
```
`ifndef GpvSeqItem__svh
`define GpvSeqItem__svh

```
## class declaration
**prototype**
```
class GpvSeqItem extends uvm_sequence_item;
```
## fields
**prototype**
```

	bit respEn=1'b0;

	`uvm_object_utils(GpvSeqItem)
```
## contents
- [[#constructor]]
## constructor
**prototype**
```
	function new(string name="GpvSeqItem");
		super.new(name);
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