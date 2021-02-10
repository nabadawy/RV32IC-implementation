`timescale 1ns / 1ps
`include "defines.v"
/***********************
*
* Module: module_Instruction_Memory.v
* Project: Archetchture_project
* Author: Mariam Abulela     900141674
          Nada Badawy        900171975
          Mohamed Al-Awadly  900163100
* Description: in this module we set all the controle segnals based on the OPCODE 
*of each Format
*
* Change history: 24/9/19 – creat the module
* 28/10/19 – Edit the module 
*
************************/

module controlU( 
input [`IR_opcode]Inst,
input wire bit20, 
output reg Branch, 
output reg memread, 
output reg memtoreg, 
output  reg [1:0] ALUOP, 
output reg memwrite, 
output reg ALUsre, 
output reg RegWrite,
output reg  [1:0] Jump,
output reg stop);

always @(*)

begin
if (Inst[`IR_opcode] == `OPCODE_Arith_R)  // R-format
begin
 Branch =1'b0;
 memread= 1'b0;
 memtoreg= 1'b0;
 ALUOP= 2'b10;
 memwrite= 1'b0;
 ALUsre = 1'b0;
 RegWrite= 1'b1;
 Jump= 2'b00;
 stop=1'b0;
 
end
else if (Inst[`IR_opcode] == `OPCODE_Load )   // LOAD _I-Format
begin
 Branch =1'b0;
 memread= 1'b1;
 memtoreg= 1'b1;
 ALUOP= 2'b00;
 memwrite= 1'b0;
 ALUsre = 1'b1;
 RegWrite= 1'b1;
 Jump= 2'b00;
 stop=1'b0;
end
else if (Inst[`IR_opcode]== `OPCODE_Arith_I)    // I-Format --> link to R
begin 

Branch =1'b0;
memread= 1'b0;
memtoreg= 1'b0;
ALUOP= 2'b10;
memwrite= 1'b0;
ALUsre = 1'b1;
RegWrite= 1'b1;
Jump= 2'b00;
stop=1'b0;
end

else if (Inst[`IR_opcode] == `OPCODE_Store)   // store-Format
begin
 Branch =1'b0;
 memread= 1'b0;
 memtoreg= 1'b1;
 ALUOP= 2'b00;
 memwrite= 1'b1;
 ALUsre = 1'b1;
 RegWrite= 1'b0;
 Jump= 2'b00;
 stop=1'b0;
end

else if (Inst[`IR_opcode] == `OPCODE_Branch)   // Branch- Format
begin
 Branch =1'b1;
 memread= 1'b0;
 memtoreg= 1'b1;
 ALUOP= 2'b01;
 memwrite= 1'b0;
 ALUsre = 1'b0;
 RegWrite= 1'b0;
 Jump= 2'b01;
  stop=1'b0;
end
else if (Inst[`IR_opcode] == `OPCODE_JALR )  // Jalr 

begin
 Branch =1'b0;
 memread= 1'b0;
 memtoreg= 1'b0;
 ALUOP= 2'b00;
 memwrite= 1'b0;
 ALUsre = 1'b1;
 RegWrite= 1'b1;
 Jump= 2'b10;
 stop=1'b0;
end
else if (Inst[`IR_opcode] == `OPCODE_JAL)  //Jal
begin
 Branch =1'b0;
 memread= 1'b0;
 memtoreg= 1'b0;
 ALUOP= 2'b00;
 memwrite= 1'b0;
 ALUsre = 1'b1;
 RegWrite= 1'b1;
 Jump= 2'b01;
 stop=1'b0;
end
else if (Inst[`IR_opcode] == `OPCODE_LUI)  // LUI 

begin
 Branch =1'b0;
 memread= 1'b0;
 memtoreg= 1'b0;
 ALUOP= 2'b01;
 memwrite= 1'b0;
 ALUsre = 1'b1;
 RegWrite= 1'b1;
 Jump= 2'b00;
 stop=1'b0;
 end
 else if (Inst[`IR_opcode] == `OPCODE_AUIPC )  // AUIPC
 
 begin
  Branch =1'b0;
  memread= 1'b0;
  memtoreg= 1'b0;
  ALUOP= 2'b00;
  memwrite= 1'b0;
  ALUsre = 1'b1;
  RegWrite= 1'b1;
  Jump= 2'b00;
  stop=1'b0;
  end
  
else if (Inst[`IR_opcode] == `OPCODE_SYSTEM )  // ecall ebreak

begin
    if (bit20) begin
    Branch =1'b0;
    memread= 1'b0;
    memtoreg= 1'b0;
    ALUOP= 2'b00;
    memwrite= 1'b0;
    ALUsre = 1'b0;
    RegWrite= 1'b0;
    Jump= 2'b00;
     stop=1'b1;
     end
     else 
     begin
      Branch =1'b0;
        memread= 1'b0;
        memtoreg= 1'b0;
        ALUOP= 2'b00;
        memwrite= 1'b0;
        ALUsre = 1'b0;
        RegWrite= 1'b0;
        Jump= 1'b0;
         stop=1'b0;
         end
     end 
end


endmodule
