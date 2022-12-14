This page is an overview for vpilib, which is mainly planned for easy using of vpi function. Such as driveSignal to an interface etc.
This is the basic for building the UT level environment.
# ActionItems
- how to enable the vpilib by rhFlow? #TBD 

# Using Examples
## setup vpi base
- the base `$tbStart` and vpilib.cpp should be automatically setup;
- users can modify the entry API `tbStart()` in vpilib.cpp to add special actions;
- special required including files shall be added before using it at `tbStart()`;
- provide a `TBBase` class that users can create their own tbs based on it;
Code examples:
```cpp
// vpilib.cpp
#include<userClass.h>
void tbStart() {
	UserTB tb(xxx);
	tb.setup(xxx);
	...
	tb.start(xxx);
}
```
## separated libs
some of the lib files are separately included into user cases, which only depends on what users want to use. For example, the easy driving lib: `SignalDrive` class, or `TBBase` class.

# Features
- [[#vpi env enabled]]
- [[#vpi setup]]
- [[libs/cpp/vpi/src-tbBase]], #TBD 
- support drive/get/operate different signals/interfaces, [[src-signalAccess]], #TBD 
- support basic 4 type of state signal operation, [[libs/cpp/vpi/src-signal]], #TBD 
- 

# vpi env enabled
To run with vpilib, a certain environment should be enabled first.
**vpilib.cpp**
The main file to register the `$tbStart` task, so that it can be called at TB level. This file will be generated automatically by a certain flow. #TBD 
**Makefile**
a makefile will be used to execute commands, will be generated automatically by certain flow. #TBD 
**others**
other files a specific libs that can be called by user once it's been included, all other libs shall included into the base lib container: `vpilib.*`

## vpi setup
While using the vpilib, a main entry will be placed in the simulation environment. A container locates in `vpilib.*`, in which users shall setup base TB information before using the vpilib.
