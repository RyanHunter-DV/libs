This page is for interface mapping.
# user examples
users need to extend this class, and create their own interface mapping information. With following APIs: #TBD 

# Strategies
## mapping signals with the vector position
When this class is created, users can add the map information in the class constructor, with a pre-defined API: `sigmap`

# source code
## head of code file
**prototype**
```
`ifndef GpvInterfaceMap__svh
`define GpvInterfaceMap__svh

```
## class declaration
**prototype**
```
class interfaceMap;
```
## contents
- [[#fields]]
- public APIs
	- [[#sigmap]]
	- [[#constructor]]
	- [[#getMapInfo]]
## fields
**prototype**
```
	// the three arrayies should be operated at the same time with same string
	// typed signal name.
	int startPos[string];
	int endPos[string];
	// not support for now, GpvVectorType defaults[string];
```
## constructor
**prototype**
```
	function new();
		// sigmap will be called at the constructor of derivatives 
		// example: sigmap("name",0,3);
	endfunction
```
## sigmap
The function called by derivative classes to add user specified interface map information.
**prototype**
```
	extern function void sigmap(string sig,int s,int e);
```
**procedures**
```
function void GpvInterfaceMap::sigmap(string sig,int s,int e);
	startPos[sig] = s;
	endPos[sig] = e;
endfunction
```
## getMapInfo
According to input signal name, change the s(start position) and e(end position) arguments giving by caller through `ref` direction.
**prototype**
```
	extern function void getMapInfo(string sig,ref int s,ref int e);
```
**procedures**
```
function void GpvInterfaceMap::getMapInfo(string sig,ref int s,ref int e);
	if (startPos.exists(sig)) begin
		s = startPos[sig];
		e = endPos[sig];
	end
	return;
endfunction
```

---
## end of code file
**prototype**
```
endclass
```
**procedures**
```
`endif
```