`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:59 09/26/2020 
// Design Name: 
// Module Name:    processor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module processor(
    input clk,
    input rst_n,
    input rvalid,
    //output reg [31:0] addr,
	 output reg [0 : 31] addr,
    input [31:0] data
    );

//addr
/*always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		addr <= 0;
	end
	
	else if(addr == 124 && rvalid == 1)
	begin
		addr <= 0;
	end
	
	else if(rvalid == 1)
	begin
		addr <= addr + 4;
	end
end*/

//
reg [0 : 31] instr [0 : 9];
reg [3 : 0] instr_cnt;
always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		$readmemh("Instructions.mem", instr);
	end
end

always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		addr <= instr[0][0 : 31];
	end
	
	else if(instr_cnt == 9 && rvalid == 1)
	begin
		addr <= instr[0][0 : 31];
	end
	
	else if(rvalid == 1)
	begin
		addr <= instr[instr_cnt + 1][0 : 31];
	end
end

always@(posedge clk)
begin
	if(rst_n == 0)
	begin
		instr_cnt <= 0;
	end
	
	else if(instr_cnt == 9 && rvalid == 1)
	begin
		instr_cnt <= 0;
	end
	
	else if(rvalid == 1)
	begin
		instr_cnt <= instr_cnt + 1;
	end
end

endmodule
