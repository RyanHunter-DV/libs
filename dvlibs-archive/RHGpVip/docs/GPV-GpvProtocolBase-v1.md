A virtual class for users to adopt from, and write their own protocol of translate and signal2transaction.
# Features
## provide customized translate API
by creating their own virtual function translate(), users can specify the protocol from transaction level to drive object level.
the translate API can translate uvm_sequence_item into [[RHGpVip/GpvDriveObject|GpvDriveObject]]. This API called by the [[RHGpVip/GpvDriver|GpvDriver]] that translate the transaction to supportive GpvDriveObject.
using `GpvDriveObject dObj` to translate `GpvSeqItem breq` to drive object:
**use dObj.vector**
This operation used to add a specific vector to current cycle, for example:
`dObj.vector("sig0",2);` This will add value 2 for sig0, which means in cycle 0, the driver can drive 2 on "sig0" vector.
**use dObj.nextCycle**
This Api to increment one clock cycle, all consequent call of dObj.vector will add signal driving actions for next clock cycle.
combination of those two APIs allows users to translate "what signals driven on which cycle" information in a transaction onto the interface signal.
### provides drive API
This API can call vif's drive to drive different vectors in [[GpvDriveObject]].

---
# class GpvProtocolBase
## contents
- [[#fields]]
- public APIs
	- [[#translate]]
	- [[#drive]]
	- [[#signal2transaction]], #TBD 
- private APIs
## head of code file
**prototype**
```
`ifndef GpvProtocolBase__svh
`define GpvProtocolBase__svh

```

## class declaration
**prototype**
```
class GpvProtocolBase extends uvm_object;
```
## fields
- [[GpvInterface]]
```
	virtual GpvInterface vif;

	`uvm_object_utils(GpvProtocolBase)
```
## constructor
```
	function new(string name="GpvProtocolBase");
		super.new(name);
	endfunction
```
## *translate()*
API to translate transaction level information into GpvDriveObject, driver will use GpvDriveObject to drive signals vectors.
User customized on this function.
- require [[RHGpVip/GpvDriveObject|GpvDriveObject]]
- 
**prototype**
```
	virtual function bit translate(
		GpvSeqItem breq,
		ref GpvDriveObject dObj
	);
	endfunction
```

## *drive()*
- [[GpvDriveObject]]
- [[GpvInterface]]
- [[GpvDriveVectors]]
**prototype**
```
	extern virtual task drive(GpvDriveObject dObj);
```
**procedures**
```
task GpvProtocolBase::drive(GpvDriveObject dObj);
	GpvDriveVectorPool pool;
	for (int i=0;i<dObj.cycles();i++) begin
		GpvDriveVector vector;
		pool = dObj.getVectorsOfCycle(i);
		vif.sync();
		do begin
			vector = pool.pop();
			vif.drive("vector",
				vector.value,
				vector.startPos,
				vector.endPos
			);
		end while(vector != null);
		// dObj.syncCycle();
	end
	// driveClock = dObj.getClocksOfCycle()
endtask
```


## *signal2transaction()*
API for monitor, to collect signal level information to protocol.
**prototype**
```
	virtual function void signal2transaction(
		GpvDriveObject dObj,
		ref GpvSeqItem seq
	);
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