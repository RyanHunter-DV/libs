`ifndef rhGpvIf__sv
`define rhGpvIf__sv

interface RhGpvIf;
	logic [31:0] clock; // TMP, TODO
	logic [31:0] resetn; // TMP, TODO
	logic [`UVM_MAX_STREAMBITS-1:0] vector;
endinterface

`endif
