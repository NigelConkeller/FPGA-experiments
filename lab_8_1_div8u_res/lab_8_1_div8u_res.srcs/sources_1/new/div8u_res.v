`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 13:07:25
// Design Name: 
// Module Name: div8u_res
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


module div8u_res(   
    input clk, //ʱ��
    input rst_n, //��λ�źţ�����Ч
    input [7:0] x, //������
    input [3:0] y, //����
    input in_valid, //����Ϊ1ʱ����ʾ����׼�����ˣ���ʼ��������
    output reg [7:0] q, //��
    output reg [3:0] r, //����
    output out_valid, //�����������ʱ�����Ϊ1
    output in_error //�����������Ϊ0ʱ�����Ϊ1
    );
    reg [3:0] cnt;
    always @ (posedge clk) begin
        if (!rst_n) cnt <= 0;
        else if (in_valid) cnt <= 9;
        else if (cnt != 0) cnt <= cnt - 1;
    end
    always @ (posedge clk) begin
        if (!rst_n) {r, q} <= {12'b0};
        else if (in_valid) {r, q} <= {8'b0, x};
        else if (cnt != 0) begin
            if (r >= y) {r, q} = {r - y, q, 1'b1};
            else {r, q} = {r, q, 1'b0};
            if (cnt == 1) r = r >> 1;
        end
    end
    assign out_valid = (cnt == 0);
    assign in_error = (x == 0 || y == 0);
endmodule
