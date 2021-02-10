`timescale 1ns / 1ps
`include "defines.v"


/*******************************************************************
*
* Module: DataPath.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: it is the main module where we call all of 
*our modules to generate the flow of the single cycle datapath 
*for the Risc-v processor 
* Change history: 08/10/19 - creat the module
* 28/10/19 - still working on it
*
*******************************************************************/

module DataPath(
input clk,
input rst);
//////////////wires/////////////////
//PC 
wire [31:0] Target_PC, address;
//wire [31:0] instruction ;

//CONTROL Signals 
wire [1:0] ALUop;     
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, stop;
wire [1:0]jump;
wire [3:0] ALU_select;

//RG
wire [31:0] Rs_1, Rs_2;
wire [31:0] write_data_rd;

// ALU 
wire [31:0]imm;
wire [31:0] Alu_second_source;
wire Carry_Flag,Zero_Flag,Overflow_Flag,Sign_Flag;
wire [31:0] ALU_out;

// MEMORY 
wire [31:0]Mem_Out;
wire [31:0] Alu_Memory_rd; 

// RD 
wire [1:0] select_RD;
wire [31:0] PC_Plus_4;     //pc+4
wire [31:0] PC_Branch;     //pc+ imm*2

// Branch control 
wire SELECT;     // to choose if it will branch or not 

// pc_selection 
wire [31:0]PC_Select, select_between_branch_and_pc4;

////////////////////////F_U_wires//////////////////
wire [1:0] forwardA, forwardB;
///////////////////////////// CLK //////////////////////////////////////////
wire S_clk;
T_flip_flop CL (clk, S_clk);


////////////////////////////////////pip-lined////////////////////////////////

///////////////////////////////////////////IF_ID/////////////////////////////
wire [31:0] PC_Plus_4_ID,address_ID,Mem_Out_ID, In_IF_instruction;


RIGF #(96)IF_ID(~S_clk, 1, rst, { PC_Plus_4,address,In_IF_instruction},{PC_Plus_4_ID,address_ID,Mem_Out_ID} );
MUX #(32)M (32'b0, Mem_Out,SELECT, In_IF_instruction); // mux to Flush the IF_ID register

////////////////////////////////ID_EX//////////////////////////////////////////////
wire Branch_EX,  MemRead_EX, MemtoReg_EX, MemWrite_EX,
 ALUSrc_EX, RegWrite_EX;
 wire [1:0] ALUop_EX, jump_EX; 
 wire [31:0]  address_EX, Rs_1_EX,  Rs_2_EX, imm_EX;
 wire [3:0] func3_EX;
 wire [4:0] RD_EX, Rs1_EX, Rs2_EX;
 
 
RIGF #(157)ID_EX (S_clk, 1, rst, {Branch,  MemRead, MemtoReg, ALUop, MemWrite,
 ALUSrc, RegWrite,jump, address_ID, Rs_1,  Rs_2, imm, Mem_Out_ID[30], Mem_Out_ID[`IR_funct3], Mem_Out_ID [`IR_rd],Mem_Out_ID[`IR_rs1],
 Mem_Out_ID[`IR_rs2]}, {Branch_EX,  MemRead_EX, MemtoReg_EX,ALUop_EX, MemWrite_EX,ALUSrc_EX, RegWrite_EX, jump_EX, 
 address_EX, Rs_1_EX,  Rs_2_EX, imm_EX,func3_EX, RD_EX,Rs1_EX, Rs2_EX});
 
 ////////////////////////////////////EX_Mem/////////////////////////////////////////
 wire Branch_MEM,  MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM;
 wire [1:0]  jump_MEM; 
 wire [31:0] PC_Branch_MEM, ALU_out_MEM, Rs_2_MEM; 
 wire Carry_Flag_MEM, Zero_Flag_MEM, Overflow_Flag_MEM, Sign_Flag_MEM; 
 wire [2:0] func3_MEM;
 wire [4:0] RD_MEM;
 wire Branch_EXX,  MemRead_EXX, MemtoReg_EXX, MemWrite_EXX, RegWrite_EXX;
 wire[1:0]jump_EXX;
 
 MUX #(7) stall(6'b0,{Branch_EX,  MemRead_EX, MemtoReg_EX, MemWrite_EX, RegWrite_EX, jump_EX}, SELECT,
 {Branch_EXX,  MemRead_EXX, MemtoReg_EXX, MemWrite_EXX, RegWrite_EXX, jump_EXX} );  // mux to set the conrol to Zeros while stalling
 
  RIGF #(115)EX_MEM (~S_clk, 1, rst, {Branch_EXX,  MemRead_EXX, MemtoReg_EXX, MemWrite_EXX, RegWrite_EXX, jump_EXX,PC_Branch
  , ALU_out, Carry_Flag, Zero_Flag, Overflow_Flag, Sign_Flag,Rs_2_EX,func3_EX[2:0], RD_EX },
  {Branch_MEM,  MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM,jump_MEM,
  PC_Branch_MEM, ALU_out_MEM, Carry_Flag_MEM, Zero_Flag_MEM, Overflow_Flag_MEM, Sign_Flag_MEM,
  Rs_2_MEM,func3_MEM, RD_MEM});
  
 ///////////////////////////////////////////MEM_WB/////////////////////////
