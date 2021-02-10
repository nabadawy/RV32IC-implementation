`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_SUBadd.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description:  this module take two numbers 32 bit and add them 
* then put the result in (sum)
* Change history: 24/09/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module subadd(
input [31:0] num1,
input [31:0] num2, 
output  [31:0] sum);
 
 reg [31:0] out;
  wire b = sum[31];
 wire s;
  
RCA NN ( num1, num2, sum, s);


 always @(*)
 begin

  if (b==1)
 
 out= ~sum +1;
 

 else
 begin
 
 out = sum;
 end
 end
 endmodule 