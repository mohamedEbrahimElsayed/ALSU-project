module DSP(clk,rst_n,a,b,c,d,p);
parameter OPERATION= "ADD";
input clk,rst_n;
input [17:0] a,b,d;
input [47:0] c;
output reg [47:0] p;
reg [47:0] out;
reg [47:0] multiplier_out;
reg [17:0] add_sub_out;

always @(*)begin
	if (OPERATION == "ADD") begin
		add_sub_out= d + b;
		multiplier_out= add_sub_out * a;
		out= multiplier_out + c;
	end
	else if(OPERATION == "SUBTRACT")begin
		add_sub_out= d - b;
		multiplier_out= add_sub_out * a;
		out= multiplier_out - c;
	end
end

always @(posedge clk) begin
	if (~rst_n) 
		p<= 'b0;
	else 
		p<= out;
end
endmodule