wire MemRead_WB, MemtoReg_WB, MemWrite_WB, RegWrite_WB;
wire [31:0] ALU_out_WB, Mem_Out_WB;
wire [4:0] RD_WB;

RIGF #(73)MEM_WB (S_clk, 1, rst,{ MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM,ALU_out_MEM, Mem_Out,RD_MEM  },
{MemRead_WB, MemtoReg_WB, MemWrite_WB, RegWrite_WB,ALU_out_WB, Mem_Out_WB,RD_WB });

////////////////////////////////////PC////////////////////////////////////////

// update of the pc 

RIGF pc (S_clk, 1 ,rst, Target_PC, address);

/////////////////////////////////////////////////////////////////////////////
///////////////////////////////control signals /////////////////////////////


controlU Control_unit (Mem_Out_ID[`IR_opcode] ,Mem_Out_ID[20], Branch,  MemRead, MemtoReg, ALUop, MemWrite,
 ALUSrc, RegWrite,jump, stop);

ALUCONT alucontrol (ALUop_EX, func3_EX[2:0] ,func3_EX[3], ALU_select);
 ///////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////the reigster file ///////////////////////////

registerFile RG (~ S_clk, rst, Mem_Out_ID [`IR_rs1], Mem_Out_ID [`IR_rs2], RD_WB, 
write_data_rd , RegWrite_WB,  Rs_1,  Rs_2);
/////////////////////////////////////////////////////////////////////////////
////////////////////////////-----ALU------//////////////////////////////////

// calculating the immediate for each instruction
rv32_ImmGen immediate ( Mem_Out_ID, imm);


///////////////////////////////F_U////////////////////////////////////
 forwarding_unit F_U ( RegWrite_MEM , Rs1_EX, Rs2_EX,  RD_WB,  forwardA, forwardB);


wire [31:0] ALU_input_1, ALU_input_2;
MUX_4 F1( Rs_1, ALU_out_MEM, Alu_Memory_rd,  forwardA,  ALU_input_1);

MUX_4 F2( Rs_2, ALU_out_MEM, Alu_Memory_rd,  forwardB,  ALU_input_2);

// Mux which choose either the immediate or rs_2 for the second operant 
MUX ALU_mux (imm_EX, ALU_input_2, ALUSrc_EX, Alu_second_source);

ALU alu( ALU_input_1, Alu_second_source, ALU_input_2[4:0], ALU_out, Carry_Flag, Zero_Flag, 
Overflow_Flag, Sign_Flag, ALU_select );

////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////Memory//////////////////////////////////////////
wire [31:0] addr_mem;
MUX ADDR(address,ALU_out_MEM, S_clk,addr_mem );
Memory MEM(S_clk, MemRead_MEM, MemWrite_MEM,addr_mem[11:0] ,func3_MEM , Rs_2_MEM, Mem_Out);

// choosing from the memory or the ALU according to mem_to_reg signal 

MUX Write_mux (Mem_Out_WB , ALU_out_WB, MemtoReg_WB, Alu_Memory_rd);

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////RD_Selection///////////////////////////////////////////

subadd add1(imm_EX ,address_EX, PC_Branch);
subadd add2(`Four ,address, PC_Plus_4);

Rd_control write_data_control (Mem_Out_ID [`IR_opcode], select_RD);
Mux_4_1 write_data_select (PC_Plus_4_ID, PC_Branch_MEM,imm, Alu_Memory_rd, select_RD, write_data_rd);

/////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Branch_selection////////////////////////////////


BranchCONTROL branch(func3_MEM ,Branch_MEM ,Zero_Flag_MEM ,Carry_Flag_MEM ,Overflow_Flag_MEM, Sign_Flag_MEM, SELECT); 

//////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////PC_selection//////////////////////////////////////

//2x1 mux to choose from taking the branch or procede with the counter +4 
MUX PC_mux (PC_Branch_MEM , PC_Plus_4, SELECT, select_between_branch_and_pc4);

/*check jump signal and choose if the signals indicats JAL it will choose PC_Branch
if it indicats JALR it will choose ALU_out
*/
pc_control pc_s (jump_MEM, select_between_branch_and_pc4,PC_Branch_MEM, ALU_out_MEM, PC_Select);

//E-break to stop the counter 
MUX stop_pc_counter (address,PC_Select,stop,Target_PC);
/////////////////////////////////////////////////////////////////////////////////////////


endmodule



