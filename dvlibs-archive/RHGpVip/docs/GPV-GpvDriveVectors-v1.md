This page describes the drive information for each cycle.
# Strategies
## struct vector
The vector struct has a value, start position and end position for each driving vector. Then in the drive vectors class, it declared a queue that stores those driving vectors.
The struct type is defined in [[GPV-GpvTypes-v1#GpvDriveVector]]
## support a pop function
This function will return the single vector struct if current queue has item, if is empty, then return null, will not report any error because the return of null is used by callers to judge if current vectors queue is empty or not.
# class GpvDriveVectors
**prototype**
```
class GpvDriveVectors;
```
## contents
- [[#fields]]
- public APIs
	- [[#pop]]
	- [[#add]]
- private APIs
## fields
**prototype**
```
	local GpvDriveVector vectors[$];
```
## pop
API to pop item from `vectors[$]`, if queue is empty, then return null, else return item from `vectors.pop_front()`
**prototype**
```
	extern function GpvDriveVector pop();
```
**procedures**
```
function GpvDriveVector GpvDriveVectors::pop();
	if (vectors.size()==0) return null;
	return vectors.pop_front();
endfunction
```
## add
API to add one vector information to vectors queue. Input information is start position, end position and the value.
**prototype**
```
	extern function void add(int s,int e,GpvVectorType val);
```
**procedures**
```
function void GpvDriveVectors::add(int s,int e,GpvVectorType val);
	GpvDriveVector v = {val,s,e};
	vectors.push_back(v);
endfunction
```