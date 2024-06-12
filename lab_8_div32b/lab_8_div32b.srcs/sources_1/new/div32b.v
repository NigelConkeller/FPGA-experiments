`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 17:01:24
// Design Name: 
// Module Name: div8b
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


module div32b(
    input clk, //ʱ��
    input rst_n, //��λ�źţ�����Ч
    input [31:0] x, //������
    input [15:0] y, //����
    input in_valid, //����Ϊ1ʱ����ʾ����׼�����ˣ���ʼ��������
    output [31:0] q, //��
    output [15:0] r, //����
    output out_valid, //�����������ʱ�����Ϊ1
    output in_error //�����������Ϊ0ʱ�����Ϊ1
    );
    reg [5:0] cnt;
    always @ (posedge clk) begin
        if (!rst_n) cnt <= 0;
        else if (in_valid) cnt <= 34;
        else if (cnt != 0) cnt <= cnt - 1;
    end
    reg [32:0] rq;
    reg [15:0] rr;
    always @ (posedge clk) begin
        if (!rst_n) {rr, rq} <= {49'b0};
        else if (in_valid) {rr, rq} <= x[31] == 0 ? {16'h0000, x, 1'b0} : {16'hffff, x, 1'b0};
        else if (cnt != 0) begin
            if (cnt == 1) begin
                if (x[31] != y[15]) rq = rq + 1;
                if (rr[15] != x[31]) begin
                    if (x[31] == y[15]) rr = r + y;
                    else rr = rr - y;
                end
            end
            else begin
                if (cnt != 10) {rr, rq} = {rr, rq} << 1;
                if (cnt == 10 || rq[1] == 0) rr = rr + y;
                else rr = rr - y;
                if (rr[15] == y[15]) rq[0] = 1;
                else rq[0] = 0;
            end
        end
    end
    assign q = cnt == 34 ? x : rq[31:0];
    assign r = cnt <= 2 ? {rr} :{rr, rq[32]};
    assign out_valid = (cnt == 0);
    assign in_error = (x == 0 || y == 0);
endmodule