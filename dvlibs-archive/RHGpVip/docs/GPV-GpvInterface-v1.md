This is the interface file that declared the GpvInterface.
# file GpvInterface.sv
For current version, the interface only has one clock and reset.

## head of file
**prototype**
```
`ifndef GpvInterface__sv
`define GpvInterface__sv

```
**prototype**
```
interface GpvInterface#(VECTOR_WIDTH=4096) (input logic clk, input logic rstn);
```
## signals
**prototype**
```
	logic [VECTOR_WIDTH-1:0] vector;
```

## contents
- public APIs
	- [[#sync]]
	- [[#drive]]
- private APIs
	- [[#driveVector]]
## driveVector()
**prototype**
```
	task driveVector(
		logic [`GpvVectorMaxWidth-1:0] val,
		int startPos, int endPos
	);
		int width = endPos-startPos+1;
		if (width == 1)
			vector[startPos] = val[0];
		else begin
			for (int _l=0;_l<width;_l++)
				vector[startPos+_l] = val[_l];
		end
	endtask	
```

## sync()
**prototype**
```
	task sync();
		@(posedge clk);
	endtask
```
## drive()
to drive signal according to specified name, will call driveVector(), driveClock(), driveReset() tasks.
**prototype**
```
	task drive(
		string name,
		logic [`GpvVectorMaxWidth-1:0] val,
		int startPos, int endPos
	);
		case(name)
			"vector": driveVector(val,startPos,endPos);
			default: $display("not support name: ",name);
		endcase
	endtask
```
---
## end of file
**prototype**
```
endinterface
```
**procedures**
```
`endif
```