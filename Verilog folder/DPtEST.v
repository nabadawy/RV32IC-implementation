`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 11:01:26 AM
// Design Name: 
// Module Name: DPtEST
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DPtEST();
reg clk, rst;

 DataPath pipe (clk,rst);

always begin
#10 clk= ~clk;
end

initial begin 

clk= 0;
rst=1;


#11

rst=0;

#20;
end
endmodule
