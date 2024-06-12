`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/29 23:34:16
// Design Name: 
// Module Name: ALU8
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


module ALU8(
    output reg [7:0] result, //8λ������
    output reg zero, //���Ϊ0��־λ
    input [7:0] a, //8λ�������룬�͵�ALU�˿�A 
    input [7:0] b, //8λ�������룬�͵�ALU�˿�B 
    input [3:0] aluctr //4λALU���������ź�
    );
    wire cout;
    wire cin = 0;
    wire ZF;
    wire [7:0] sum, sub;
    Adder8 add(a, b, cin, sum, ZF, cout);
    Adder8 add1(a, -b, cin, sub, ZF, cout);
    always @(*) begin
        case (aluctr)
            4'b0000: result = sum;
            4'b0010: result = (a < b) ? 0 : 1;
            4'b0011:
                begin
                    if (a[7] == 0 && b[4] == 0) result = (a < b) ? 0 : 1;
                    else if (a[4] == 0 && b[4] == 1) result = 1;
                    else if (a[4] == 1 && b[4] == 0) result = 0;
                    else result = (a < b) ? 1 : 0;
                end
            4'b0110: result = a | b;
            4'b1000: result = sub;
            4'b1111: result = b;
            default: result = 0;
        endcase
        if (result == 0) zero = 1;
        else zero = 0;
    end
endmodule
