`timescale 1ns / 1ps
/*******************************************************************
*
* Module: T_flip_flop.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: this is a module f a T_flip_flop thay takes
*a fast clock and give a slow clock
*for the Risc-v processor 
* Change history: 07/11/19 - creat the module
* 
*
*******************************************************************/

module T_flip_flop
(input clk, 
 output reg Q );
 reg T;
    initial T=0;
    always @(posedge clk)
        begin
            Q=~T;
            T=Q;
         end
    
endmodule


