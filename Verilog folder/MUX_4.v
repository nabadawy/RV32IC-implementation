`timescale 1ns / 1ps
/*******************************************************************
*
* Module: MUX_4.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: it is the main module we give the value of the MUX based on the signal 
* from the forwarding_unit
*for the Risc-v processor 
* Change history: 31/10/19 - creat the module
*
*
*******************************************************************/


module MUX_4(
input [31:0] ID_EX_RS12_data, 
input [31:0] EX_Mem_Alu_out, 
input [31:0]Mem_WB_MUX, 
input [1:0] forwardAB, 
output reg [31:0] ALU_input);

always @(*)
begin
case(forwardAB)
2'b10: ALU_input = EX_Mem_Alu_out;
2'b01: ALU_input = Mem_WB_MUX;

default : ALU_input= ID_EX_RS12_data;
endcase
end
endmodule
