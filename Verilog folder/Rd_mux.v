`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_Rd_Mux.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module we sellect the Outpot of the J and U instructions that 
* will be weitten the in the Rd_Register based on a two bit sellect input
* Change history: 24/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/


module Rd_mux(
input [31:0] jal_jalr,
input [31:0] auipc,
input [31:0] lui,
input [31:0] muxout, 
input [1:0] select, 
output reg [31:0] rd );

always @(*)
begin
case(select)
2'b00 : rd= jal_jalr;
2'b01 : rd= auipc;
2'b10 : rd= lui;
2'b11 : rd= muxout;
endcase
end


endmodule
