The driver component, which derived from [[RVB-RHVipDriver-v1]].
# Architecture


# source code
**file GpvDriver.svh**
### contents
- [[#fields]]
- 
## head of code file
**prototype**
```
`ifndef GpvDriver__svh
`define GpvDriver__svh
```
## class declaration
**prototype**
```
class GpvDriver#(type REQ=GpvSeqItem,RSP=REQ,IMAP=GpvInterfaceMap)
	extends RHVipDriver#(REQ,RSP);
```

### fields
- require [[GPV-GpvTypes-v1#gpvResp]]
```
	GpvProtocolBase protocol;
	uvm_event#(RSP) respWaiting;
	uvm_analysis_imp_gpvResp#(RSP,GpvDriver#(REQ,RSP,IMAP)) resp;
```
- public APIs
	- [[#build_phase]]
	- [[#mainProcess]]
	- [[#write_gpvResp]]
- private APIs
	- [[#waitForResponse]]
### build_phase
**prototype**
```
	extern function void build_phase(uvm_phase phase);
```
**procedures**
```
function void GpvDriver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	protocol = GpvProtocolBase::type_id::create("protocol");
	respWaiting = new("respWaiting");
	resp = new("resp",this);
endfunction
```
### mainProcess
derived from RHVipDriver, used to process the main tasks in run_phase.
- required [[GPV-GpvProtocolBase-v1#translate]];
- required [[GPV-GpvProtocolBase-v1#drive]];
- required [[#waitForResponse]];
**prototype**
```
	extern task mainProcess();
```
**procedures**
```
task GpvDriver::mainProcess();
	GpvDriveObject dObj;
	RSP resp;
	bit result;
	GpvDriveObject driveObj;
	seq_item_port.get_next_item(req);
	result = protocol.translate(req,driveObj);
	protocol.drive(driveObj);
	if (driveObj.needResponse()) begin
		waitForResponse(resp);
		seq_item_port.item_done(resp);
	end else seq_item_port.item_done();
endtask
```
### write_gpvResp
**prototype**
```
	extern function void write_gpvResp(RSP _r);
```
**procedures**
```
function void GpvDriver::write_gpvResp(RSP _r);
	respWaiting.trigger(_r);
endfunction
```
### waitForResponse
**prototype**
```
	extern local task waitForResponse(output RSP _r);
```
**procedures**
```
task GpvDriver::waitForResponse(output RSP _r);
	respWaiting.wait_trigger(_r);
endtask
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
