`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/11 13:23:40
// Design Name: 
// Module Name: digitalclk
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


module digitalclk(
    input clk,
    input rst, //��λ����Ч��00:00:00
    input ld, // =1ʱ���������ó�ֵ��=0ʱ��������ʱ
    input set_h, //��ť���º�����Сʱ��ֵ
    input set_m, //��ť���º����÷��ӳ�ֵ
    input set_s, //��ť���º�����������ֵ
    input [3:0] data_h, //���ó�ֵ��λ��ʹ��BCD���ʾ
    input [3:0] data_l, //���ó�ֵ��λ��ʹ��BCD���ʾ
    output reg [6:0] segs, //�߶����������ֵ����ʾ����
    output reg [7:0] an, //�߶�����ܿ���λ������ʱ���֡���
    output reg [2:0] ledout //���3ɫָʾ��
    );
    reg [7:0] h;
    reg [7:0] m;
    reg [7:0] s;
    reg [30:0] cnt;
    reg [3:0] sh;
    reg [3:0] sl;
    reg [3:0] mh;
    reg [3:0] ml;
    reg [3:0] hh;
    reg [3:0] hl;
    reg [2:0] pos;
    reg [3:0] dig;
    always @ (posedge clk) begin
        if (rst) begin h <= 0; m <= 0; s <= 0; cnt <= 0; end
        else if (ld)
            begin
                if (set_h) h <= data_h * 10 + data_l;
                if (set_m) m <= data_h * 10 + data_l;
                if (set_s) s <= data_h * 10 + data_l;
                cnt <= cnt + 1;
            end
        else if (cnt >= 100000000)
            begin
                cnt <= 0;
                if (s == 59)
                    begin
                        s <= 0;
                        if (m == 59)
                            begin
                                m <= 0;
                                if (h == 23) h <= 0;
                                else h <= h + 1;
                            end
                        else m <= m + 1;
                    end
                else s <= s + 1;
            end
        else cnt <= cnt + 1;
    end
    always @ (*) begin
        an = 8'b11111111;
        pos <= cnt[14:12];
        an[pos] = 0;
        case (pos)
            0: dig <= s[7:0] % 10;
            1: dig <= s[7:0] / 10;
            3: dig <= m[7:0] % 10;
            4: dig <= m[7:0] / 10;
            6: dig <= h[7:0] % 10;
            7: dig <= h[7:0] / 10;
            default: dig <= 10;
        endcase
        case (dig)
	       0: segs = 7'b1000000;
		   1: segs = 7'b1111001;
	       2: segs = 7'b0100100;
	       3: segs = 7'b0110000;
	       4: segs = 7'b0011001;
	       5: segs = 7'b0010010;
	       6: segs = 7'b0000010;
	       7: segs = 7'b1111000;
	       8: segs = 7'b0000000;
	       9: segs = 7'b0010000;
	       default: segs = 7'b1111111;
	    endcase
        if (s < 5 && m == 0) ledout = 1 << (cnt % 3);
        else ledout = 0;
    end
endmodule
