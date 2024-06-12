`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/19 10:08:48
// Design Name: 
// Module Name: multi_u_tst
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


module multi_y_tst( );
    reg clk; //оƬ��ʱ���źš�
    reg rst_n; //�͵�ƽ��λ�������źš�����Ϊ 0 ��ʾоƬ��λ������Ϊ 1 ��ʾ��λ�ź���Ч��
    reg in_valid; //оƬʹ���źš�����Ϊ 0 ��ʾ�ź���Ч������Ϊ 1 ��ʾоƬ��������ܽŵó����ͱ������������˻���λ���㡣reg[7:0] x; //���� a������������������λ��Ϊ 16bit.
    reg[7:0] x; //���� a������������������λ��Ϊ 8bit.
    reg[7:0] y; //���� b����������������λ��Ϊ 8bit.
    wire[15:0] p; //�˻������������λ��Ϊ 16bit.
    wire out_valid; //�˷�������ɱ�־λ
    multi_8y uut( .x(x),.y(y),.p(p), .clk(clk),.rst_n(rst_n),.in_valid(in_valid),.out_valid(out_valid));
    initial begin
        clk = 0;
        forever 
        #5 clk = ~clk; //??50MHZ???
    end
    initial begin
        rst_n = 1'b0;
        in_valid=1'b0;
        x = 8'h5a;
        y = 8'h87;
        #10
        rst_n = 1'b1; //�ϵ�� 1us ��λ�ź�
        in_valid=1'b1;
        #100;
        rst_n = 1'b0; //�ϵ�� 1us ��λ�ź�
        in_valid=1'b0;
        x = 8'h87;
        y = 8'h5a;
        #10;
        rst_n = 1'b1; //�ϵ�� 1us ��λ�ź�
        in_valid=1'b1;
        #100;
        rst_n = 1'b0;
        in_valid=1'b0;
        x = 8'h0f;
        y = 8'h0f;
        #10;
        rst_n = 1'b1;
        in_valid=1'b1;
        #100;
        rst_n = 1'b0;
        in_valid=1'b0;
        x = 8'hff;
        y = 8'hff;
        #10;
        rst_n = 1'b1;
        in_valid = 1'b1; //�ϵ�� 1us ��λ�ź�
        #100;
        $stop;
    end
endmodule
