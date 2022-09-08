global type and macro definition.

The typedef file, all internal types and macors used by RHGpVip will be declared in this file.

# file GpvTypes.svh
## head of code file
**prototype**
```
`ifndef GpvTypes__svh
`define GpvTypes__svh
```
## typedef
### GpvVectorType
a logic vector, supports 4096 bit.
**prototype**
```
typedef logic [4095:0] GpvVectorType;
```
### GpvDriveVector
a struct that contains value, start position and end position information
**prototype**
```
typedef struct {
	GpvVectorType value;
	int startPos;
	int endPos;
} GpvDriveVector;
```
## macro
### gpvResp
**prototype**
```
`uvm_analysis_imp_decl(_gpvResp)
```
## end of code file
**prototype**
```
`endif
```