module DSP_tb();
parameter OPERATION= "ADD";
reg clk,rst_n;
reg [17:0] a,b,d;
reg [47:0] c;
wire [47:0] p;
DSP #(OPERATION) dut(clk,rst_n,a,b,c,d,p);

integer i=0;
initial begin
	clk=0;
	forever
	#1 clk=~clk;
end
initial begin
rst_n=0;
a=0;
b=0;
c=0;
d=0;
#50;
rst_n=0;
for(i=0;i<100;i=i+1)begin
a=$random;
b=$random;
c=$random;
d=$random;
@(negedge clk);
if(p != 'b0)begin
$display("Erorr the out of DSP is incorrect");
$stop;
end
end
rst_n=1;
for(i=0;i<1000;i=i+1)begin
a=$random;
b=$random;
c=$random;
d=$random;
@(negedge clk);
end
#1 $stop;
end
endmodule