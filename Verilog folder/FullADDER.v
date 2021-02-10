`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_FullADDER.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: this module adds two single bits and gets the sum and the carry 
*
* Change history: 24/09/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module FullADDER(input A, input B, input Cin, output S, output Cout);
assign S= A^B^Cin ;
assign Cout = A & B | A & Cin | B& Cin ;
endmodule
