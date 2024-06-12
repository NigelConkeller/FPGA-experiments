`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/12 09:49:08
// Design Name: 
// Module Name: digitalclk_tst
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


module digitalclk_tst();
    reg clk0;
    reg rst; //��λ����Ч��00:00:00
    reg ld; // =1ʱ���������ó�ֵ��=0ʱ��������ʱ
    reg set_h; //��ť���º�����Сʱ��ֵ
    reg set_m; //��ť���º����÷��ӳ�ֵ
    reg set_s; //��ť���º�����������ֵ
    reg [3:0] data_h; //���ó�ֵ��λ��ʹ��BCD���ʾ
    reg [3:0] data_l; //���ó�ֵ��λ��ʹ��BCD���ʾ
    wire [6:0] segs; //�߶����������ֵ����ʾ����
    wire [7:0] an; //�߶�����ܿ���λ������ʱ���֡���
    wire [2:0] ledout; //���3ɫָʾ��
    digitalclk digitalclk_inst(clk0, rst, ld, set_h, set_m, set_s, data_h, data_l, segs, an, ledout);
    always
        # 5 clk0 = ~clk0;
    initial begin
        rst = 0;
        #5
        clk0 = 0; rst = 1;
        #5
        rst = 0;
    end
endmodule
