`ifndef rhTypes__svh
`define rhTypes__svh

typedef enum logic {
	RhResetUnknow   = 'bx,
	RhResetActive   = 'b0,
	RhResetInactive = 'b1
} RhResetState_enum;
`uvm_analysis_imp_decl(_reset)

`endif
