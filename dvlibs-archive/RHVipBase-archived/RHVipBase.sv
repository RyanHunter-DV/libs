`ifndef RHVipBase__sv
`define RHVipBase__sv

package RHVipBase; // {

	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "rhstd.svh"

	`include "VipBaseTypes.svh"
	`include "VipResetTrans.svh"
	`include "VipResetHandler.svh"
	`include "VipMonitorBase.svh"
	`include "VipDriverBase.svh"
	`include "VipSeqrBase.svh"
	`include "VipAgentBase.svh"
	`include "VipEnvBase.svh"



endpackage // }

`endif
