`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_RCA.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: this module that sum two numbers that arr more that one bit 
* and get the sum and the carry as outputs
* Change history: 23/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module RCA( 
input [31:0] A,
input [31:0] B , 
output [31:0] sum , 
output carry  );

wire [31:0] cout;
assign cout[0]= 0;
genvar i;

generate
for (i=0; i<32; i= i+1)
begin
FullADDER FA( A[i], B[i],cout[i], sum[i], cout [i+1] );
end
endgenerate

assign carry = cout[32];
endmodule
