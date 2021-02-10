`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_MUX.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: Mux that select its output based on the signal of the load
*
* Change history: 07/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module MUX #(parameter n=32) ( 
input [n-1:0] a, 
input [n-1:0] b, 
input load, 
output [n-1:0] O);

assign O= load ? a: b;

endmodule