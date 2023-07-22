`ifndef rhlib__svh
`define rhlib__svh

typedef enum bit{
	false = 1'b0,
	true  = 1'b1
} bool;

typedef bit[31:0]  uint32_t;
typedef bit[63:0]  uint64_t;
typedef bit[127:0] uint128_t;


`endif