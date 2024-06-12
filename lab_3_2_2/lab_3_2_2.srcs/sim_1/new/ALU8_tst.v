`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/30 09:07:03
// Design Name: 
// Module Name: ALU8_tst
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


module ALU8_tst();
    wire [7:0] result; //8λ������
    wire zero; //���Ϊ0��־λ
    reg [7:0] a; //8λ�������룬�͵�ALU�˿�A 
    reg [7:0] b; //8λ�������룬�͵�ALU�˿�B 
    reg [3:0] aluctr; //4λALU���������ź�
    ALU8 ALU8_inst(.result(result),.zero(zero),.a(a),.b(b),.aluctr(aluctr));
    initial begin
        #10 begin a=8'h7f; b=8'h80; aluctr=4'b0000;end
        #100 aluctr=4'b0010;
        #100 aluctr=4'b0011;
        #100 aluctr=4'b0110;
        #100 aluctr=4'b1000;
        #100 aluctr=4'b1111;
        #100 begin a=8'h80; b=8'h7f; aluctr=4'b0010; end
        #100 aluctr=4'b0011; 
        #100 aluctr=4'b1000;
    end
endmodule
