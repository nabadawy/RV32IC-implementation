`timescale 1ns / 1ps
/*******************************************************************
*
* Module: DataPath.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: D-Flip-Flop with Reset  
* Change history: 08/10/19 - creat the module
* 28/10/19 - Added comments and follow guidelines
*
*******************************************************************/

 
module D_Flip_Flop(input clk, input rst, input D, output reg Q );

always @ (posedge clk or posedge rst)
 if (rst) begin
 Q <= 1'b0;
 end else begin
 Q <= D;
 end

endmodule
