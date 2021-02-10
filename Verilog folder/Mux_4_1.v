`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_Mux_4_1.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module we sellect the Outpot of the J and U instructions that 
*will be weitten the in the Rd_Register based on a two bit sellect input
*
* Change history: 27/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/


module Mux_4_1(
input [31:0] in1,
input [31:0] in2,
input [31:0] in3,
input [31:0] in4, 
input [1:0] sel, 
output reg [31:0] out);
  always @(*)
begin
case(sel)
2'b00 : out= in1;   //JAL/JALR
2'b01 : out= in2;   // AUIPC
2'b10 : out= in3;    //LUI
2'b11 : out= in4;   //MEM-MUX

endcase
end
endmodule
