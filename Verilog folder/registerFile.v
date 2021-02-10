`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_registerFile.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this moudule we generat 32 register with width 32 bits
* and Gets the RD, RS1, RS2,and Write data and outputs both Read Datas
* Change history: 26/09/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module registerFile( 
input clk, 
input rst, 
input [4:0] read1, 
input [4:0] read2, 
input [4:0] write, 
input [31:0] data, 
input RW, 
output [31:0] Data1, 
output  [31:0] Data2);



// generate 32 register

genvar i;
wire [31:0] register [31:0] ;
wire [31:0]load ;


//write

assign load = RW ?( write?(1 << write) : 0) :0;
  
generate
for (i=0; i<32 ; i=i+1 )

RIGF   rr ( clk,  load[i] , rst, data ,register[i]);

endgenerate
// read 

assign Data1= register[read1];

assign Data2= register[read2];

endmodule
