`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/16 19:40:00
// Design Name: 
// Module Name: miliseconds
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


module miliseconds(
    input clk,
    input rst, //��λ����Ч��00:00:00
    input ps, //��ͣ
    output reg [6:0] segs, //�߶����������ֵ����ʾ����
    output reg [7:0] an //�߶�����ܿ���λ
    );
    reg [30:0] t;
    reg [30:0] cnt;
    reg [2:0] pos;
    reg [3:0] dig;
    always @ (posedge clk) begin
        if (rst) begin t <= 0; cnt <= 0; end
        else if (ps) cnt <= cnt + 1;
        else if (cnt >= 100000)
            begin
                cnt <= 0;
                t <= t + 1;
            end
        else cnt <= cnt + 1;
    end
    always @ (*) begin
        an = 8'b11111111;
        pos <= cnt[14:12];
        an[pos] = 0;
        case (pos)
            0: dig <= t[30:0] % 10;//ǧ��λ
            1: dig <= t[30:0] / 10 % 10;//�ٷ�λ
            2: dig <= t[30:0] / 100 % 10;//ʮ��λ
            4: dig <= t[30:0] / 1000 % 10;//��λ
            5: dig <= t[30:0] / 10000 % 10;//ʮλ
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
    end
endmodule
