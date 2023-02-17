`timescale 1ns / 1ns
`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | A1 = %b, A2= %b, A3= %b, NT= %b, out = %b"

module Lab2_1_tb();
	reg in1,in2;
	wire out;
	// wire A1, A2,A3, NT;
        Lab2_1 UUT (in1,in2, out);
	
	initial begin
        	$monitor (`MONITOR_STR_1, $time,in1,in2, UUT.A1, UUT.A2,UUT.A1, UUT.NT,
	 				out);
	end
 	initial begin
        $vcdpluson; // for graphical view
	#15 in1 = 1'b0;
	    in2 = 1'b0;
	#15 in1 = 1'b0;
	    in2 = 1'b1;

	#15 in1 = 1'b1;
	    in2 = 1'b0;
	#15 in1 = 1'b1;
	    in2 = 1'b1;
	#15 $finish;
	end
endmodule
