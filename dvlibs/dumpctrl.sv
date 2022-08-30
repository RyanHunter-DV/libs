// this module must been compiled by sv
module dumpctrl(); // {

	`ifdef VCS
	string simulator="vcs";
	`else
	string simulator="xrun";
	`endif

	initial begin // {
		case (simulator) // {
			"xrun": begin // {
				$shm_open("test.shm");
				$shm_probe(tb_top,"AS");
			end // }
		endcase // }
	end // }

endmodule // }
