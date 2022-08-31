`ifndef GpvInterface__sv
`define GpvInterface__sv

interface GpvInterface#(VECTOR_WIDTH=4096) (input logic clk, input logic rstn); // {

	logic [VECTOR_WIDTH-1:0] vector;

	task sync();
		@(posedge clk);
	endtask

	task driveVector(
		logic [`GpvVectorMaxWidth-1:0] val,
		int startPos, int endPos
	); // {
		int width = endPos-startPos+1;
		if (width == 1)
			vector[startPos] = val[0];
		else begin
			for (int _l=0;_l<width;_l++)
				vector[startPos+_l] = val[_l];
		end
	endtask // }

	task drive(
		string name,
		logic [`GpvVectorMaxWidth-1:0] val,
		int startPos, int endPos
	); // {
		case(name)
			"vector": driveVector(val,startPos,endPos);
			default: $display("not support name: ",name);
		endcase
	endtask // }

endinterface // }

`endif
