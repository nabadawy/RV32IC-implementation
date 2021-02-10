`timescale 1ns / 1ps
`include "defines.v"
/*******************************************************************
*
* Module: module_Rd_control.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module based on the OPCODE of the J and U instruction we determin 
* the two bit sellect line of J and U instruction which will sellect the Rd that will be taken 
* Change history: 04/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module Rd_control(
input [4:0] opcode, 
output reg [1:0] select);

always @(*)
begin

case (opcode)
`OPCODE_JALR : select = 2'b00;
`OPCODE_JAL : select= 2'b00;
`OPCODE_AUIPC : select = 2'b01;
`OPCODE_LUI  : select= 2'b10;
default: select= 2'b11;   // mux out 

endcase
end

endmodule
