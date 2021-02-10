`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_Pc_Control.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module we sellect the next PC from a tow bit sellect line 
* the choose if it is going to be pc+4 or branch_pc or jalr_pc
* Change history: 28/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/


module pc_control(
input [1:0] select, 
input [31:0]Pc_plus_4,
input [31:0] branch_pc,
input [31:0] jalR_pc, 
output reg [31:0] pc_select );
 
 always@(*)
 begin
 case(select)
 2'b00: pc_select= Pc_plus_4;
 2'b01: pc_select= branch_pc;
 2'b10:pc_select= jalR_pc; 
endcase
end 


endmodule
