`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_RIGF.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: gets the an imput of 32 bits and based on the load the output will be 
* the address of the instruction
* Change history: 08/10/19 - creat the module
* 28/10/19 - Added comments and follow guidelines
*
*******************************************************************/

module RIGF#(parameter n=32) 
(input clk, 
input load, 
input reset, 
input [n-1:0] in, 
output [n-1:0]Q);

genvar i;
wire D [n-1:0];
generate
for (i=0; i<n ; i=i+1 )
begin

MUX myM ( in[i], Q[i], load, D[i]);
D_Flip_Flop  myFF( clk, reset, D[i], Q[i]);

end

endgenerate

endmodule


