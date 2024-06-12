`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/19 11:19:12
// Design Name: 
// Module Name: multi_8y
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


module multi_8y(
    input clk, //ʱ��
    input rst_n, //��λ�źţ�����Ч
    input [7:0] x, //������
    input [7:0] y, //����
    input in_valid, //=1��Чʱ���˷�����ʼ����
    output [15:0] p, //�˻�
    output out_valid //=1��Чʱ����ʾ�˷�����������
    );
    reg [3:0] cnt;
    always @ (posedge clk) begin
        if (!rst_n) cnt <= 7;
        //else if (rst_n) cnt <= 8;
        else if (in_valid && cnt != 0) cnt <= cnt - 1;
    end
    
    reg [6:0] rx, ry, rp;
    wire c;
    
    always @ (posedge clk) begin
        //if (!rst_n) {rp, ry, rx} <= 0;
        if (!rst_n) {rp, ry, rx} <= {7'b0, y[6:0], x[6:0]};
        else if (in_valid && cnt != 0) {rp, ry} <= {c, rp + (ry[0] ? rx : 0), ry} >> 1;
    end
    
    assign out_valid = (cnt == 0);
    assign p = {x[0] ^ y[0], rp, ry};
endmodule
