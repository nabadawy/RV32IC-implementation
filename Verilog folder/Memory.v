`timescale 1ns / 1ps
/*******************************************************************
*
* Module: Memory.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: this Module work with both data memory 
*and instruction memory so we can store or load any thing from the 
*data_memory the memory also, here we can initialize some values in 
*a specific memory location also we get the address of the instruction
* that should be fetched in the instruction memory to have the instruction 
*
* Change history: 07/11/19 - creat the module
* 11/11/19 - still working on it
*
*******************************************************************/


module Memory(
input clk,
input MemRead, 
input MemWrite,
input [11:0] address,
input [2:0] func3 , 
input [31:0] data_in,  // data which we want to store  
output  reg [31:0] mem_out
  );
  
reg [7:0] mem [0:(4*1024-1)];  
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
integer i;
    initial begin
        for (i = 0;i<4*1024; i = i +1)begin
            mem[i]=0;
        end
        
        
      //  $readmemh("E:/Fall 19/arch/New folder/Branch.hex", mem); 
      

       
mem[0]=8'b00011001; mem[1]=8'b0000_0000; mem[2]=8'b0_010_0000; mem[3]=8'b1_0000011; //lw x1, 400(x0)

mem[4]=8'b00011001; mem[5]=8'b0100_0000; mem[6]=8'b0_010_0001; mem[7]=8'b0_0000011 ; //lw x2, 404(x0)

mem[8]=8'b0000000_0; mem[9]=8'b0010_0000; mem[10]=8'b1_110_0010; mem[11]=8'b0_0110011 ; //or x4, x1, x2


mem[12]=8'b00011001; mem[13]=8'b1000_0000; mem[14]=8'b0_010_0001; mem[15]=8'b1_0000011 ; //lw x3, 408(x0)

mem[16]=8'h00; mem[17]=8'h32; mem[18]=8'h04; mem[19]=8'h63; //beq x4, x3, 8


mem[20]=8'b0000000_0; mem[21]=8'b0010_0000; mem[22]=8'b1_000_0001; mem[23]=8'b1_0110011 ; //add x3, x1, x2

mem[24]=8'b0000000_0; mem[25]=8'b0010_0001; mem[26]=8'b1_000_0010; mem[27]=8'b1_0110011 ; //add x5, x3, x2

mem[28]=8'b0001100_0; mem[29]=8'b0101_0000; mem[30]=8'b0_010_1110; mem[31]=8'b0_0100011; //sw x5, 412(x0)

mem[32]=8'b00011001; mem[33]=8'b1100_0000; mem[34]=8'b0_010_0011; mem[35]=8'b0_0000011 ; //lw x6, 412(x0)

mem[36]=8'b0000000_0; mem[37]=8'b0001_0011; mem[38]=8'b0_111_0011; mem[39]=8'b1_0110011 ; //and x7, x6, x1

mem[40]=8'b0100000_0; mem[41]=8'b0010_0000; mem[42]=8'b1_000_0100; mem[43]=8'b0_0110011 ; //sub x8, x1, x2

mem[44]=8'b0000000_0; mem[45]=8'b0010_0000; mem[46]=8'b1_000_0000; mem[47]=8'b0_0110011 ; //add x0, x1, x2

mem[48]=8'b0000000_0; mem[49]=8'b0001_0000; mem[50]=8'b0_000_0100; mem[51]=8'b1_0110011 ; //add x9, x0, x1

mem[52]=8'b0000000_0; mem[53]=8'b0000_0000; mem[54]=8'b0_000_0000; mem[55]=8'b0_0110011 ; //add x0, x0, x0
     
     
       //here you can edit the data in the memory
mem[400]= 8'd17;
mem[401]= 8'd0;
mem[402]= 8'd0;
mem[403]= 8'd0;
       
mem[404]= 8'd9;
mem[405]= 8'd0;
mem[406]= 8'd0;
mem[407]= 8'd0;

mem[408]= 8'd25;
mem[409]= 8'd0;
mem[410]= 8'd0;
mem[411]= 8'd0;
        end
        
        // memory to be written 
//end 

////////////////////////////////////////read instruction///////////////////////////////////////
  always @(*) 
  begin 
  if (clk)
  mem_out= {mem[address],mem[address+1],mem[address+2],mem[((address)+3)]};
  
  ///////////////////////////////////read data/////////////////////////////////////////////
  if ((clk ==0 )&& (MemRead ==1))
  begin 
  case(func3)
   3'b000: mem_out = {{24{last_byte8}}, {mem[address]}};    //lB
   3'b001: mem_out = {{16{last_byte16}},mem[byte1], mem[address]};    //LH
   3'b010: mem_out = {mem[address+3], mem[address+2],mem[address+1], mem[address]};       //lw 
   3'b100: mem_out= {24'b0, mem[address]};     //LBU
   3'b101: mem_out= {16'b0,mem[byte1], mem[address]};  // LHU
   default: mem_out=0;
   endcase
  end 
  
  end 
  
  ////////////////////////////////write the data///////////////////////////////// 
  always @(negedge clk)
  begin 
  if ( (clk ==0 )&& (MemWrite ==1))
  
  begin 
  case(func3)
    3'b000: mem[address] = data_in[7:0];    //SB
    
    3'b001: begin 
    mem[address] = data_in[7:0];   //SH
    mem[byte1] = data_in[15:8];
    end 
    
    3'b010:begin
    mem[address] = data_in[7:0];       //Sw 
    mem[byte1] = data_in[15:8];
    mem[byte2] = data_in[23:16];
    mem[byte3] = data_in[31:24];
     end 
    endcase
    end
   
 end 
  
endmodule
