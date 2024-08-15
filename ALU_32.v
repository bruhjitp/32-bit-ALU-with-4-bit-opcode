`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2024 10:54:57
// Design Name: 
// Module Name: ALU_32
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


module ALU_32(
           input signed [31:0] A,B,                 
           input [3:0] ALU_OP, //4 bit ALU instructions
           output reg signed [31:0] ALU_Out,
           output reg [31:0]APSR // NZC flag:[31:29] || other bits reserved to 0
    );
    reg carry;
    always @(A|B|ALU_OP)
    begin
        case(ALU_OP) //instruction decode
        4'b0000: // Addition
           {carry,ALU_Out} = A + B ;
        4'b0001: // Subtraction
           {carry,ALU_Out} = A - B ;
        4'b0010: // Multiplication
           {carry,ALU_Out} = A * B;
        4'b0011: // Division
           {carry,ALU_Out} = A/B;
        4'b0100: // Logical shift left
           {carry,ALU_Out} = A<<1;
         4'b0101: // Logical shift right
           {carry,ALU_Out} = A>>1;
         4'b0110: // Rotate left
           {carry,ALU_Out} = {A[30:0],A[31]};
         4'b0111: // Rotate right
           {carry,ALU_Out} = {A[0],A[31:1]};
          4'b1000: //  Logical and 
           {carry,ALU_Out} = A & B;
          4'b1001: //  Logical or
           {carry,ALU_Out} = A | B;
          4'b1010: //  Logical xor 
           {carry,ALU_Out} = A ^ B;
          4'b1011: //  Logical nor
           {carry,ALU_Out} = ~(A | B);
          4'b1100: // Logical nand 
           {carry,ALU_Out} = ~(A & B);
          4'b1101: // Logical xnor
           {carry,ALU_Out} = ~(A ^ B);
          4'b1110: // Greater comparison
           {carry,ALU_Out} = (A>B)?32'd1:32'd0 ;
          4'b1111: // Equal comparison   
            {carry,ALU_Out} = (A==B)?32'd1:32'd0 ;
          default:
            {carry,ALU_Out} = 33'b0 ;
            
        endcase
    end
    always@(ALU_Out|carry)
        begin
        if(ALU_Out<0)
            APSR[31] = 1;  //Negative Flag
        else
            APSR[31] = 0;
        if(ALU_Out==0)
            APSR[30] = 1;  //Zero Flag
        else
            APSR[30] = 0;
        APSR[29] = carry;  //Carry Flag
        APSR[28:0]=29'b0;
        end
endmodule