module ALSU_tb();
parameter input_priority="a";
parameter full_adder="on";
reg [2:0] a,b,opcode;
reg cin,clk,rst,serialin,red_op_a,red_op_b,bypass_a,bypass_b,direction;
wire [15:0] leds;
wire [5:0] out;

ALSU #(input_priority,full_adder) dut(a,b,opcode,cin,clk,rst,serialin,red_op_a,red_op_b,bypass_a,bypass_b,direction,leds,out);

integer i=0;
initial begin
	clk=0;
	forever
	#1 clk=~clk;
end
initial begin
rst=0;
a=0;
b=0;
opcode=0;
cin=0;
serialin=0;
red_op_b=0;
red_op_a=0;
bypass_b=0;
bypass_a=0;
direction=0;
#50;
rst=1;
for(i=0;i<100 ;i=i+1)begin
a=$random;
b=$random;
opcode=$urandom_range(0,5);
cin=$random;
serialin=$random;
red_op_b=$random;
red_op_a=$random;
bypass_b=$random;
bypass_a=$random;
direction=$random;
@(negedge clk);
end
rst=0;
bypass_b=0;
bypass_a=1;
for(i=0;i<100 ;i=i+1)begin
a=$random;
b=$random;
opcode=$urandom_range(0,5);
cin=$random;
serialin=$random;
red_op_b=$random;
red_op_a=$random;
direction=$random;
@(negedge clk);
end
rst=0;
bypass_a=0;
direction=1;
red_op_b=0;
red_op_a=1;
for(i=0;i<100 ;i=i+1)begin
a=$random;
b=$random;
opcode=$urandom_range(0,5);
cin=$random;
serialin=$random;
@(negedge clk);
end
rst=0;
bypass_a=0;
direction=1;
red_op_b=0;
red_op_a=0;
for(i=0;i<100 ;i=i+1)begin
a=$random;
b=$random;
opcode=$urandom_range(0,5);
cin=$random;
serialin=$random;
@(negedge clk);
end
rst=0;
bypass_a=0;
direction=1;
red_op_b=0;
red_op_a=0;
for(i=0;i<100 ;i=i+1)begin
a=$random;
b=$random;
opcode=$urandom_range(5,7);
cin=$random;
serialin=$random;
@(negedge clk);
end
#1 $stop;
end
endmodule
