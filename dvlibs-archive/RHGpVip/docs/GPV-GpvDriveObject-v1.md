The drive object used to store all available information for driving the signals.
# relative links
- [[GPV-GpvInterfaceMap-v1]], the base interface map class, will be covered by user through parameter;
- [[GPV-GpvDriveVectors-v1]], the drive vectors stores driving information of each cycle, can support multiple vectors;
# Strategies & Features
## support for translating
While in translate(), users can call APIs of The GpvDriveObject to add their own information of driver. Such as:
**add to vector**
The function `vector` let users add the specific part of signals to be driven in current cycle. To enhance the readability, the `vector` function allows users to enter a string as the signal name, instead of the part selection of a vector. This need an extra interface definition class([[#interface definition]]).
**specify next cycle**
The function `nextCycle` called when in translating, used to specify next will add vectors one next clock cycle.
## interface mapping
Interface mapping is to map a meaningless vector bits selection into meaningful string names. Each signal map will has its own name, start position and end position.
The `interfaceMap` object will be defined in GpvDriveObject, somehow, the type of the `interfaceMap` comes from the class parameter. which finally comes from the 
`GpvAgent#(REQ,RSP,IMAP)`.
detailed descriptioon of interface map refer to [[GPV-GpvInterfaceMap-v1]].

## support for getting vectors
While at each cycle in drive actions, the protocol need driving information for each cycle, about how many vectors need to be driven. So the drive object will provide an API to return the drive information.
The API is [[#getVectorsOfCycle]].
And we're plan to use a [[GPV-GpvDriveVectors-v1]] to store all vector information.

# class GpvDriveObject
## contents
- [[#fields]]
- public APIs
	- [[#vector]]
	- [[#nextCycle]]
	- [[#constructor]]
	- [[#getVectorsOfCycle]]
- private APIs
## declaration
**prototype**
```
class GpvDriveObject#(type T=GpvInterfaceMap);
```
## fields
**prototype**
```
	int currentCycleIndex;
	T interfaceMap;
	GpvDriveVectors vectors[$]; // index is cycleIndex
```
## constructor
**prototype**
```
	function new();
		GpvDriveVectors _d = new();
		vectors.push_back(_d);
		interfaceMap = new();
		currentCycleIndex = 0;
	endfunction
```
## vector
API to add a vector signal driving information in `currentCycleIndex`.
- `string sig`, the signal name to drive, this string name is mapped by `interfaceMap`.
- `GpvVectorType val`, value of the signal to be driven, type is of [[GPV-GpvTypes-v1#GpvVectorType]]
**prototype**
```
	extern function void vector(string sig,GpvVectorType val);
```
**procedures**
- require [[GPV-GpvDriveVectors-v1#add]]
- 
```
function void GpvDriveObject::vector(string sig,GpvVectorType val);
	int startPos,endPos;
	interfaceMap.getMapInfo(sig,startPos,endPos);
	vectors[currentCycleIndex].add(startPos,endPos,val);
endfunction
```
## nextCycle
API to change the `currentCycleIndex` to next value. So that all consequent adding vector will be added to next cycle.
**prototype**
```
	extern function void nextCycle();
```
**procedures**
```
function void GpvDriveObject::nextCycle();
	GpvDriveVectors d = new();
	vectors.push_back(d);
	currentCycleIndex++;
endfunction
```
## getVectorsOfCycle
return the `vectors[]` according to the specified cycle index, if index large than `currentCycleIndex`, then return null
**prototype**
```
	extern function GpvDriveVectors getVectorsOfCycle(int idx);
```
**procedures**
```
function GpvDriveVectors GpvDriveObject::getVectorsOfCycle(int idx);
	if (idx > currentCycleIndex) return null;
	return vectors[idx];
endfunction
```