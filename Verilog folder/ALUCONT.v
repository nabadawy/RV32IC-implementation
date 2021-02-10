`timescale 1ns / 1ps
`include "defines.v"
/*******************************************************************
*
* Module: module_ALU_CONTROL.v
* Project: Arch_ptoject
* Author: Mariam Abul-Ela    Email: mariam-a
          Nada Ebrahim       Email: nadabadawy
          Mohamed El-Awadly  Email: MohamedElAwadly
* Description: in this module we select the operation that the ALU shold do based on the 
* ALU_OP and Func_3 and bit # 30 in the instruction
* Change history: 24/09/17 - Did something
* 10/29/17 - Did something else
*
*******************************************************************/


module ALUCONT(
input [1:0] ALUOP, 
input [`IR_funct3] INST ,
input INST30, 
output reg [3:0]ALUS);

always @(*)

begin
if (ALUOP[1:0] == 2'b00 || (ALUOP[1:0] == 2'b10 &&   (INST==`F3_ADD) && INST30== 0))
 ALUS= `ALU_ADD;// add
 
 if ( (ALUOP[1:0] == 2'b10) &&  ( INST==`F3_ADD ))
  ALUS= `ALU_ADD;// addI
 
if (ALUOP[1:0] == 2'b01 ||(ALUOP[1:0] == 2'b10 &&  (INST==`F3_ADD) && INST30== 1) )
    ALUS= `ALU_SUB; //sub
 
if (ALUOP[1:0] == 2'b10 &&   (INST==`F3_AND))
    ALUS= `ALU_AND; // and & andI
    
 
if (ALUOP[1:0] == 2'b10 &&  (INST== `F3_OR))
    ALUS= `ALU_OR; // or & orI
  
if (ALUOP[1:0] == 2'b10 &&  (INST== `F3_XOR))
    ALUS= `ALU_XOR; // xor & XORI
    
if (ALUOP[1:0] == 2'b10 &&  (INST==`F3_SRL) && INST30== 0)
    ALUS= `ALU_SRL; // srl & SRLI
    
        
if (ALUOP[1:0] == 2'b10 &&   (INST==`F3_SLL))
    ALUS= `ALU_SLL; // sll & sllI

if (ALUOP[1:0] == 2'b10 &&   (INST==`F3_SRL) && INST30== 1)
    ALUS= `ALU_SRA; // sra & ARAI
    

if (ALUOP[1:0] == 2'b10 &&   (INST==`F3_SLT))
    ALUS= `ALU_SLT; // slt & sltI
  
if ((ALUOP[1:0] == 2'b10) &&  ( INST==`F3_SLTU))
    ALUS= `ALU_SLTU; //   sltu & sltIu
end

endmodule
