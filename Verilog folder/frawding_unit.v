`timescale 1ns / 1ps
/*******************************************************************
*
* Module: forwarding_unit.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: it is the main module check the condition of the forwarding
* if it is correct we get the two signals thet will be the sellection 
* in the Mux's in the EX stage with the ALU 
*for the Risc-v processor 
* Change history: 31/10/19 - creat the module
* 
*
*******************************************************************/

module forwarding_unit(
input  Mem_WB_regwrite , 
input [4:0] ID_EX_Rs1 ,
input [4:0] ID_EX_Rs2,  
input [4:0] Mem_WB_Rd, 
output  reg [1:0] forwardA, forwardB);

reg condition1, condition2; 

always @(*)
begin 

condition1= Mem_WB_regwrite &&  (Mem_WB_Rd!= 0) && (Mem_WB_Rd==ID_EX_Rs1 );
condition2= Mem_WB_regwrite &&  (Mem_WB_Rd!= 0) && (Mem_WB_Rd==ID_EX_Rs2);

// mem hazard

if (condition1 )
begin 
forwardA= 2'b01;
forwardB= 2'b00;
end
if (condition2 )
begin 
forwardA= 2'b00;
forwardB= 2'b01;
end 

if ((condition1) && (condition2))
begin 
forwardA= 2'b01;
forwardB= 2'b01;
end 

if( (!condition1) && (!condition2))
begin 
forwardA= 2'b00;
forwardB= 2'b00;
end
end 
endmodule
