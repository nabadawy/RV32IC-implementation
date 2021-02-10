`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_BranchControl.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module based on the signals of Func_3, jump, branch, zero_flag,carry,
*  overflow, and the sign we deside which branch will be executed.
* Change history: 23/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/


module BranchCONTROL(
input [2:0] func3,
input branch, 
input zero, 
input carry, 
input Overflow, 
input sign, 
output reg branch_out );
 
always @(*)
begin
if (branch)
begin
case (func3)

3'b000: begin      //BEQ
if (zero)
branch_out=1'b1;
end

3'b001:   begin              //BNE
if (~zero)
branch_out=1'b1;
end

3'b100:   begin              //Blt
if (sign!= Overflow)
branch_out=1'b1;
end

3'b101:   begin              //BGE
if (sign == Overflow)
branch_out=1'b1;
end

3'b110:   begin              //BltU
if (~carry)
branch_out=1'b1;
end

3'b111:   begin              //BGEU
if (carry)
branch_out=1'b1;
end

endcase

end 

else if (branch ==0) branch_out= 1'b0;
end

endmodule
