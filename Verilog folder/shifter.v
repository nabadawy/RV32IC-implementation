`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_shifter.v
* Project: Arch_ptoject
* Author: Mariam Abul-Ela    Email: mariam-a
          Nada Ebrahim       Email: nadabadawy
          Mohamed El-Awadly  Email: MohamedElAwadly
* Description: in this module we get the RS1 and shift it by the shift amount based on the 
* the least segnificant tow bits in the ALU_sellect and put the result in the (out)
* Change history: 24/09/17 - Did something
* 10/29/17 - Did something else
*
*******************************************************************/

module shifter(
input[31:0] a, 
input [4:0]shamt, 
input [1:0] alufn, 
output reg [31:0] out);

always @(*)
begin
case(alufn)
2'b00 :out = a >> shamt; //SRL
2'b01 :out = a << shamt; //SLL
2'b10 :out = a >>> shamt; //SRA
default :out = 32'b0;
endcase
end
endmodule

 
