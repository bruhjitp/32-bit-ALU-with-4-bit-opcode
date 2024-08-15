`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2024 11:24:01
// Design Name: 
// Module Name: ALU_32_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU_32_tb;
//Inputs
 reg signed [31:0] A,B;
 reg [3:0] ALU_OP;

//Outputs
 wire[31:0] ALU_Out, APSR;
 
 integer i;
 ALU_32 test_unit(
            A,B,                 
            ALU_OP,
            ALU_Out,
            APSR
     );
    initial
    begin
      A = 32'h0A;
      B = 32'h02;
      ALU_OP = 4'h0;
      
      for (i=0;i<=15;i=i+1) //loops through all the op codes
      begin
      #10;
      ALU_OP = ALU_OP + 8'h01;
      end;
      
      #10;
      A = 0;
      B = 0;
      ALU_OP=0;
      #10;
      
      A=32'hffffffff;
      B=32'hffffffff;
      ALU_OP=0;
      #10;
      
      $finish;
    end
endmodule
