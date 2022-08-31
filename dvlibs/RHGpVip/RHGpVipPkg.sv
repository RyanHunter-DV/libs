`ifndef RHGpVipPkg__sv
`define RHGpVipPkg__sv

// global defines
`define GpvVectorMaxWidth 4096

`include "uvm_macros.svh"

`include "GpvInterface.sv"
package RHGpVipPkg;

	import uvm_pkg::*;
	import RHVipBase::*;

	`uvm_analysis_imp_decl(_gpvResp)

	`include "GpvSeqItem.svh"
	`include "GpvDriveVector.svh"
	`include "GpvDriveObjectBase.svh"
	`include "GpvInterfaceDefine.svh"
	`include "GpvDriveVectorPool.svh"
	`include "GpvDriveObject.svh"
	`include "GpvProtocoolBase.svh"
	`include "GpvDriver.svh"
	`include "GpvSeqr.svh"
	`include "GpvAgent.svh"
	
endpackage

`endif
