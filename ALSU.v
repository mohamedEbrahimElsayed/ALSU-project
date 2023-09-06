module ALSU (a,b,opcode,cin,clk,rst,serialin,red_op_a,red_op_b,bypass_a,bypass_b,direction,leds,out);
parameter input_priority="A";
parameter full_adder="ON";
input [2:0] a,b,opcode;
input cin,clk,rst,serialin,red_op_a,red_op_b,bypass_a,bypass_b,direction;
output reg [15:0] leds;
output reg [5:0] out;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		leds<= 'b0;
		out <= 'b0;
		
	end
	else begin
		if (bypass_a && bypass_b) begin
			out <=(input_priority =="A")? a:b;
			leds<= 'b0;
		end
		else if(bypass_a)begin
			out<= a;
			leds<= 'b0;
		end
		else if(bypass_b)begin
			out<= b;
			leds<= 'b0;
		end
		else begin
			case(opcode)
				3'h0:begin
					if(red_op_a && red_op_b)
						out <= (input_priority == "A")? &a:&b;
					if(red_op_a)begin
						out <= &a;
						leds<= 'b0;
					end
					if(red_op_b)begin
						out <= &b;
						leds<= 'b0;
					end
					else begin
						out <= a & b;
						leds <= 'b0;
					end
				end
				3'h1:begin
					if(red_op_a && red_op_b)
						out <= (input_priority == "A")? ^a:^b;
					if(red_op_a)begin
						out <= ^a;
						leds<= 'b0;
					end
					if(red_op_b)begin
						out <= ^b;
						leds<= 'b0;
					end
					else begin
						out <= a ^ b;
						leds <= 'b0;
					end
				end
				3'h2: begin 
					if(full_adder == "ON")begin
						out <= a + b +cin;
						leds <= 'b0;
					end
					else begin
						out <= a + b;
						leds <= 'b0;
					end
				end
				3'h3:begin
					out <= a * b;
					leds <= 'b0;
				end
				3'h4:begin
					if(direction)begin
						out<= {out[4:0],serialin};
						leds<= 'b0;
					end
					else begin
						out<= {serialin,out[5:1]};
						leds<= 'b0;
					end
				end
				3'h5:begin
					if(direction)begin
						out<= {out[4:0],out[5]};
						leds<= 'b0;
					end
					else begin
						out<= {out[0],out[5:1]};
						leds<= 'b0;
					end
				end
				3'h6:begin
					out<= 'b0;
					leds<= ~leds;
				end
				3'h7:begin
					out<= 'b0;
					leds<= ~leds;
				end
			endcase
		end
	end
end
		 
endmodule