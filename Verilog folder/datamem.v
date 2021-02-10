`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_Data_Memory.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: this Module work only with memory 
*so we can store or load any thing frm the memory 
*also, here we can initialize some values in a specific memory location
*
* Change history: 03/10/19 – creat the module
* 28/10/19 – Edit the module 
*
**********************************************************************/

module DataMem (
input clk, 
input MemRead, 
input MemWrite,
input [7:0] address,
input [2:0] func3 , 
input [31:0] data_in_Rs2, 
output reg [31:0] data_out);


 reg [7:0] mem [0:255];
 wire [7:0] transition_out1, transition_out2;
 wire [7:0] byte1;    
 wire [7:0] byte2;
 wire [7:0] byte3;
 wire last_byte8,last_byte16;
 assign transition_out1 = mem[address];
 assign transition_out2 = mem[address+1];

 assign byte1= address +1;
 assign byte2= address +2; 
 assign byte3= address +3;
assign last_byte8 = transition_out1[7];
assign last_byte16 = transition_out2[7];

initial begin
 mem [0]= 8'd2;
 mem [1]= 8'd0;
 mem [2]= 8'd0;
 mem [3]= 8'd0;
 
 mem [4]= 8'd3;
 mem [5]= 8'd0;
 mem [6]= 8'd0;
 mem [7]= 8'd0;
 
mem [8]= 8'd0;
mem [9]= 8'd0;
mem [10]= 8'd0;
mem [11]= 8'd0;

mem [12]= 8'd0;
mem [13]= 8'd0;
mem [14]= 8'd0;
mem [15]= 8'd0;
 
end 
 
 always @(posedge clk)
 begin
 if (MemWrite)
 begin 
  case(func3)
  3'b000: mem[address] = data_in_Rs2[7:0];    //SB
  
  3'b001: begin 
  mem[address] = data_in_Rs2[7:0];   //SH
  mem[byte1] = data_in_Rs2[15:8];
  end 
  
  3'b010:begin
  mem[address] = data_in_Rs2[7:0];       //Sw 
  mem[byte1] = data_in_Rs2[15:8];
  mem[byte2] = data_in_Rs2[23:16];
  mem[byte3] = data_in_Rs2[31:24];
   end 
  endcase
  end 
  end

always @(*)
begin
if (MemRead)
begin 
 case(func3)
 3'b000: data_out = {{24{last_byte8}}, {mem[address]}};    //lB
 3'b001: data_out = {{16{last_byte16}},mem[byte1], mem[address]};    //LH
 3'b010: data_out = {mem[address+3], mem[address+2],mem[address+1], mem[address]};       //lw 
 3'b100: data_out= {24'b0, mem[address]};     //LBU
 3'b101: data_out= {16'b0,mem[byte1], mem[address]};  // LHU
 default: data_out=0;
 endcase
 end  
 else data_out=0;
 end 
endmodule
